/// =============================================================================
/// consulta_aulas_view.dart
/// -----------------------------------------------------------------------------
/// Lista de aulas con filtro por edificio (módulo 3).
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../viewmodel/consulta_viewmodel.dart';
import '../widgets/aula_card.dart';
import '../widgets/filtro_edificio.dart';

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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsultaViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de aulas')),
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
              child: ListView.separated(
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
