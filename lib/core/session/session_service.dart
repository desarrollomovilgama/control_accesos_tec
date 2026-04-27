/// =============================================================================
/// session_service.dart
/// -----------------------------------------------------------------------------
/// Servicio global de sesión basado en ChangeNotifier (apartado 4.3 del MPF).
/// Mantiene el usuario autenticado vivo durante toda la ejecución de la app y
/// notifica a las vistas que dependan del rol cuando cambia.
///
/// En esta maqueta solo guarda en memoria. La persistencia real (Hive +
/// flutter_secure_storage) se conectará en una iteración posterior.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../../features/autenticacion/model/usuario_model.dart';

class SessionService extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;
  bool get autenticado => _usuario != null;
  TipoUsuario get rol => _usuario?.tipo ?? TipoUsuario.desconocido;

  bool get esAlumno => _usuario?.esAlumno ?? false;
  bool get esDocente => _usuario?.esDocente ?? false;
  bool get esLaboratorista => _usuario?.esLaboratorista ?? false;

  /// Establece el usuario autenticado tras un login exitoso.
  void setUsuario(Usuario u) {
    _usuario = u;
    notifyListeners();
  }

  /// Limpia la sesión (cierre de sesión).
  void logout() {
    _usuario = null;
    notifyListeners();
  }
}
