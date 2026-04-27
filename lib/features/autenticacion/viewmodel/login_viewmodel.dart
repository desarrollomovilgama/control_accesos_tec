/// =============================================================================
/// login_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo de autenticación. Apartado 4.3 del MPF.
/// SOLO MAQUETA: valida el dominio institucional y autentica contra el
/// catálogo de credenciales DEMO. La integración real con el WS SAM se
/// implementará en una iteración posterior.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../../../core/auth/credenciales_demo.dart';
import '../../../core/session/session_service.dart';
import '../model/usuario_model.dart';

enum LoginEstado { idle, cargando, exito, error }

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._session);

  final SessionService _session;

  LoginEstado _estado = LoginEstado.idle;
  String? _error;
  Usuario? _usuario;

  LoginEstado get estado => _estado;
  String? get error => _error;
  Usuario? get usuario => _usuario;
  bool get cargando => _estado == LoginEstado.cargando;

  /// Mock de inicio de sesión.
  ///   1. Valida que ambos campos no estén vacíos.
  ///   2. Valida que el correo termine en el dominio institucional.
  ///   3. Busca la credencial en el catálogo demo.
  ///   4. Si coincide, guarda el usuario en el SessionService global.
  Future<bool> iniciarSesion({
    required String usuario,
    required String password,
  }) async {
    final correo = usuario.trim();

    if (correo.isEmpty || password.isEmpty) {
      _setError('Usuario y contraseña son obligatorios.');
      return false;
    }

    if (!tieneDominioInstitucional(correo)) {
      _setError('El correo debe terminar en $kDominioInstitucional');
      return false;
    }

    _estado = LoginEstado.cargando;
    _error = null;
    notifyListeners();

    // Simulación de latencia de red (será reemplazada por la llamada al WS SAM).
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final credencial = buscarCredencial(correo: correo, password: password);
    if (credencial == null) {
      _setError('Credenciales inválidas. Verifica tu correo y contraseña.');
      return false;
    }

    _usuario = credencial.usuario;
    _session.setUsuario(credencial.usuario);
    _estado = LoginEstado.exito;
    notifyListeners();
    return true;
  }

  void _setError(String mensaje) {
    _estado = LoginEstado.error;
    _error = mensaje;
    notifyListeners();
  }

  void reset() {
    _estado = LoginEstado.idle;
    _error = null;
    notifyListeners();
  }
}
