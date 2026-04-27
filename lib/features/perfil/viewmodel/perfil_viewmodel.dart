/// =============================================================================
/// perfil_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo Perfil. Lee el usuario actual del SessionService
/// global y expone los datos visibles en la vista.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../../../core/session/session_service.dart';
import '../../autenticacion/model/usuario_model.dart';

class PerfilViewModel extends ChangeNotifier {
  PerfilViewModel(this._session) {
    _session.addListener(notifyListeners);
  }

  final SessionService _session;

  Usuario? get usuario => _session.usuario;

  String get nombre => usuario?.nombre ?? 'Invitado(a)';
  String get correo => usuario?.correo ?? '—';
  String get rol => (usuario?.tipo ?? TipoUsuario.desconocido).label;
  String? get carrera => usuario?.carrera;
  String? get grupo => usuario?.grupo;

  bool get esAlumno => _session.esAlumno;
  bool get esDocente => _session.esDocente;
  bool get esLaboratorista => _session.esLaboratorista;

  void cerrarSesion() {
    _session.logout();
  }

  @override
  void dispose() {
    _session.removeListener(notifyListeners);
    super.dispose();
  }
}
