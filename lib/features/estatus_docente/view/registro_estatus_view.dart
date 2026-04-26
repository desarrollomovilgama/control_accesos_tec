/// =============================================================================
/// registro_estatus_view.dart
/// -----------------------------------------------------------------------------
/// Vista para registrar un nuevo estatus del docente.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../viewmodel/estatus_viewmodel.dart';
import '../widgets/estatus_selector.dart';
import '../widgets/rango_fechas.dart';

class RegistroEstatusView extends StatelessWidget {
  const RegistroEstatusView({super.key});

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

  void _registrar(BuildContext context) {
    final vm = context.read<EstatusViewModel>();
    vm.registrar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Estatus registrado correctamente.')),
    );
    Navigator.of(context).pushNamed(RouteNames.listaEstatus);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EstatusViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar estatus')),
      body: ListView(
        padding: AppSpacing.paddingScreen,
        children: [
          Text('Tipo de estatus',
              style: AppTypography.textTheme.titleMedium),
          AppSpacing.vGapMd,
          EstatusSelector(
            seleccionado: vm.tipoSeleccionado,
            onChanged: vm.seleccionarTipo,
          ),
          AppSpacing.vGapXl,
          Text('Vigencia',
              style: AppTypography.textTheme.titleMedium),
          AppSpacing.vGapMd,
          RangoFechas(
            fechaInicio: vm.fechaInicio,
            fechaFin: vm.fechaFin,
            onInicio: vm.cambiarFechaInicio,
            onFin: vm.cambiarFechaFin,
          ),
          AppSpacing.vGapXxl,
          PrimaryButton(
            label: 'Registrar estatus',
            icon: AppIcons.save,
            onPressed: vm.esValido ? () => _registrar(context) : null,
          ),
        ],
      ),
    );
  }
}
