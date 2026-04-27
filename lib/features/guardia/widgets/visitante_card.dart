/// @file    visitante_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tarjeta de visitante con todas las acciones del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';
import '../model/visitante_model.dart';

/// Botón de acción inline para las tarjetas del Guardia.
class BtnAccion extends StatelessWidget {
  const BtnAccion({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String       label;
  final IconData     icon;
  final Color        color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withOpacity(0.35)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(icon, size: 13, color: color),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTextStyles.captionBold.copyWith(color: color)),
        ]),
      ),
    );
  }
}

/// Tarjeta de visitante con encabezado, tiempo transcurrido y acciones.
class VisitanteCard extends StatelessWidget {
  const VisitanteCard({
    super.key,
    required this.visitante,
    this.tiempoTranscurrido,
    this.onEntrada,
    this.onSalidaOficina,
    this.onSalidaInstituto,
  });

  final Visitante     visitante;
  final String?       tiempoTranscurrido;
  final VoidCallback? onEntrada;
  final VoidCallback? onSalidaOficina;
  final VoidCallback? onSalidaInstituto;

  @override
  Widget build(BuildContext context) {
    final est   = visitante.estatus;
    final color = est.color;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.appBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Encabezado ─────────────────────────────────────────────
        Row(children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(
                child: FaIcon(AppIcons.person, size: 22, color: color)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(visitante.nombre, style: AppTextStyles.bodyBold),
              const SizedBox(height: 2),
              Row(children: [
                FaIcon(AppIcons.building, size: 10, color: AppColors.iconGray),
                const SizedBox(width: 4),
                Expanded(
                    child: Text(visitante.destino,
                        style: AppTextStyles.caption,
                        overflow: TextOverflow.ellipsis)),
              ]),
              Row(children: [
                FaIcon(AppIcons.clock, size: 10, color: AppColors.iconGray),
                const SizedBox(width: 4),
                Text('Estimada: ${visitante.horaEstimada}',
                    style: AppTextStyles.caption),
              ]),
            ]),
          ),
          // Badge de estatus
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: 4),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              FaIcon(est.icon, size: 10, color: color),
              const SizedBox(width: 3),
              Text(est.label,
                  style: AppTextStyles.caption
                      .copyWith(color: color, fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),

        // ── Tiempo transcurrido ─────────────────────────────────────
        if (tiempoTranscurrido != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const FaIcon(AppIcons.clockRotateLeft,
                  size: 11, color: AppColors.warning),
              const SizedBox(width: AppSpacing.xs),
              Text('Tiempo en el instituto: $tiempoTranscurrido',
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.warning)),
            ]),
          ),
        ],

        // ── Acciones ────────────────────────────────────────────────
        if (onEntrada != null ||
            onSalidaOficina != null ||
            onSalidaInstituto != null) ...[
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (onEntrada != null)
                BtnAccion(
                    label: 'Confirmar llegada al instituto',
                    icon: AppIcons.doorEnter,
                    color: AppColors.success,
                    onTap: onEntrada!),
              if (onSalidaOficina != null) ...[
                const SizedBox(height: AppSpacing.xs),
                BtnAccion(
                    label: 'Salió de la oficina',
                    icon: AppIcons.personWalking,
                    color: AppColors.info,
                    onTap: onSalidaOficina!),
              ],
              if (onSalidaInstituto != null) ...[
                const SizedBox(height: AppSpacing.xs),
                BtnAccion(
                    label: 'Confirmar salida del instituto',
                    icon: AppIcons.doorExit,
                    color: AppColors.error,
                    onTap: onSalidaInstituto!),
              ],
            ],
          ),
        ],

        // Chip informativo — salidoInstituto
        if (est == EstatusVisita.salidoInstituto) ...[
          const SizedBox(height: AppSpacing.xs),
          Row(children: [
            FaIcon(AppIcons.circleCheck,
                size: 12, color: AppColors.iconGray),
            const SizedBox(width: AppSpacing.xs),
            Text('Salió del instituto',
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.iconGray)),
          ]),
        ],
      ]),
    );
  }
}
