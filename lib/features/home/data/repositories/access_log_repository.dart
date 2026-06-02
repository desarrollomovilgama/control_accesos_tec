/// @file: access_log_repository.dart
/// @project: Control de Accesos - GAMA
/// @description: Repositorio del registro de accesos. Registra cada evento
///   del ciclo de vida de un visitante y provee el estado actual derivado
///   del último evento. También carga las visitas activas del día para
///   el panel del Guardia y el seguimiento de visitas para Anfitrión
///   y Autorizador.
/// @author: Luis Antonio Tarango Regis
/// @version: 2.0.0
/// @last_update: 2026-05-31

library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/database_service.dart';
import '../models/access_log_db_model.dart';
import '../models/request_db_model.dart';
import '../models/request_item_db_model.dart';
import '../models/visitor_db_model.dart';

/// Repositorio de la tabla `access_logs`.
class AccessLogRepository {
  const AccessLogRepository(this._db);

  final DatabaseService _db;

  // ── Escritura ──────────────────────────────────────────────────────────────

  /// Registra un nuevo evento. `registered_at` se toma de la hora local del
  /// dispositivo vía [AccessLogDbModel.toInsertMap] para evitar el desfase
  /// UTC del servidor Railway.
  Future<void> create(AccessLogDbModel log) async {
    await _db.execute((conn) async {
      await conn.execute(
        '''INSERT INTO access_logs (item_id, event_type, registered_at)
           VALUES (:item_id, :event_type, :registered_at)''',
        log.toInsertMap(),
      );
    });
  }

  // ── Consulta de estado ─────────────────────────────────────────────────────

  /// Retorna el último evento registrado para un ítem.
  Future<AccessLogDbModel?> getLatest(int itemId) async {
    return _db.execute((conn) async {
      final result = await conn.execute(
        '''SELECT * FROM access_logs
           WHERE item_id = :id
           ORDER BY registered_at DESC
           LIMIT 1''',
        {'id': itemId},
      );
      if (result.rows.isEmpty) return null;
      return AccessLogDbModel.fromMap(result.rows.first.assoc());
    });
  }

  /// Retorna el historial completo de eventos de un ítem en orden ASC.
  Future<List<AccessLogDbModel>> getHistory(int itemId) async {
    return _db.execute((conn) async {
      final result = await conn.execute(
        '''SELECT * FROM access_logs
           WHERE item_id = :id
           ORDER BY registered_at ASC''',
        {'id': itemId},
      );
      return result.rows
          .map((r) => AccessLogDbModel.fromMap(r.assoc()))
          .toList();
    });
  }

  // ── Consulta de visitas activas del día ───────────────────────────────────

  /// Visitas del día para el Guardia. Excluye las que ya salieron del instituto.
  Future<List<ActiveVisitDto>> getActiveVisitsForDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    return _db.execute((conn) async {
      final result = await conn.execute(
        '''SELECT
             ri.item_id, ri.request_id, ri.visitor_id,
             ri.access_token, ri.created_at,
             v.full_name, v.email,
             r.building_id, r.scheduled_time, r.tolerance_minutes,
             r.Email_Host, r.visit_type,
             b.building_name
           FROM requests_items ri
           JOIN requests r ON r.request_id = ri.request_id
           JOIN visitors v ON v.visitor_id = ri.visitor_id
           JOIN buildings b ON b.building_id = r.building_id
           WHERE r.scheduled_date = :date
             AND r.status = 'APROBADA'
           ORDER BY r.scheduled_time ASC''',
        {'date': dateStr},
      );

      final dtos = <ActiveVisitDto>[];
      for (final row in result.rows) {
        final map = row.assoc();
        final item = _itemFromMap(map);
        final logs = await getHistory(item.itemId!);
        if (logs.lastOrNull?.eventType == AccessEventType.salidaInstitucion) {
          continue;
        }
        dtos.add(ActiveVisitDto(
          item: item,
          visitor: _visitorFromMap(map),
          logs: logs,
          scheduledTime: map['scheduled_time'],
          toleranceMinutes: int.tryParse(map['tolerance_minutes'] ?? ''),
          visitType: map['visit_type'] != null
              ? VisitTypeDb.fromDbValue(map['visit_type']!)
              : null,
          buildingName: map['building_name'],
        ));
      }
      return dtos;
    });
  }

  /// Todas las visitas del día para un anfitrión (incluye finalizadas para
  /// mostrar el resumen de seguimiento).
  Future<List<ActiveVisitDto>> getActiveVisitsForHost(
    String emailHost,
    DateTime date,
  ) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    return _db.execute((conn) async {
      final result = await conn.execute(
        '''SELECT
             ri.item_id, ri.request_id, ri.visitor_id,
             ri.access_token, ri.created_at,
             v.full_name, v.email,
             r.building_id, r.scheduled_time, r.Email_Host, r.visit_type,
             b.building_name
           FROM requests_items ri
           JOIN requests r ON r.request_id = ri.request_id
           JOIN visitors v ON v.visitor_id = ri.visitor_id
           JOIN buildings b ON b.building_id = r.building_id
           WHERE r.scheduled_date = :date
             AND r.status = 'APROBADA'
             AND r.Email_Host = :email
           ORDER BY r.scheduled_time ASC''',
        {'date': dateStr, 'email': emailHost},
      );

      final dtos = <ActiveVisitDto>[];
      for (final row in result.rows) {
        final map = row.assoc();
        final item = _itemFromMap(map);
        final logs = await getHistory(item.itemId!);
        dtos.add(ActiveVisitDto(
          item: item,
          visitor: _visitorFromMap(map),
          logs: logs,
          scheduledTime: map['scheduled_time'],
          visitType: map['visit_type'] != null
              ? VisitTypeDb.fromDbValue(map['visit_type']!)
              : null,
          buildingName: map['building_name'],
        ));
      }
      return dtos;
    });
  }

  /// Seguimiento de visitantes de una solicitud específica.
  /// Usado por el Autorizador para ver el estado de cada visita aprobada.
  Future<List<ActiveVisitDto>> getVisitorTrackingForRequest(
    int requestId,
  ) async {
    return _db.execute((conn) async {
      final result = await conn.execute(
        '''SELECT
             ri.item_id, ri.request_id, ri.visitor_id,
             ri.access_token, ri.created_at,
             v.full_name, v.email,
             r.scheduled_time, r.visit_type,
             b.building_name
           FROM requests_items ri
           JOIN requests r ON r.request_id = ri.request_id
           JOIN visitors v ON v.visitor_id = ri.visitor_id
           JOIN buildings b ON b.building_id = r.building_id
           WHERE ri.request_id = :id
           ORDER BY ri.item_id ASC''',
        {'id': requestId},
      );

      final dtos = <ActiveVisitDto>[];
      for (final row in result.rows) {
        final map = row.assoc();
        final item = _itemFromMap(map);
        final logs = await getHistory(item.itemId!);
        dtos.add(ActiveVisitDto(
          item: item,
          visitor: _visitorFromMap(map),
          logs: logs,
          scheduledTime: map['scheduled_time'],
          visitType: map['visit_type'] != null
              ? VisitTypeDb.fromDbValue(map['visit_type']!)
              : null,
          buildingName: map['building_name'],
        ));
      }
      return dtos;
    });
  }

  // ── Helpers privados ──────────────────────────────────────────────────────

  static RequestItemDbModel _itemFromMap(Map<String, String?> map) =>
      RequestItemDbModel.fromMap({
        'item_id': map['item_id'],
        'request_id': map['request_id'],
        'visitor_id': map['visitor_id'],
        'access_token': map['access_token'],
        'created_at': map['created_at'],
      });

  static VisitorDbModel _visitorFromMap(Map<String, String?> map) =>
      VisitorDbModel(
        visitorId: int.parse(map['visitor_id']!),
        fullName: map['full_name']!,
        email: map['email'],
      );
}

