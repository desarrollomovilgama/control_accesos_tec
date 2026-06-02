/// @file: anfitrion_visitantes_viewmodel.dart
/// @project: Control de Accesos - GAMA
/// @description: ViewModel del tab "Mis Visitantes" del Anfitrión.
///   Carga los visitantes activos del día, registra eventos de llegada/salida
///   de oficina y emite alertas de tiempo excesivo entre estados de visita.
///   Referencia: RF-13 del Proyecto C — Control de Accesos.
/// @author: Luis Antonio Tarango Regis
/// @version: 2.0.0
/// @last_update: 2026-05-31

library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/session_provider.dart';
import '../../data/models/access_log_db_model.dart';
import '../../data/repositories/access_log_repository.dart';
import '../../data/repositories/request_repository.dart';

// ── Alertas de tiempo ─────────────────────────────────────────────────────────

/// Tipo de alerta de tiempo transcurrido entre estados de visita.
enum VisitAlertType {
  /// Visitante lleva > 30 min en el instituto sin llegar a la oficina.
  entradaTardanza,

  /// Visitante lleva > 30 min desde que salió de la oficina sin salir del ITT.
  salidaOficinaTardanza,
}

/// Alerta de tiempo excesivo asociada a un visitante concreto.
class VisitAlert {
  const VisitAlert({required this.dto, required this.type});

  final ActiveVisitDto dto;
  final VisitAlertType type;

  String get visitorName => dto.visitor.fullName;

  String get message => switch (type) {
    VisitAlertType.entradaTardanza =>
      '$visitorName lleva más de 30 min en el instituto sin llegar a tu oficina.',
    VisitAlertType.salidaOficinaTardanza =>
      '$visitorName lleva más de 30 min saliendo del instituto.',
  };
}

// ── Estado ────────────────────────────────────────────────────────────────────

@immutable
class AnfitrionVisitantesState {
  const AnfitrionVisitantesState({
    this.visitantes = const [],
    this.pendingExtensions = const [],
    this.pendingAlerts = const [],
    this.isLoading = false,
    this.errorMsg = '',
    this.processingItemId,
    this.processingExtensionId,
  });

  final List<ActiveVisitDto> visitantes;
  final List<ExtensionDto> pendingExtensions;

  /// Alertas de tiempo que acaban de dispararse en este ciclo de polling.
  /// La vista consume esta lista y se vacía en el siguiente poll.
  final List<VisitAlert> pendingAlerts;

  final bool isLoading;
  final String errorMsg;
  final int? processingItemId;
  final int? processingExtensionId;

  bool get hasError => errorMsg.isNotEmpty;
  bool get hasPendingExtensions => pendingExtensions.isNotEmpty;

  bool isProcessing(int itemId) => processingItemId == itemId;
  bool isProcessingExtension(int requestId) =>
      processingExtensionId == requestId;

  AnfitrionVisitantesState copyWith({
    List<ActiveVisitDto>? visitantes,
    List<ExtensionDto>? pendingExtensions,
    List<VisitAlert>? pendingAlerts,
    bool? isLoading,
    String? errorMsg,
    int? processingItemId,
    int? processingExtensionId,
    bool clearProcessing = false,
    bool clearExtProcessing = false,
  }) {
    return AnfitrionVisitantesState(
      visitantes: visitantes ?? this.visitantes,
      pendingExtensions: pendingExtensions ?? this.pendingExtensions,
      pendingAlerts: pendingAlerts ?? this.pendingAlerts,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      processingItemId:
          clearProcessing ? null : (processingItemId ?? this.processingItemId),
      processingExtensionId: clearExtProcessing
          ? null
          : (processingExtensionId ?? this.processingExtensionId),
    );
  }
}

// ── ViewModel ─────────────────────────────────────────────────────────────────

