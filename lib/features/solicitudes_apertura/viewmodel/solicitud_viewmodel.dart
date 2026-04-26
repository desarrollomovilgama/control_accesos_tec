/// =============================================================================
/// solicitud_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo solicitudes de apertura.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/solicitud_model.dart';

class SolicitudViewModel extends ChangeNotifier {
  TipoSolicitud _tipo = TipoSolicitud.apertura;
  TipoSolicitud get tipo => _tipo;

  void cambiarTipo(TipoSolicitud t) {
    _tipo = t;
    notifyListeners();
  }
}
