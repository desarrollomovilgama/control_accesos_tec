/// =============================================================================
/// login_view.dart
/// -----------------------------------------------------------------------------
/// Pantalla de inicio de sesión institucional. Reproduce la maqueta entregada
/// (TECNM / Instituto Tecnológico de Toluca). Está compuesta por widgets
/// pequeños declarados en /widgets para mantener este archivo bajo 200 líneas.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/login_viewmodel.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginScaffold(),
    );
  }
}

class _LoginScaffold extends StatelessWidget {
  const _LoginScaffold();

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSpacing.vGapMd,
              const LoginHeader(),
              AppSpacing.vGapXxl,
              LoginForm(onSuccess: () => _goHome(context)),
              AppSpacing.vGapXl,
              const LoginFooter(),
              AppSpacing.vGapLg,
            ],
          ),
        ),
      ),
    );
  }
}
