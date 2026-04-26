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
  const LoginForm({super.key, required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final vm = context.read<LoginViewModel>();
    final ok = await vm.iniciarSesion(
      usuario: _userCtrl.text,
      password: _passCtrl.text,
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
          hintText: 'Usuario',
          controller: _userCtrl,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        AppSpacing.vGapLg,
        PasswordTextField(
          label: 'Contraseña',
          hintText: 'Contraseña',
          controller: _passCtrl,
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
