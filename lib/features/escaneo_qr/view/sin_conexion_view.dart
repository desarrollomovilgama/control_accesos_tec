/// =============================================================================
/// sin_conexion_view.dart
/// -----------------------------------------------------------------------------
/// Vista "Sin conexión" exigida por el módulo 7 (Navegación y UX).
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/widgets/error_state.dart';

class SinConexionView extends StatelessWidget {
  const SinConexionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sin conexión')),
      body: ErrorState(
        icon: AppIcons.offline,
        title: 'Sin conexión',
        message:
            'Verifica tu conexión a internet e inténtalo de nuevo. La aplicación '
            'requiere conexión activa para mostrar la información del aula.',
        onRetry: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
