/// =============================================================================
/// home_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del shell principal. Gestiona la pestaña activa del
/// BottomNavigationBar (Figura 38 del MPF).
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  int _indiceActual = 0;
  int get indiceActual => _indiceActual;

  void cambiarIndice(int i) {
    if (i == _indiceActual) return;
    _indiceActual = i;
    notifyListeners();
  }
}
