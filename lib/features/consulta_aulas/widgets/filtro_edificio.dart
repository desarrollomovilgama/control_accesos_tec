/// =============================================================================
/// filtro_edificio.dart
/// -----------------------------------------------------------------------------
/// Chips horizontales para filtrar por edificio.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';

class FiltroEdificio extends StatelessWidget {
  const FiltroEdificio({
    super.key,
    required this.opciones,
    required this.seleccionado,
    required this.onChanged,
  });

  final List<String> opciones;
  final String seleccionado;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: opciones.length,
        separatorBuilder: (_, __) => AppSpacing.hGapSm,
        itemBuilder: (_, i) {
          final op = opciones[i];
          return ChoiceChip(
            label: Text(op),
            selected: seleccionado == op,
            onSelected: (_) => onChanged(op),
          );
        },
      ),
    );
  }
}
