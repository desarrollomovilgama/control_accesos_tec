/// @file    visitante_emp_model.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Modelo y estados del visitante — perspectiva del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';

// ─── Ciclo de vida del visitante (perspectiva Empleado) ─────────────────────
enum EstatusVisitante {
  enEspera,        // No llegó al instituto aún
  enInstituto,     // Guardia confirmó entrada
  enOficina,       // Empleado confirmó llegada a su oficina
  salidoOficina,   // Empleado confirmó salida de su oficina
  salidoInstituto, // Guardia confirmó salida del instituto
}

extension EstatusVisitanteExt on EstatusVisitante {
  String get label => switch (this) {
    EstatusVisitante.enEspera        => 'Esperando llegada',
    EstatusVisitante.enInstituto     => 'Llegó al instituto',
    EstatusVisitante.enOficina       => 'En tu oficina',
    EstatusVisitante.salidoOficina   => 'Salió de tu oficina',
    EstatusVisitante.salidoInstituto => 'Salió del instituto',
  };

  Color get color => switch (this) {
    EstatusVisitante.enEspera        => AppColors.iconGray,
    EstatusVisitante.enInstituto     => AppColors.warning,
    EstatusVisitante.enOficina       => AppColors.success,
    EstatusVisitante.salidoOficina   => AppColors.info,
    EstatusVisitante.salidoInstituto => AppColors.borderGray,
  };

  IconData get icon => switch (this) {
    EstatusVisitante.enEspera        => AppIcons.clock,
    EstatusVisitante.enInstituto     => AppIcons.doorOpen,
    EstatusVisitante.enOficina       => AppIcons.building,
    EstatusVisitante.salidoOficina   => AppIcons.circleInfo,
    EstatusVisitante.salidoInstituto => AppIcons.circleCheck,
  };
}

// ─── Modelo ──────────────────────────────────────────────────────────────────
class VisitanteEmp {
  VisitanteEmp({
    required this.nombre,
    required this.correo,
    required this.horaEstimada,
    required this.estatus,
  });

  final String      nombre;
  final String      correo;
  final String      horaEstimada;
  EstatusVisitante  estatus;
}
