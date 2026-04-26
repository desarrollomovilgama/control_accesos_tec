/// =============================================================================
/// busqueda_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel del módulo de búsqueda. Apartado 4.3 del MPF.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/resultado_busqueda.dart';

class BusquedaViewModel extends ChangeNotifier {
  String _query = '';
  String get query => _query;

  void actualizarQuery(String q) {
    _query = q.trim();
    notifyListeners();
  }

  // Datos demo estáticos.
  List<ResultadoDocente> get docentes => const [
        ResultadoDocente(
          nombre: 'Mtro. Gamaliel Castro González',
          tieneClase: true,
          aula: 'F-203',
          materia: 'Auditoría Informática',
        ),
        ResultadoDocente(nombre: 'Dra. Mariana López', tieneClase: false),
        ResultadoDocente(
          nombre: 'Mtro. Mauro Sánchez',
          tieneClase: true,
          aula: 'LAB-3',
          materia: 'Programación Móvil',
        ),
      ];

  List<ResultadoMateria> get materias => const [
        ResultadoMateria(
          nombre: 'Auditoría Informática',
          grupo: 'ISC-8A',
          aula: 'F-203',
          horario: '11:00 — 13:00',
        ),
        ResultadoMateria(
          nombre: 'Programación Móvil',
          grupo: 'ISC-8B',
          aula: 'LAB-3',
          horario: '13:00 — 15:00',
        ),
      ];

  List<ResultadoAula> get aulas => const [
        ResultadoAula(codigo: 'A-101', edificio: 'A', disponible: false),
        ResultadoAula(codigo: 'F-203', edificio: 'F', disponible: false),
        ResultadoAula(codigo: 'F-204', edificio: 'F', disponible: true),
      ];
}
