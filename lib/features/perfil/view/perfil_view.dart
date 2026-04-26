/// =============================================================================
/// perfil_view.dart
/// -----------------------------------------------------------------------------
/// Pestaña de Perfil. Punto de entrada a estatus, historial, cierre de sesión.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/perfil_viewmodel.dart';
import '../widgets/menu_opcion.dart';
import '../widgets/perfil_header.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PerfilViewModel(),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.login,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PerfilViewModel>();
    return ListView(
      padding: AppSpacing.paddingScreen,
      children: [
        PerfilHeader(nombre: vm.nombre, rol: vm.rol, correo: vm.correo),
        AppSpacing.vGapXl,
        MenuOpcion(
          icon: AppIcons.clipboardList,
          label: 'Registrar mi estatus',
          onTap: () =>
              Navigator.of(context).pushNamed(RouteNames.registroEstatus),
        ),
        AppSpacing.vGapSm,
        MenuOpcion(
          icon: AppIcons.calendar,
          label: 'Historial de estatus',
          onTap: () =>
              Navigator.of(context).pushNamed(RouteNames.listaEstatus),
        ),
        AppSpacing.vGapSm,
        MenuOpcion(
          icon: AppIcons.classroom,
          label: 'Consulta de aulas',
          onTap: () =>
              Navigator.of(context).pushNamed(RouteNames.consultaAulas),
        ),
        AppSpacing.vGapXl,
        MenuOpcion(
          icon: AppIcons.logout,
          label: 'Cerrar sesión',
          color: AppColors.error,
          onTap: () => _logout(context),
        ),
      ],
    );
  }
}
