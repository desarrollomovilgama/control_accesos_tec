/// @file    visitante_emp_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tarjeta de visitante con acciones — perspectiva del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';
import '../model/visitante_emp_model.dart';

/// Botón de acción inline para el panel de visitantes.
class BtnEmp extends StatelessWidget {
  const BtnEmp({
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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withOpacity(0.35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 14, color: color),
            const SizedBox(width: AppSpacing.sm),
            Text(label,
                style: AppTextStyles.captionBold.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta de visitante con indicadores de estado y botones de acción.
class VisitanteEmpCard extends StatelessWidget {
  const VisitanteEmpCard({
    super.key,
    required this.visitante,
    this.onLlegadaOficina,
    this.onSalidaOficina,
  });

  final VisitanteEmp  visitante;
  final VoidCallback? onLlegadaOficina;
  final VoidCallback? onSalidaOficina;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Encabezado ────────────────────────────────────────────
          Row(children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Center(
                child: FaIcon(AppIcons.person, size: 22, color: color),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(visitante.nombre, style: AppTextStyles.bodyBold),
                  const SizedBox(height: 2),
                  Row(children: [
                    FaIcon(AppIcons.email, size: 10, color: AppColors.iconGray),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(visitante.correo,
                          style: AppTextStyles.caption,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                  const SizedBox(height: 2),
                  Row(children: [
                    FaIcon(AppIcons.clock, size: 10, color: AppColors.iconGray),
                    const SizedBox(width: 4),
                    Text('Estimada: ${visitante.horaEstimada}',
                        style: AppTextStyles.caption),
                  ]),
                ],
              ),
            ),

            // Badge de estatus
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                FaIcon(est.icon, size: 10, color: color),
                const SizedBox(width: 3),
                Text(est.label,
                    style: AppTextStyles.caption.copyWith(
                        color: color, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),

          // ── Botones de acción ────────────────────────────────────
          if (onLlegadaOficina != null || onSalidaOficina != null) ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
          ],

          if (onLlegadaOficina != null)
            BtnEmp(
              label : 'Llegó a mi oficina',
              icon  : AppIcons.building,
              color : AppColors.success,
              onTap : onLlegadaOficina!,
            ),

          if (onSalidaOficina != null)
            BtnEmp(
              label : 'Salió de mi oficina',
              icon  : AppIcons.personWalking,
              color : AppColors.info,
              onTap : onSalidaOficina!,
            ),

          // Chip informativo — salidoOficina
          if (est == EstatusVisitante.salidoOficina) ...[
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.06),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Row(children: [
                FaIcon(AppIcons.circleInfo, size: 11, color: AppColors.info),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Salió de tu oficina — sigue en el instituto',
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.info),
                ),
              ]),
            ),
          ],

          // Chip informativo — salidoInstituto
          if (est == EstatusVisitante.salidoInstituto) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(children: [
              FaIcon(AppIcons.circleCheck, size: 12, color: AppColors.iconGray),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Salió del instituto',
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.iconGray),
              ),
            ]),
          ],
        ],
      ),
    );
  }
}
