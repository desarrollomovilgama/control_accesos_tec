/// =============================================================================
/// agregar_aula_form.dart
/// -----------------------------------------------------------------------------
/// Formulario reutilizable para alta de aulas. Maneja sus propios
/// TextEditingController y Form key, valida los campos y delega el
/// resultado al padre mediante callbacks (onGuardada / onError).
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/standard_text_field.dart';
import '../model/horario_model.dart';
import '../viewmodel/consulta_viewmodel.dart';

class AgregarAulaForm extends StatefulWidget {
  const AgregarAulaForm({
    super.key,
    required this.onGuardada,
    required this.onError,
  });

  final void Function(String mensaje) onGuardada;
  final void Function(String mensaje) onError;

  @override
  State<AgregarAulaForm> createState() => _AgregarAulaFormState();
}

class _AgregarAulaFormState extends State<AgregarAulaForm> {
  final _formKey = GlobalKey<FormState>();
  final _codigoCtrl = TextEditingController();
  final _pisoCtrl = TextEditingController();
  final _capacidadCtrl = TextEditingController();
  final _equipamientoCtrl = TextEditingController();

  String _edificio = ConsultaViewModel.edificiosDisponibles.first;
  TipoAula _tipo = TipoAula.aula;

  @override
  void dispose() {
    _codigoCtrl.dispose();
    _pisoCtrl.dispose();
    _capacidadCtrl.dispose();
    _equipamientoCtrl.dispose();
    super.dispose();
  }

  void _onGuardar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final vm = context.read<ConsultaViewModel>();
    final nueva = AulaResumen(
      codigo: _codigoCtrl.text.trim().toUpperCase(),
      edificio: _edificio,
      ocupada: false,
      piso: int.tryParse(_pisoCtrl.text.trim()),
      capacidad: int.tryParse(_capacidadCtrl.text.trim()),
      tipo: _tipo,
      equipamiento: _equipamientoCtrl.text.trim().isEmpty
          ? null
          : _equipamientoCtrl.text.trim(),
    );

    final ok = vm.agregarAula(nueva);
    if (ok) {
      widget.onGuardada('Aula ${nueva.codigo} registrada correctamente.');
    } else {
      widget.onError('Ya existe un aula con ese código.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StandardTextField(
            label: 'Código',
            hintText: 'Ej. F-205',
            controller: _codigoCtrl,
            textInputAction: TextInputAction.next,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Requerido.';
              if (v.trim().length < 3) return 'Mínimo 3 caracteres.';
              return null;
            },
          ),
          AppSpacing.vGapLg,
          _DropdownEdificio(
            valor: _edificio,
            onChanged: (v) => setState(() => _edificio = v),
          ),
          AppSpacing.vGapLg,
          _DropdownTipo(
            valor: _tipo,
            onChanged: (v) => setState(() => _tipo = v),
          ),
          AppSpacing.vGapLg,
          Row(
            children: [
              Expanded(
                child: StandardTextField(
                  label: 'Piso',
                  hintText: '1',
                  controller: _pisoCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Requerido.';
                    final n = int.tryParse(v.trim());
                    if (n == null || n < 0 || n > 10) return '0–10.';
                    return null;
                  },
                ),
              ),
              AppSpacing.hGapMd,
              Expanded(
                child: StandardTextField(
                  label: 'Capacidad',
                  hintText: '30',
                  controller: _capacidadCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Requerido.';
                    final n = int.tryParse(v.trim());
                    if (n == null || n <= 0 || n > 500) return '1–500.';
                    return null;
                  },
                ),
              ),
            ],
          ),
          AppSpacing.vGapLg,
          StandardTextField(
            label: 'Equipamiento (opcional)',
            hintText: 'Proyector, pizarra, 25 PCs…',
            controller: _equipamientoCtrl,
            maxLines: 3,
          ),
          AppSpacing.vGapXl,
          PrimaryButton(label: 'Guardar', onPressed: _onGuardar),
        ],
      ),
    );
  }
}

class _DropdownEdificio extends StatelessWidget {
  const _DropdownEdificio({required this.valor, required this.onChanged});

  final String valor;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Edificio',
            style: TextStyle(fontWeight: FontWeight.w600)),
        AppSpacing.vGapSm,
        DropdownButtonFormField<String>(
          initialValue: valor,
          items: ConsultaViewModel.edificiosDisponibles
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => v == null ? null : onChanged(v),
        ),
      ],
    );
  }
}

class _DropdownTipo extends StatelessWidget {
  const _DropdownTipo({required this.valor, required this.onChanged});

  final TipoAula valor;
  final ValueChanged<TipoAula> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipo', style: TextStyle(fontWeight: FontWeight.w600)),
        AppSpacing.vGapSm,
        DropdownButtonFormField<TipoAula>(
          initialValue: valor,
          items: TipoAula.values
              .map((t) => DropdownMenuItem<TipoAula>(
                    value: t,
                    child: Text(t.label),
                  ))
              .toList(),
          onChanged: (v) => v == null ? null : onChanged(v),
        ),
      ],
    );
  }
}
