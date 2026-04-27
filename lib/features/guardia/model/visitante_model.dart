/// @file    visitante_model.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Modelo y estados del visitante — perspectiva del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';

// ─── Ciclo de vida del visitante (perspectiva Guardia) ───────────────────────
enum EstatusVisita {
  enEspera,
  enInstituto,
  enOficina,
  salidoOficina,
  salidoInstituto,
}

extension EstatusVisitaExt on EstatusVisita {
  String get label => switch (this) {
    EstatusVisita.enEspera         => 'En espera',
    EstatusVisita.enInstituto      => 'En instituto',
    EstatusVisita.enOficina        => 'En oficina',
    EstatusVisita.salidoOficina    => 'Salió de oficina',
    EstatusVisita.salidoInstituto  => 'Salió del instituto',
  };

  Color get color => switch (this) {
    EstatusVisita.enEspera         => AppColors.iconGray,
    EstatusVisita.enInstituto      => AppColors.warning,
    EstatusVisita.enOficina        => AppColors.success,
    EstatusVisita.salidoOficina    => AppColors.info,
    EstatusVisita.salidoInstituto  => AppColors.borderGray,
  };

  IconData get icon => switch (this) {
    EstatusVisita.enEspera         => AppIcons.hourglassHalf,
    EstatusVisita.enInstituto      => AppIcons.doorEnter,
    EstatusVisita.enOficina        => AppIcons.building,
    EstatusVisita.salidoOficina    => AppIcons.personWalking,
    EstatusVisita.salidoInstituto  => AppIcons.doorExit,
  };

  bool get dentroDelInstituto =>
      this == EstatusVisita.enInstituto ||
      this == EstatusVisita.enOficina   ||
      this == EstatusVisita.salidoOficina;
}

// ─── Modelo ──────────────────────────────────────────────────────────────────
class Visitante {
  Visitante({
    required this.id,
    required this.nombre,
    required this.destino,
    required this.horaEstimada,
    this.entradaAt,
    required this.estatus,
  });

  final String  id;
  final String  nombre;
  final String  destino;
  final String  horaEstimada;
  DateTime?     entradaAt;
  EstatusVisita estatus;
}
