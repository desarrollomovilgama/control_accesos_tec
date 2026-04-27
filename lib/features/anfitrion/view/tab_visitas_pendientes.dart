/// @file    tab_visitas_pendientes.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de visitas pendientes de confirmación — panel del Anfitrión (RF-13).
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../widgets/empty_state.dart';
import '../widgets/visita_anfitrion_card.dart';

class TabVisitasPendientes extends StatelessWidget {
  const TabVisitasPendientes({super.key});

  static const _pendientes = [
    {
      'nombre'  : 'Carlos Mejía',
      'empresa' : 'SoftTech S.A.',
      'motivo'  : 'Reunión de proyecto',
      'hora'    : '10:00',
    },
    {
      'nombre'  : 'Andrea Ríos',
      'empresa' : 'Auditores MX',
      'motivo'  : 'Revisión de contratos',
      'hora'    : '11:30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_pendientes.isEmpty) {
      return const EmptyState(
        icon  : AppIcons.circleCheck,
        label : 'Sin visitas pendientes',
        color : AppColors.success,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: _pendientes.length + 1,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.listItemGap),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(children: [
              Expanded(
                  child: Text('Visitas pendientes',
                      style: AppTextStyles.subtitle)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_pendientes.length}',
                  style: AppTextStyles.captionBold
                      .copyWith(color: AppColors.warning),
                ),
              ),
            ]),
          );
        }
        return VisitaAnfitrionCard(
            data: _pendientes[i - 1], pendiente: true);
      },
    );
  }
}
