/// @file    tab_registro_manual.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de registro manual de código de visita — panel del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';

class TabRegistroManual extends StatefulWidget {
  const TabRegistroManual({super.key});

  @override
  State<TabRegistroManual> createState() => _TabRegistroManualState();
}

class _TabRegistroManualState extends State<TabRegistroManual> {
  final _formKey    = GlobalKey<FormState>();
  final _codigoCtrl = TextEditingController();
  bool  _salida     = false;

  @override
  void dispose() {
    _codigoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Text('Registro Manual', style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.xs),
          Text('Ingresa el código de visita manualmente.',
              style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.blockGap),

          AppTextField(
            label      : 'Código de visita',
            hint       : 'Ej. VIS-20240426-103000',
            controller : _codigoCtrl,
            prefixIcon : AppIcons.hashtag,
            textCapitalization: TextCapitalization.characters,
            textInputAction   : TextInputAction.done,
            validator  : (v) =>
                (v == null || v.trim().isEmpty) ? 'Ingresa el código' : null,
          ),
          const SizedBox(height: AppSpacing.blockGap),

          Text('Tipo de movimiento', style: AppTextStyles.fieldLabel),
          const SizedBox(height: AppSpacing.xs),
          Row(children: [
            Expanded(
                child: _MovChip(
              label    : 'Entrada',
              icon     : FontAwesomeIcons.arrowRightToBracket,
              selected : !_salida,
              color    : AppColors.success,
              onTap    : () => setState(() => _salida = false),
            )),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
                child: _MovChip(
              label    : 'Salida',
              icon     : FontAwesomeIcons.arrowRightFromBracket,
              selected : _salida,
              color    : AppColors.error,
              onTap    : () => setState(() => _salida = true),
            )),
          ]),
          const SizedBox(height: AppSpacing.blockGap),

          PrimaryButton(
            label   : _salida ? 'Registrar Salida' : 'Registrar Entrada',
            variant : _salida
                ? PrimaryButtonVariant.danger
                : PrimaryButtonVariant.success,
            icon    : FaIcon(
              _salida
                  ? FontAwesomeIcons.arrowRightFromBracket
                  : FontAwesomeIcons.arrowRightToBracket,
              size: 14, color: Colors.white,
            ),
            onPressed: _submit,
          ),
        ]),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '${_salida ? "Salida" : "Entrada"} registrada: '
          '${_codigoCtrl.text.trim()}'),
      backgroundColor: _salida ? AppColors.error : AppColors.success,
    ));
    _codigoCtrl.clear();
  }
}

// ─── Chip de movimiento (Entrada / Salida) ───────────────────────────────────
class _MovChip extends StatelessWidget {
  const _MovChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String       label;
  final IconData     icon;
  final bool         selected;
  final Color        color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.1) : AppColors.iceBlue,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
              color: selected ? color : AppColors.borderGray,
              width: selected ? 1.5 : 1),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(icon,
              size: 13,
              color: selected ? color : AppColors.iconGray),
          const SizedBox(width: AppSpacing.xs),
          Text(label,
              style: AppTextStyles.captionBold.copyWith(
                  color: selected ? color : AppColors.iconGray)),
        ]),
      ),
    );
  }
}
