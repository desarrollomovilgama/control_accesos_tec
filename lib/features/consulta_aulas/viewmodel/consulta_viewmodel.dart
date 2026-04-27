/// =============================================================================
/// consulta_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo Consulta de aulas. Apartado 4.3 del MPF.
/// Mantiene la lista visible (con filtro por edificio) y permite agregar
/// nuevas aulas en memoria mientras la app esté en modo maqueta.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/horario_model.dart';

class ConsultaViewModel extends ChangeNotifier {
  String _filtroEdificio = 'Todos';
  String get filtroEdificio => _filtroEdificio;

  static const edificios = [
    'Todos',
    'Edificio A',
    'Edificio F',
    'Laboratorios',
  ];

  /// Edificios disponibles al registrar un aula nueva (sin "Todos").
  static const edificiosDisponibles = [
    'Edificio A',
    'Edificio F',
    'Laboratorios',
  ];

  /// Catálogo demo + aulas agregadas durante la sesión.
  final List<AulaResumen> _aulas = [
    const AulaResumen(
      codigo: 'A-101',
      edificio: 'Edificio A',
      ocupada: true,
      materiaActual: 'Cálculo Diferencial',
      piso: 1,
      capacidad: 35,
    ),
    const AulaResumen(
      codigo: 'A-102',
      edificio: 'Edificio A',
      ocupada: false,
      piso: 1,
      capacidad: 40,
    ),
    const AulaResumen(
      codigo: 'F-203',
      edificio: 'Edificio F',
      ocupada: true,
      materiaActual: 'Auditoría Informática',
      piso: 2,
      capacidad: 30,
    ),
    const AulaResumen(
      codigo: 'F-204',
      edificio: 'Edificio F',
      ocupada: false,
      piso: 2,
      capacidad: 30,
    ),
    const AulaResumen(
      codigo: 'LAB-3',
      edificio: 'Laboratorios',
      ocupada: true,
      materiaActual: 'Programación Móvil',
      tipo: TipoAula.laboratorio,
      piso: 1,
      capacidad: 25,
      equipamiento: '25 PCs, proyector, pizarra',
    ),
  ];

  void cambiarEdificio(String e) {
    _filtroEdificio = e;
    notifyListeners();
  }

  /// Lista (filtrada por edificio) consumida por la vista.
  List<AulaResumen> get aulas {
    if (_filtroEdificio == 'Todos') return List.unmodifiable(_aulas);
    return _aulas.where((a) => a.edificio == _filtroEdificio).toList();
  }

  /// Indica si ya existe un aula con el mismo código (case-insensitive).
  bool existeCodigo(String codigo) {
    final norm = codigo.trim().toUpperCase();
    return _aulas.any((a) => a.codigo.toUpperCase() == norm);
  }

  /// Agrega un aula al catálogo en memoria. Devuelve `false` si el código
  /// ya existe (no se duplica).
  bool agregarAula(AulaResumen nueva) {
    if (existeCodigo(nueva.codigo)) return false;
    _aulas.add(nueva);
    notifyListeners();
    return true;
  }
}