// ── DTO ───────────────────────────────────────────────────────────────────────

/// DTO que agrupa un ítem con su visitante y el historial completo de eventos.
/// Proporciona timestamps por etapa y getters de alerta (> 30 min).
class ActiveVisitDto {
  const ActiveVisitDto({
    required this.item,
    required this.visitor,
    this.logs = const [],
    this.scheduledTime,
    this.toleranceMinutes,
    this.visitType,
    this.buildingName,
  });

  final RequestItemDbModel item;
  final VisitorDbModel visitor;

  /// Historial cronológico de eventos (ASC). Vacío si el visitante no ha
  /// llegado aún.
  final List<AccessLogDbModel> logs;

  final String? scheduledTime;
  final int? toleranceMinutes;
  final VisitTypeDb? visitType;
  final String? buildingName;

  // ── Derivados ──────────────────────────────────────────────────────────────

  AccessLogDbModel? get lastLog => logs.isNotEmpty ? logs.last : null;
  AccessEventType? get currentEvent => lastLog?.eventType;
  bool get isEspontanea => visitType == VisitTypeDb.espontaneo;
  bool get isFinished => currentEvent == AccessEventType.salidaInstitucion;

  // ── Timestamps por etapa ───────────────────────────────────────────────────

  DateTime? get entradaAt => _logAt(AccessEventType.entradaInstitucion);
  DateTime? get llegadaOficinaAt => _logAt(AccessEventType.llegadaOficina);
  DateTime? get salidaOficinaAt => _logAt(AccessEventType.salidaOficina);
  DateTime? get salidaInstitucionAt =>
      _logAt(AccessEventType.salidaInstitucion);

  DateTime? _logAt(AccessEventType type) =>
      logs.where((l) => l.eventType == type).firstOrNull?.registeredAt;

  // ── Umbrales de alerta (lógica lista; envío de notificaciones pendiente) ───

  /// True cuando el visitante lleva más de 30 min en el instituto sin llegar
  /// a la oficina del anfitrión.
  bool get needsEntradaAlert {
    final at = entradaAt;
    if (at == null || llegadaOficinaAt != null) return false;
    return DateTime.now().difference(at).inMinutes >= 30;
  }

  /// True cuando el visitante lleva más de 30 min desde que salió de la
  /// oficina sin registrar salida del instituto.
  bool get needsSalidaOficinaAlert {
    final at = salidaOficinaAt;
    if (at == null || salidaInstitucionAt != null) return false;
    return DateTime.now().difference(at).inMinutes >= 30;
  }

  // ── Utilidades de presentación ─────────────────────────────────────────────

  String get formattedTime {
    if (scheduledTime == null) return '—';
    return scheduledTime!.length >= 5
        ? scheduledTime!.substring(0, 5)
        : scheduledTime!;
  }
}

// ── Providers ─────────────────────────────────────────────────────────────────

final accessLogRepositoryProvider = Provider<AccessLogRepository>(
  (ref) => AccessLogRepository(ref.watch(databaseServiceProvider)),
);

/// Provider para cargar el seguimiento de visitantes de una solicitud.
/// Usado por el Autorizador con carga lazy (FutureProvider.family).
final visitTrackingProvider =
    FutureProvider.family<List<ActiveVisitDto>, int>((ref, requestId) async {
  final repo = ref.read(accessLogRepositoryProvider);
  return repo.getVisitorTrackingForRequest(requestId);
});
