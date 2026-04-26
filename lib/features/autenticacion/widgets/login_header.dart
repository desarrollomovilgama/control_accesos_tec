/// =============================================================================
/// login_header.dart
/// -----------------------------------------------------------------------------
/// Encabezado del login: dos logos institucionales + títulos.
/// Diseñado de acuerdo a la imagen de referencia (TECNM / ITT).
///
/// Los logos se cargan desde:
///   assets/images/logo_tecnm.png
///   assets/images/logo_itt.png
///
/// Si los archivos aún no existen, se muestra un placeholder con borde
/// discontinuo para no romper la UI durante el desarrollo.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  static const String _logoTecnm = 'assets/images/logo_tecnm.png';
  static const String _logoItt = 'assets/images/logo_itt.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            _LogoSlot(asset: _logoTecnm, label: 'TECNM'),
            _LogoSlot(asset: _logoItt, label: 'ITT'),
          ],
        ),
        AppSpacing.vGapLg,
        Text(
          'TECNOLÓGICO NACIONAL DE MÉXICO',
          textAlign: TextAlign.center,
          style: AppTypography.textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
        AppSpacing.vGapXs,
        Text(
          'INSTITUTO TECNOLÓGICO DE TOLUCA',
          textAlign: TextAlign.center,
          style: AppTypography.textTheme.titleSmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

/// Espacio reservado para cada logo. Si la imagen no existe, dibuja un
/// placeholder con borde punteado.
class _LogoSlot extends StatelessWidget {
  const _LogoSlot({required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 110,
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _PlaceholderLogo(label: label),
      ),
    );
  }
}

class _PlaceholderLogo extends StatelessWidget {
  const _PlaceholderLogo({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border,
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_outlined,
              color: AppColors.textHint,
              size: 36,
            ),
            AppSpacing.vGapXs,
            Text(
              'Logo $label',
              style: AppTypography.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
