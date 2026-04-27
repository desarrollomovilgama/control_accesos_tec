/// =============================================================================
/// login_form.dart
/// -----------------------------------------------------------------------------
/// Formulario de login: usuario, contraseña, botón Ingresar.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/widgets/password_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/standard_text_field.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onSuccess,
    required this.userCtrl,
    required this.passCtrl,
  });

  final VoidCallback onSuccess;
  final TextEditingController userCtrl;
  final TextEditingController passCtrl;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<void> _onSubmit() async {
    final vm = context.read<LoginViewModel>();
    final ok = await vm.iniciarSesion(
      usuario: widget.userCtrl.text,
      password: widget.passCtrl.text,
    );
    if (!mounted) return;
    if (ok) {
      widget.onSuccess();
    } else if (vm.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StandardTextField(
          label: 'Usuario',
          hintText: 'correo@toluca.tecnm.mx',
          controller: widget.userCtrl,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        AppSpacing.vGapLg,
        PasswordTextField(
          label: 'Contraseña',
          hintText: 'Contraseña',
          controller: widget.passCtrl,
          onSubmitted: (_) => _onSubmit(),
        ),
        AppSpacing.vGapXl,
        PrimaryButton(
          label: 'Ingresar',
          isLoading: vm.cargando,
          onPressed: vm.cargando ? null : _onSubmit,
        ),
      ],
    );
  }
}
