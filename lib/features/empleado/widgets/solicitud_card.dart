/// @file    solicitud_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tarjeta de solicitud de visita — perspectiva del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';

class SolicitudEmpleadoCard extends StatelessWidget {
  const SolicitudEmpleadoCard({
    super.key,
    required this.visitante,
    required this.empresa,
    required this.fecha,
    required this.estado,
  });

  final String visitante, empresa, fecha, estado;

  Color get _badgeColor => switch (estado) {
    'aprobada'  => AppColors.success,
    'rechazada' => AppColors.error,
    _           => AppColors.warning,
  };

  String get _badgeLabel => switch (estado) {
    'aprobada'  => 'Aprobada',
    'rechazada' => 'Rechazada',
    _           => 'Pendiente',
  };

  IconData get _badgeIcon => switch (estado) {
    'aprobada'  => AppIcons.circleCheck,
    'rechazada' => AppIcons.circleXmark,
    _           => AppIcons.clock,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.appBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: AppColors.iceBlue,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(
              child: FaIcon(AppIcons.person, size: 20, color: AppColors.tertiary),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(visitante, style: AppTextStyles.bodyBold),
                const SizedBox(height: 2),
                Text(empresa, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Row(children: [
                  const FaIcon(AppIcons.clock, size: 10, color: AppColors.iconGray),
                  const SizedBox(width: 4),
                  Text(fecha, style: AppTextStyles.caption),
                ]),
              ],
            ),
          ),

          // Badge de estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _badgeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              FaIcon(_badgeIcon, size: 10, color: _badgeColor),
              const SizedBox(width: 4),
              Text(_badgeLabel,
                  style: AppTextStyles.caption
                      .copyWith(color: _badgeColor, fontWeight: FontWeight.w600)),
            ]),
          ),
        ],
      ),
    );
  }
}
