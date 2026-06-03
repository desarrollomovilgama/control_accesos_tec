/// @file: session_storage_service.dart
/// @project: Control de Accesos - GAMA
/// @description: Servicio de persistencia segura de sesión usando
///   Flutter Secure Storage (MPF §7.2). Guarda el perfil SAM y la sesión
///   del Guardia entre reinicios de la app en almacenamiento cifrado del SO.
///   La sesión se borra únicamente al hacer logout explícito.
/// @author: Luis Antonio Tarango Regis
/// @version: 2.0.0
/// @last_update: 2026-05-29

library;

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/data/models/sam_response_model.dart';
import '../../features/auth/model/guardia_session.dart';

/// Claves de almacenamiento usadas por este servicio.
abstract class _Keys {
  static const samSession     = 'gama_sam_session';
  static const guardiaSession = 'gama_guardia_session';
}

/// Opciones de FlutterSecureStorage compartidas por todas las operaciones.
///
/// Android: usa EncryptedSharedPreferences (AES-256).
/// iOS: usa el Keychain del sistema.
const _storage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Servicio estático para guardar y restaurar sesiones entre reinicios.
///
/// Todos los datos se almacenan cifrados mediante el mecanismo nativo del SO.
/// Ningún valor se escribe en SharedPreferences ni en texto plano.
abstract class SessionStorageService {
  // ── SAM (Anfitrión / Autorizador) ─────────────────────────────────────────

  /// Persiste el perfil SAM del usuario autenticado de forma segura.
  static Future<void> saveSamSession(SamUserModel model) async {
    await _storage.write(
      key: _Keys.samSession,
      value: jsonEncode(model.toJson()),
    );
  }

  /// Restaura el perfil SAM guardado. Retorna `null` si no hay sesión.
  static Future<SamUserModel?> loadSamSession() async {
    final raw = await _storage.read(key: _Keys.samSession);
    if (raw == null) return null;
    try {
      return SamUserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Dato corrupto — limpiar y tratar como sin sesión.
      await clearSamSession();
      return null;
    }
  }

  /// Elimina la sesión SAM persistida.
  static Future<void> clearSamSession() async {
    await _storage.delete(key: _Keys.samSession);
  }

  // ── Guardia ───────────────────────────────────────────────────────────────

  /// Persiste la sesión del Guardia (número de teléfono) de forma segura.
  static Future<void> saveGuardiaSession(GuardiaSession session) async {
    await _storage.write(
      key: _Keys.guardiaSession,
      value: session.telefono,
    );
  }

  /// Restaura la sesión del Guardia. Retorna `null` si no hay sesión.
  static Future<GuardiaSession?> loadGuardiaSession() async {
    final telefono = await _storage.read(key: _Keys.guardiaSession);
    if (telefono == null || telefono.isEmpty) return null;
    return GuardiaSession(telefono: telefono);
  }

  /// Elimina la sesión del Guardia persistida.
  static Future<void> clearGuardiaSession() async {
    await _storage.delete(key: _Keys.guardiaSession);
  }

  // ── Limpieza total ────────────────────────────────────────────────────────

  /// Elimina TODAS las sesiones persistidas (llamar en logout).
  static Future<void> clearAll() async {
    await Future.wait([
      clearSamSession(),
      clearGuardiaSession(),
    ]);
  }
}
