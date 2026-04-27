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
import '../../../core/session/session_service.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/login_viewmodel.dart';
import '../widgets/demo_credentials_hint.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LoginViewModel(ctx.read<SessionService>()),
      child: _LoginScaffold(userCtrl: _userCtrl, passCtrl: _passCtrl),
    );
  }
}

class _LoginScaffold extends StatelessWidget {
  const _LoginScaffold({required this.userCtrl, required this.passCtrl});

  final TextEditingController userCtrl;
  final TextEditingController passCtrl;

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
              LoginForm(
                userCtrl: userCtrl,
                passCtrl: passCtrl,
                onSuccess: () => _goHome(context),
              ),
              AppSpacing.vGapLg,
              DemoCredentialsHint(
                userCtrl: userCtrl,
                passCtrl: passCtrl,
              ),
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
