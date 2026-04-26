/// =============================================================================
/// perfil_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel mínimo para el perfil (datos demo).
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

class PerfilViewModel extends ChangeNotifier {
  String nombre = 'Usuario Demo';
  String correo = 'demo@toluca.tecnm.mx';
  String rol = 'Docente';
}
