/// =============================================================================
/// perfil_view.dart
/// -----------------------------------------------------------------------------
/// Pestaña de Perfil. Muestra información del usuario y botón de cerrar sesión.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/session/session_service.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../viewmodel/perfil_viewmodel.dart';
import '../widgets/menu_opcion.dart';
import '../widgets/perfil_header.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PerfilViewModel(ctx.read<SessionService>()),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  void _logout(BuildContext context) {
    context.read<PerfilViewModel>().cerrarSesion();
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
        if (vm.esAlumno && (vm.carrera != null || vm.grupo != null)) ...[
          AppSpacing.vGapSm,
          _DatosAcademicos(carrera: vm.carrera, grupo: vm.grupo),
        ],
        AppSpacing.vGapXxl,
        MenuOpcion(
          icon: Icons.logout_rounded,
          label: 'Cerrar sesión',
          color: AppColors.error,
          onTap: () => _logout(context),
        ),
      ],
    );
  }
}

class _DatosAcademicos extends StatelessWidget {
  const _DatosAcademicos({this.carrera, this.grupo});

  final String? carrera;
  final String? grupo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (carrera != null)
              Row(
                children: [
                  const Icon(Icons.school_rounded,
                      size: 18, color: AppColors.textSecondary),
                  AppSpacing.hGapSm,
                  Expanded(
                    child: Text(
                      carrera!,
                      style: AppTypography.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            if (carrera != null && grupo != null) AppSpacing.vGapXs,
            if (grupo != null)
              Row(
                children: [
                  const Icon(Icons.group_rounded,
                      size: 18, color: AppColors.textSecondary),
                  AppSpacing.hGapSm,
                  Text(
                    'Grupo: $grupo',
                    style: AppTypography.textTheme.bodyMedium,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
