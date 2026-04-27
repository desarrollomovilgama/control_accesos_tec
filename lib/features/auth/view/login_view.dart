/// @file    login_view.dart
/// @author  Jesús David Johnson Soto
/// @version 2.0
/// Pantalla de inicio de sesión — GAMA MPF v1.0
/// Referencia: RF-15 / Mockup S-01 del Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey            = GlobalKey<FormState>();
  final _userController     = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.iceBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _InstitutionalHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                    vertical: AppSpacing.blockGap,
                  ),
                  child: _LoginForm(
                    formKey            : _formKey,
                    userController     : _userController,
                    passwordController : _passwordController,
                  ),
                ),
                const _InstitutionalFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Header institucional
// ═══════════════════════════════════════════════════════════════════════════
class _InstitutionalHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.iceBlue,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenH, AppSpacing.blockGap,
        AppSpacing.screenH, AppSpacing.blockGap,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Logos en las orillas ──────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _LogoImage(
                path  : 'assets/images/logo_tecnm.png',
                label : 'TECNM',
                height: 80,
              ),
              _LogoImage(
                path  : 'assets/images/logo_itt.png',
                label : 'ITT',
                height: 80,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Nombres institucionales ───────────────────────────
          Text(
            'TECNOLÓGICO NACIONAL DE MÉXICO',
            style: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'INSTITUTO TECNOLÓGICO DE TOLUCA',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Muestra un logo desde assets sin recorte — respeta su forma original.
class _LogoImage extends StatelessWidget {
  const _LogoImage({
    required this.path,
    required this.label,
    required this.height,
  });

  final String path;
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => SizedBox(
        height: height,
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.captionBold
                .copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Formulario
// ═══════════════════════════════════════════════════════════════════════════
class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.formKey,
    required this.userController,
    required this.passwordController,
  });
  final GlobalKey<FormState>  formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Iniciar sesión', style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.xs),
          Text('Ingresa tus credenciales institucionales', style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.blockGap),

          AppTextField(
            label: 'Usuario', hint: 'Ej. juan.garcia',
            controller: userController, prefixIcon: AppIcons.user,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            validator: vm.validateUsername, onChanged: vm.setUsername,
          ),
          const SizedBox(height: AppSpacing.elementGap),

          AppTextField(
            label: 'Contraseña', hint: '••••••••',
            controller: passwordController, prefixIcon: AppIcons.lock,
            obscureText: true, textInputAction: TextInputAction.done,
            validator: vm.validatePassword, onChanged: vm.setPassword,
            onFieldSubmitted: (_) => _submit(context, vm),
          ),
          const SizedBox(height: AppSpacing.elementGap),

          if (vm.errorMsg.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Row(children: [
                FaIcon(AppIcons.circleXmark, size: 14, color: AppColors.error),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(vm.errorMsg, style: AppTextStyles.errorText)),
              ]),
            ),
            const SizedBox(height: AppSpacing.elementGap),
          ],

          PrimaryButton(
            label: 'Ingresar', isLoading: vm.isLoading, isEnabled: !vm.isLoading,
            icon: vm.isLoading ? null : const FaIcon(
                FontAwesomeIcons.rightToBracket, size: 14, color: Colors.white),
            onPressed: () => _submit(context, vm),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context, LoginViewModel vm) {
    FocusScope.of(context).unfocus();
    vm.login(formKey: formKey, context: context);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Footer
// ═══════════════════════════════════════════════════════════════════════════
class _InstitutionalFooter extends StatelessWidget {
  const _InstitutionalFooter();

  @override
  Widget build(BuildContext context) {
    final small = AppTextStyles.caption.copyWith(fontSize: 11);
    final link  = small.copyWith(color: AppColors.primary);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenH, AppSpacing.sm,
        AppSpacing.screenH, AppSpacing.blockGap,
      ),
      child: Column(children: [
        const Divider(),
        const SizedBox(height: AppSpacing.sm),

        // Línea con enlace
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: 'Instituto Tecnológico de Toluca | ',
                style: small.copyWith(color: AppColors.textContrast)),
            TextSpan(text: 'www.tolucatecnm.mx/', style: link),
          ]),
        ),
        const SizedBox(height: 2),
        Text(
          'Instituto Tecnológico de Toluca - Algunos derechos reservados © 2016',
          style: small.copyWith(color: AppColors.iconGray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Av. Tecnológico s/n. Colonia Agrícola Bellavista\n'
          'Metepec, Edo. de México, México C. P. 52149\n'
          'Tel. (52) (722) 2 08 72 00',
          style: small.copyWith(color: AppColors.iconGray),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
