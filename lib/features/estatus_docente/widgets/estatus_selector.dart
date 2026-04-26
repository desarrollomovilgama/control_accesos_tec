/// =============================================================================
/// estatus_selector.dart
/// -----------------------------------------------------------------------------
/// Selector de tipo de estatus mediante chips.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';
import '../model/estatus_model.dart';

class EstatusSelector extends StatelessWidget {
  const EstatusSelector({
    super.key,
    required this.seleccionado,
    required this.onChanged,
  });

  final TipoEstatus seleccionado;
  final ValueChanged<TipoEstatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: TipoEstatus.values.map((t) {
        return ChoiceChip(
          label: Text(t.label),
          selected: t == seleccionado,
          onSelected: (_) => onChanged(t),
        );
      }).toList(),
    );
  }
}
