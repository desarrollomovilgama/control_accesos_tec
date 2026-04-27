/// @file    visita_anfitrion_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tarjeta de visita con acciones para el Anfitrión.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class VisitaAnfitrionCard extends StatelessWidget {
  const VisitaAnfitrionCard({
    super.key,
    required this.data,
    required this.pendiente,
  });

  final Map<String, String> data;
  final bool                pendiente;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.appBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado
          Row(children: [
            const FaIcon(AppIcons.anfitrion,
                size: 18, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['nombre']!, style: AppTextStyles.bodyBold),
                  Text(data['empresa']!, style: AppTextStyles.caption),
                ],
              ),
            ),
            Text(data['hora']!,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.textContrast)),
          ]),

          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),

          // Motivo
          Row(children: [
            const FaIcon(AppIcons.circleInfo,
                size: 12, color: AppColors.iconGray),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(data['motivo']!,
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis),
            ),
          ]),

          const SizedBox(height: AppSpacing.md),

          // Botones de acción
          if (pendiente)
            Row(children: [
              Expanded(
                child: PrimaryButton(
                  label   : 'Confirmar',
                  variant : PrimaryButtonVariant.success,
                  icon    : const FaIcon(FontAwesomeIcons.check,
                      size: 12, color: Colors.white),
                  onPressed: () {
                    // TODO: confirmar llegada de visita (RF-13)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Llegada confirmada'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: PrimaryButton(
                  label   : 'Rechazar',
                  variant : PrimaryButtonVariant.danger,
                  icon    : const FaIcon(FontAwesomeIcons.xmark,
                      size: 12, color: Colors.white),
                  onPressed: () {
                    // TODO: rechazar visita
                  },
                ),
              ),
            ])
          else
            PrimaryButton(
              label   : 'Registrar salida',
              variant : PrimaryButtonVariant.outlined,
              icon    : const FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                  size: 12, color: AppColors.primary),
              onPressed: () {
                // TODO: registrar salida de visita (RF-13)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Salida registrada'),
                    backgroundColor: AppColors.info,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