class AnfitrionVisitantesViewModel
    extends Notifier<AnfitrionVisitantesState> {
  late final AccessLogRepository _logRepo;
  late final RequestRepository _requestRepo;
  Timer? _extensionPollTimer;

  /// Sets de itemIds para los que ya se emitió la alerta correspondiente.
  /// Evitan repetir la misma alerta en cada ciclo de polling.
  final Set<int> _alertedEntradaIds = {};
  final Set<int> _alertedSalidaIds = {};

  @override
  AnfitrionVisitantesState build() {
    _logRepo = ref.read(accessLogRepositoryProvider);
    _requestRepo = ref.read(requestRepositoryProvider);
    Future.microtask(_load);
    _extensionPollTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) async {
        await _pollExtensions();
        await _loadSilent();
      },
    );
    ref.onDispose(() => _extensionPollTimer?.cancel());
    return const AnfitrionVisitantesState(isLoading: true);
  }

  // ── Carga de datos ────────────────────────────────────────────────────────

  Future<void> _load() async {
    final session = ref.read(sessionProvider);
    if (session == null) {
      state = state.copyWith(
        isLoading: false,
        errorMsg: 'Sesión no disponible.',
        clearProcessing: true,
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMsg: '', clearProcessing: true);
    try {
      final data = await _logRepo.getActiveVisitsForHost(
        session.correo,
        DateTime.now(),
      );
      state = state.copyWith(isLoading: false, visitantes: data);
    } catch (e) {
      debugPrint('[AnfitrionVisitantesVM] Error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMsg: 'Error al cargar visitantes. Intenta de nuevo.',
      );
    }
  }

  /// Recarga silenciosa usada por el timer de polling.
  /// También evalúa alertas de tiempo y las emite si son nuevas.
  Future<void> _loadSilent() async {
    final session = ref.read(sessionProvider);
    if (session == null) return;
    try {
      final data = await _logRepo.getActiveVisitsForHost(
        session.correo,
        DateTime.now(),
      );

      final newAlerts = _detectAlerts(data);

      state = state.copyWith(
        visitantes: data,
        // Siempre actualiza pendingAlerts: la vista reacciona cuando es
        // no vacío; en el siguiente poll vuelve a [] si no hay nuevas.
        pendingAlerts: newAlerts,
      );
    } catch (_) {}
  }

  // ── Detección de alertas de tiempo ────────────────────────────────────────

  List<VisitAlert> _detectAlerts(List<ActiveVisitDto> visitas) {
    final alerts = <VisitAlert>[];
    for (final dto in visitas) {
      final id = dto.item.itemId;
      if (id == null) continue;

      if (dto.needsEntradaAlert && !_alertedEntradaIds.contains(id)) {
        _alertedEntradaIds.add(id);
        alerts.add(VisitAlert(dto: dto, type: VisitAlertType.entradaTardanza));
      }
      if (dto.needsSalidaOficinaAlert && !_alertedSalidaIds.contains(id)) {
        _alertedSalidaIds.add(id);
        alerts.add(VisitAlert(dto: dto, type: VisitAlertType.salidaOficinaTardanza));
      }
    }
    return alerts;
  }

  // ── Acciones ──────────────────────────────────────────────────────────────

  Future<void> confirmarLlegadaOficina(int itemId) async {
    await _registerEvent(itemId, AccessEventType.llegadaOficina);
  }

  Future<void> confirmarSalidaOficina(int itemId) async {
    await _registerEvent(itemId, AccessEventType.salidaOficina);
  }

  Future<void> refresh() => _load();

  // ── Extensiones de llegada tardía ─────────────────────────────────────────

  Future<void> _pollExtensions() async {
    final session = ref.read(sessionProvider);
    if (session == null) return;
    try {
      final extensions = await _requestRepo.findPendingExtensions(session.correo);
      state = state.copyWith(pendingExtensions: extensions);
    } catch (_) {}
  }

  Future<void> aprobarExtension(int requestId) async {
    state = state.copyWith(processingExtensionId: requestId);
    try {
      await _requestRepo.resolveExtension(requestId: requestId, approved: true);
      await _pollExtensions();
    } catch (e) {
      debugPrint('[AnfitrionVisitantesVM] Error aprobando extensión: $e');
    } finally {
      state = state.copyWith(clearExtProcessing: true);
    }
  }

  Future<void> rechazarExtension(int requestId) async {
    state = state.copyWith(processingExtensionId: requestId);
    try {
      await _requestRepo.resolveExtension(requestId: requestId, approved: false);
      await _pollExtensions();
    } catch (e) {
      debugPrint('[AnfitrionVisitantesVM] Error rechazando extensión: $e');
    } finally {
      state = state.copyWith(clearExtProcessing: true);
    }
  }

  // ── Helper privado ────────────────────────────────────────────────────────

  Future<void> _registerEvent(int itemId, AccessEventType event) async {
    state = state.copyWith(processingItemId: itemId, errorMsg: '');
    try {
      await _logRepo.create(AccessLogDbModel(itemId: itemId, eventType: event));
      await _load();
    } catch (e) {
      debugPrint('[AnfitrionVisitantesVM] Error registrando evento: $e');
      state = state.copyWith(
        clearProcessing: true,
        errorMsg: 'Error al registrar. Intenta de nuevo.',
      );
    }
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

final anfitrionVisitantesViewModelProvider = NotifierProvider<
    AnfitrionVisitantesViewModel, AnfitrionVisitantesState>(
  AnfitrionVisitantesViewModel.new,
);
