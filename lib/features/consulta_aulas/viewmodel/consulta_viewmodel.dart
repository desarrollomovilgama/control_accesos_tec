/// =============================================================================
/// consulta_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo Consulta de aulas. Apartado 4.3 del MPF.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/horario_model.dart';

class ConsultaViewModel extends ChangeNotifier {
  String _filtroEdificio = 'Todos';
  String get filtroEdificio => _filtroEdificio;

  static const edificios = ['Todos', 'Edificio A', 'Edificio F', 'Laboratorios'];

  void cambiarEdificio(String e) {
    _filtroEdificio = e;
    notifyListeners();
  }

  /// Datos demo para la maqueta.
  List<AulaResumen> get aulas {
    final base = const [
      AulaResumen(
          codigo: 'A-101',
          edificio: 'Edificio A',
          ocupada: true,
          materiaActual: 'Cálculo Diferencial'),
      AulaResumen(
          codigo: 'A-102', edificio: 'Edificio A', ocupada: false),
      AulaResumen(
          codigo: 'F-203',
          edificio: 'Edificio F',
          ocupada: true,
          materiaActual: 'Auditoría Informática'),
      AulaResumen(
          codigo: 'F-204', edificio: 'Edificio F', ocupada: false),
      AulaResumen(
          codigo: 'LAB-3',
          edificio: 'Laboratorios',
          ocupada: true,
          materiaActual: 'Programación Móvil'),
    ];
    if (_filtroEdificio == 'Todos') return base;
    return base.where((a) => a.edificio == _filtroEdificio).toList();
  }
}
