/// @file    tab_perfil.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de perfil del empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';

class TabPerfil extends StatelessWidget {
  const TabPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar
          Center(
            child: Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                color: AppColors.mistBlue,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Center(
                child: FaIcon(AppIcons.user, size: 40, color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Text('Juan García Hernández',
              style: AppTextStyles.title, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text('Empleado · Depto. Sistemas',
              style: AppTextStyles.caption, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.blockGap),

          // Info card
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.iceBlue,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              border: Border.all(color: AppColors.borderGray),
            ),
            child: Column(
              children: [
                ProfileRow(
                    icon: AppIcons.email,
                    label: 'juan.garcia@itt.edu.mx'),
                const Divider(height: AppSpacing.blockGap),
                ProfileRow(
                    icon: AppIcons.building,
                    label: 'Instituto Tecnológico de Toluca'),
                const Divider(height: AppSpacing.blockGap),
                ProfileRow(
                    icon: AppIcons.phone,
                    label: '+52 722 000 0000'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: AppSpacing.md),
        Text(label, style: AppTextStyles.body),
      ],
    );
  }
}
