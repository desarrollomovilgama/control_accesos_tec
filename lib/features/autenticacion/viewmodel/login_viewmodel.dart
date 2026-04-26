/// =============================================================================
/// login_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo de autenticación. Apartado 4.3 del MPF.
/// SOLO MAQUETA: simula el login con un Future.delayed. La integración real
/// con el Web Service SAM se implementará en una iteración posterior.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/usuario_model.dart';

enum LoginEstado { idle, cargando, exito, error }

class LoginViewModel extends ChangeNotifier {
  LoginEstado _estado = LoginEstado.idle;
  String? _error;
  Usuario? _usuario;

  LoginEstado get estado => _estado;
  String? get error => _error;
  Usuario? get usuario => _usuario;
  bool get cargando => _estado == LoginEstado.cargando;

  /// Mock de inicio de sesión. Reemplazar por consumo real al WS SAM.
  Future<bool> iniciarSesion({
    required String usuario,
    required String password,
  }) async {
    if (usuario.trim().isEmpty || password.isEmpty) {
      _estado = LoginEstado.error;
      _error = 'Usuario y contraseña son obligatorios.';
      notifyListeners();
      return false;
    }

    _estado = LoginEstado.cargando;
    _error = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 800));

    _usuario = Usuario.demo();
    _estado = LoginEstado.exito;
    notifyListeners();
    return true;
  }

  void reset() {
    _estado = LoginEstado.idle;
    _error = null;
    notifyListeners();
  }
}
