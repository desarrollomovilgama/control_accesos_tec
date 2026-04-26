/// =============================================================================
/// escaneo_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo de escaneo QR. Apartado 4.3 del MPF.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

enum EscaneoEstado { idle, escaneando, exito, error, sinConexion }

class EscaneoViewModel extends ChangeNotifier {
  EscaneoEstado _estado = EscaneoEstado.idle;
  String? _ultimoCodigo;
  String? _error;

  EscaneoEstado get estado => _estado;
  String? get ultimoCodigo => _ultimoCodigo;
  String? get error => _error;

  void registrarCodigo(String codigo) {
    _ultimoCodigo = codigo;
    _estado = EscaneoEstado.exito;
    notifyListeners();
  }

  void marcarError(String mensaje) {
    _estado = EscaneoEstado.error;
    _error = mensaje;
    notifyListeners();
  }

  void reset() {
    _estado = EscaneoEstado.idle;
    _ultimoCodigo = null;
    _error = null;
    notifyListeners();
  }
}
