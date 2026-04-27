/// @file    tab_visitas_activas.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de visitantes en curso — panel del Anfitrión (RF-13).
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../widgets/empty_state.dart';
import '../widgets/visita_anfitrion_card.dart';

class TabVisitasActivas extends StatelessWidget {
  const TabVisitasActivas({super.key});

  static const _activas = [
    {
      'nombre'  : 'Roberto Fuentes',
      'empresa' : 'Consultoría JF',
      'motivo'  : 'Capacitación',
      'hora'    : '09:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_activas.isEmpty) {
      return const EmptyState(
        icon  : AppIcons.users,
        label : 'No hay visitas activas',
        color : AppColors.tertiary,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: _activas.length + 1,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.listItemGap),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text('Visitantes en instalaciones',
                style: AppTextStyles.subtitle),
          );
        }
        return VisitaAnfitrionCard(
            data: _activas[i - 1], pendiente: false);
      },
    );
  }
}
