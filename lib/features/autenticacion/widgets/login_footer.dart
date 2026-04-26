/// =============================================================================
/// login_footer.dart
/// -----------------------------------------------------------------------------
/// Pie de página del login (créditos institucionales y dirección).
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final small = AppTypography.textTheme.bodySmall?.copyWith(
      color: AppColors.textSecondary,
      height: 1.4,
    );
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: small,
            children: const [
              TextSpan(text: 'Instituto Tecnológico de Toluca | '),
              TextSpan(
                text: 'www.tolucatecnm.mx/',
                style: TextStyle(color: AppColors.link),
              ),
            ],
          ),
        ),
        AppSpacing.vGapXs,
        Text(
          'Instituto Tecnológico de Toluca - Algunos derechos reservados © 2016',
          textAlign: TextAlign.center,
          style: small,
        ),
        AppSpacing.vGapMd,
        const Divider(height: 1),
        AppSpacing.vGapMd,
        Text(
          'Av. Tecnológico s/n. Colonia Agrícola Bellavista\n'
          'Metepec, Edo. de México, México C. P. 52149\n'
          'Tel. (52) (722) 2 08 72 00',
          textAlign: TextAlign.center,
          style: small,
        ),
      ],
    );
  }
}
