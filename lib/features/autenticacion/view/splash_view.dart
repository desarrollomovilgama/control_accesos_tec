/// =============================================================================
/// splash_view.dart
/// -----------------------------------------------------------------------------
/// Vista de bienvenida que decide si redirigir al login o al shell.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // En la versión real aquí se valida si hay sesión activa.
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(RouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school_rounded,
                color: AppColors.textOnPrimary, size: 96),
            AppSpacing.vGapLg,
            Text(
              'Control de Aulas',
              style: AppTypography.textTheme.displaySmall?.copyWith(
                color: AppColors.textOnPrimary,
              ),
            ),
            AppSpacing.vGapXl,
            const CircularProgressIndicator(
              color: AppColors.textOnPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
