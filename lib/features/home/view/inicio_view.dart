/// =============================================================================
/// inicio_view.dart
/// -----------------------------------------------------------------------------
/// Pestaña "Inicio" del BottomNavigationBar. Muestra resumen del día y
/// accesos rápidos. Solo maqueta visual.
///
/// La UI se adapta al rol del usuario actual (apartado 4.3 del MPF):
///   - Estudiante: ve accesos rápidos centrados en consulta (escaneo de aula, 
///     búsqueda).
///   - Docente / Laboratorista: ve además accesos a registro de estatus
///     y a la lista de solicitudes de apertura.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/session/session_service.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../autenticacion/model/usuario_model.dart';
import '../viewmodel/home_viewmodel.dart';

/// Índice de la pestaña "Buscar" en el BottomNavigationBar.
const int _kIndiceBuscar = 2;

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionService>();
    final usuario = session.usuario;
    final nombre = usuario?.nombre ?? 'Invitado(a)';
    final rolLabel = (usuario?.tipo ?? TipoUsuario.desconocido).label;
    final esAlumno = session.esAlumno;

    return ListView(
      padding: AppSpacing.paddingScreen,
      children: [
        Text('Bienvenido(a)', style: AppTypography.textTheme.headlineMedium),
        Text(
          '$nombre • $rolLabel',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.vGapXl,
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
          // En lugar de empujar una ruta nueva (BusquedaView no tiene
          // Scaffold propio porque vive embebida en el HomeShell),
          // cambiamos a la pestaña "Buscar" del BottomNavigationBar.
          onTap: () =>
              context.read<HomeViewModel>().cambiarIndice(_kIndiceBuscar),
        ),
        // Accesos exclusivos para docente / laboratorista.
        if (!esAlumno) ...[
          AppSpacing.vGapMd,
          _AccesoRapido(
            icon: AppIcons.clipboardList,
            label: 'Registrar mi estatus',
            onTap: () => Navigator.of(context)
                .pushNamed(RouteNames.registroEstatus),
          ),
          AppSpacing.vGapMd,
          _AccesoRapido(
            icon: AppIcons.doorOpen,
            label: 'Solicitudes de apertura',
            onTap: () => Navigator.of(context)
                .pushNamed(RouteNames.solicitudApertura),
          ),
        ],
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
