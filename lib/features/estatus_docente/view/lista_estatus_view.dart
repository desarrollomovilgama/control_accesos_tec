/// =============================================================================
/// lista_estatus_view.dart
/// -----------------------------------------------------------------------------
/// Listado de estatus registrados por el docente.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/empty_state.dart';
import '../model/estatus_model.dart';
import '../viewmodel/estatus_viewmodel.dart';

class ListaEstatusView extends StatelessWidget {
  const ListaEstatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstatusViewModel(),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EstatusViewModel>();
    final fmt = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(title: const Text('Mi historial de estatus')),
      body: vm.historial.isEmpty
          ? const EmptyState(
              title: 'Sin registros',
              message: 'Aún no has registrado ningún estatus.',
            )
          : ListView.separated(
              padding: AppSpacing.paddingScreen,
              itemCount: vm.historial.length,
              separatorBuilder: (_, __) => AppSpacing.vGapSm,
              itemBuilder: (_, i) => _Tarjeta(
                estatus: vm.historial[i],
                fmt: fmt,
              ),
            ),
    );
  }
}

class _Tarjeta extends StatelessWidget {
  const _Tarjeta({required this.estatus, required this.fmt});

  final EstatusDocente estatus;
  final DateFormat fmt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(AppIcons.clipboardList, color: AppColors.textOnPrimary),
        ),
        title: Text(estatus.tipo.label,
            style: AppTypography.textTheme.titleMedium),
        subtitle: Text(
          'Del ${fmt.format(estatus.fechaInicio)} al '
          '${fmt.format(estatus.fechaFin)}',
        ),
      ),
    );
  }
}
