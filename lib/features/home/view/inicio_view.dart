/// =============================================================================
/// inicio_view.dart
/// -----------------------------------------------------------------------------
/// Pestaña "Inicio" del BottomNavigationBar. Muestra resumen del día y
/// accesos rápidos. Solo maqueta visual.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../widgets/clase_actual_card.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.paddingScreen,
      children: [
        Text('Bienvenido(a)', style: AppTypography.textTheme.headlineMedium),
        Text(
          'Demo • Alumno',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.vGapXl,
        const SectionHeader(title: 'Tu próxima clase'),
        AppSpacing.vGapMd,
        const ClaseActualCard(
          materia: 'Auditoría Informática',
          docente: 'Mtro. Gamaliel Castro González',
          aula: 'F-203',
          horario: '11:00 — 13:00',
        ),
        AppSpacing.vGapXxl,
        const SectionHeader(title: 'Accesos rápidos'),
        AppSpacing.vGapMd,
        _AccesoRapido(
          icon: AppIcons.qrScan,
          label: 'Escanear código del aula',
          onTap: () =>
              Navigator.of(context).pushNamed(RouteNames.qrScanner),
        ),
        AppSpacing.vGapMd,
        _AccesoRapido(
          icon: AppIcons.classroom,
          label: 'Consulta de aulas',
          onTap: () =>
              Navigator.of(context).pushNamed(RouteNames.consultaAulas),
        ),
        AppSpacing.vGapMd,
        _AccesoRapido(
          icon: AppIcons.search,
          label: 'Buscar docente o materia',
          onTap: () => Navigator.of(context).pushNamed(RouteNames.busqueda),
        ),
      ],
    );
  }
}

class _AccesoRapido extends StatelessWidget {
  const _AccesoRapido({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label, style: AppTypography.textTheme.titleMedium),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
