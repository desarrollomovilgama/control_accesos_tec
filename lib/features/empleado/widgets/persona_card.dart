/// @file    persona_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tarjeta de persona adicional en el formulario de solicitud.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Modelo para cada persona adicional en la solicitud.
class PersonaAdicional {
  PersonaAdicional()
      : nombreCtrl = TextEditingController(),
        correoCtrl = TextEditingController();

  final TextEditingController nombreCtrl;
  final TextEditingController correoCtrl;

  void dispose() {
    nombreCtrl.dispose();
    correoCtrl.dispose();
  }
}

/// Tarjeta visual que muestra los campos de una persona adicional.
class PersonaCard extends StatelessWidget {
  const PersonaCard({
    super.key,
    required this.persona,
    required this.numero,
    required this.onEliminar,
  });

  final PersonaAdicional persona;
  final int              numero;
  final VoidCallback     onEliminar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.iceBlue,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado: número + botón eliminar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 26, height: 26,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$numero',
                      style: AppTextStyles.captionBold
                          .copyWith(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text('Persona adicional',
                    style: AppTextStyles.captionBold
                        .copyWith(color: AppColors.primary)),
              ]),
              GestureDetector(
                onTap: onEliminar,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: const FaIcon(AppIcons.trash,
                      size: 13, color: AppColors.error),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Nombre
          AppTextField(
            label      : 'Nombre completo',
            hint       : 'Nombre del acompañante',
            controller : persona.nombreCtrl,
            prefixIcon : AppIcons.person,
            textCapitalization: TextCapitalization.words,
            textInputAction   : TextInputAction.next,
            validator  : (v) =>
                (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
          ),
          const SizedBox(height: AppSpacing.elementGap),

          // Correo
          AppTextField(
            label        : 'Correo electrónico',
            hint         : 'correo@ejemplo.com',
            controller   : persona.correoCtrl,
            prefixIcon   : AppIcons.email,
            keyboardType : TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            textInputAction   : TextInputAction.next,
            validator  : (v) {
              if (v == null || v.trim().isEmpty) return 'Campo requerido';
              if (!v.contains('@')) return 'Correo inválido';
              return null;
            },
          ),
        ],
      ),
    );
  }
}
