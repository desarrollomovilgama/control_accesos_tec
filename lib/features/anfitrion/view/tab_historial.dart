/// @file    tab_historial.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de historial de visitas del día — panel del Anfitrión.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';

class TabHistorial extends StatelessWidget {
  const TabHistorial({super.key});

  static const _historial = [
    {'nombre': 'María López',  'hora': '07:30', 'tipo': 'Entrada'},
    {'nombre': 'María López',  'hora': '12:15', 'tipo': 'Salida'},
    {'nombre': 'Pedro Romero', 'hora': '08:00', 'tipo': 'Entrada'},
    {'nombre': 'Pedro Romero', 'hora': '11:45', 'tipo': 'Salida'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: _historial.length + 1,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text('Historial de hoy', style: AppTextStyles.subtitle),
          );
        }
        final h         = _historial[i - 1];
        final isEntrada = h['tipo'] == 'Entrada';
        final color     = isEntrada ? AppColors.success : AppColors.error;

        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Center(
              child: FaIcon(
                isEntrada
                    ? FontAwesomeIcons.arrowRightToBracket
                    : FontAwesomeIcons.arrowRightFromBracket,
                size: 15,
                color: color,
              ),
            ),
          ),
          title: Text(h['nombre']!, style: AppTextStyles.bodyBold),
          subtitle: Text(h['tipo']!, style: AppTextStyles.caption),
          trailing: Text(h['hora']!,
              style: AppTextStyles.captionBold
                  .copyWith(color: AppColors.textContrast)),
        );
      },
    );
  }
}
