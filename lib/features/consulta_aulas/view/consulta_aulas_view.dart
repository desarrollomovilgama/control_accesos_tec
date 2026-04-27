/// =============================================================================
/// consulta_aulas_view.dart
/// -----------------------------------------------------------------------------
/// Lista de aulas con filtro por edificio (módulo 3). Para docentes y
/// laboratoristas se muestra un FloatingActionButton para registrar un
/// aula nueva (apartado 4.3 del MPF — UI condicional por rol).
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/session/session_service.dart';
import '../../../core/spacing/app_spacing.dart';
import '../viewmodel/consulta_viewmodel.dart';
import '../widgets/aula_card.dart';
import '../widgets/filtro_edificio.dart';
import 'agregar_aula_view.dart';

class ConsultaAulasView extends StatelessWidget {
  const ConsultaAulasView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConsultaViewModel(),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  /// Abre el formulario para registrar un aula nueva, pasando el mismo
  /// ViewModel para que la lista se actualice al volver.
  void _abrirAgregarAula(BuildContext context) {
    final vm = context.read<ConsultaViewModel>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        settings: const RouteSettings(name: RouteNames.agregarAula),
        builder: (_) => AgregarAulaView(viewModel: vm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsultaViewModel>();
    final session = context.watch<SessionService>();
    final puedeAgregar = !session.esAlumno;

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de aulas')),
      floatingActionButton: puedeAgregar
          ? FloatingActionButton.extended(
              onPressed: () => _abrirAgregarAula(context),
              icon: const Icon(AppIcons.add),
              label: const Text('Agregar aula'),
            )
          : null,
      body: Padding(
        padding: AppSpacing.paddingScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FiltroEdificio(
              opciones: ConsultaViewModel.edificios,
              seleccionado: vm.filtroEdificio,
              onChanged: vm.cambiarEdificio,
            ),
            AppSpacing.vGapMd,
            Expanded(
              child: vm.aulas.isEmpty
                  ? const Center(
                      child: Text('No hay aulas en este edificio.'),
                    )
                  : ListView.separated(
                      itemCount: vm.aulas.length,
                      separatorBuilder: (_, __) => AppSpacing.vGapSm,
                      itemBuilder: (_, i) => AulaCard(
                        aula: vm.aulas[i],
                        onTap: () => Navigator.of(context).pushNamed(
                          RouteNames.aulaDetalle,
                          arguments: <String, dynamic>{
                            'codigoAula': vm.aulas[i].codigo,
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
