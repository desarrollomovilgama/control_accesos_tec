/// =============================================================================
/// resultados_view.dart
/// -----------------------------------------------------------------------------
/// Vista de resultados consolidada (acceso por ruta nombrada con argumentos).
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/empty_state.dart';

class ResultadosView extends StatelessWidget {
  const ResultadosView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados: "$query"')),
      body: Padding(
        padding: AppSpacing.paddingScreen,
        child: query.isEmpty
            ? const EmptyState(
                title: 'Escribe algo para buscar',
                message: 'Aún no has introducido un término de búsqueda.',
              )
            : Center(
                child: Text(
                  'Resultados para "$query"',
                  style: AppTypography.textTheme.titleMedium,
                ),
              ),
      ),
    );
  }
}
