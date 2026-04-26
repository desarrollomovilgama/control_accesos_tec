/// =============================================================================
/// busqueda_view.dart
/// -----------------------------------------------------------------------------
/// Vista principal del módulo Búsqueda con tabs Aulas / Docentes / Materias.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/busqueda_viewmodel.dart';
import '../widgets/aula_resultado.dart';
import '../widgets/docente_resultado.dart';
import '../widgets/materia_resultado.dart';

class BusquedaView extends StatelessWidget {
  const BusquedaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BusquedaViewModel(),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: AppSpacing.paddingScreen,
            child: TextField(
              onChanged: context.read<BusquedaViewModel>().actualizarQuery,
              decoration: const InputDecoration(
                hintText: 'Buscar aula, docente o materia',
                prefixIcon: Icon(AppIcons.search),
              ),
            ),
          ),
          const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Aulas'),
              Tab(text: 'Docentes'),
              Tab(text: 'Materias'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _TabAulas(),
                _TabDocentes(),
                _TabMaterias(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabAulas extends StatelessWidget {
  const _TabAulas();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BusquedaViewModel>();
    return ListView.separated(
      padding: AppSpacing.paddingScreen,
      itemCount: vm.aulas.length,
      separatorBuilder: (_, __) => AppSpacing.vGapSm,
      itemBuilder: (_, i) => AulaResultadoCard(
        aula: vm.aulas[i],
        onTap: () => Navigator.of(context).pushNamed(
          RouteNames.aulaDetalle,
          arguments: <String, dynamic>{'codigoAula': vm.aulas[i].codigo},
        ),
      ),
    );
  }
}

class _TabDocentes extends StatelessWidget {
  const _TabDocentes();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BusquedaViewModel>();
    return ListView.separated(
      padding: AppSpacing.paddingScreen,
      itemCount: vm.docentes.length,
      separatorBuilder: (_, __) => AppSpacing.vGapSm,
      itemBuilder: (_, i) =>
          DocenteResultadoCard(docente: vm.docentes[i]),
    );
  }
}

class _TabMaterias extends StatelessWidget {
  const _TabMaterias();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BusquedaViewModel>();
    return ListView.separated(
      padding: AppSpacing.paddingScreen,
      itemCount: vm.materias.length,
      separatorBuilder: (_, __) => AppSpacing.vGapSm,
      itemBuilder: (_, i) =>
          MateriaResultadoCard(materia: vm.materias[i]),
    );
  }
}
