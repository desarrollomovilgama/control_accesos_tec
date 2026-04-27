/// @file    tab_nueva_visita.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de nueva visita con formulario y generación de QR — panel del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../model/registro_visita_model.dart';
import 'registro_visita_view.dart';

class TabNuevaVisita extends StatefulWidget {
  const TabNuevaVisita({super.key});

  @override
  State<TabNuevaVisita> createState() => _TabNuevaVisitaState();
}

class _TabNuevaVisitaState extends State<TabNuevaVisita> {
  final _formKey    = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  String? _lugarSeleccionado;
  bool    _isLoading = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
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
          Text('Nueva visita', style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.xs),
          Text('Registra al visitante y genera su código QR de acceso.',
              style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.blockGap),

          // ── Nombre ──────────────────────────────────────────────
          AppTextField(
            label      : 'Nombre completo',
            hint       : 'Nombre del visitante',
            controller : _nombreCtrl,
            prefixIcon : AppIcons.person,
            textCapitalization: TextCapitalization.words,
            textInputAction   : TextInputAction.next,
            validator  : (v) =>
                (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
          ),
          const SizedBox(height: AppSpacing.elementGap),

          // ── Correo ──────────────────────────────────────────────
          AppTextField(
            label      : 'Correo electrónico',
            hint       : 'correo@ejemplo.com',
            controller : _correoCtrl,
            prefixIcon : AppIcons.email,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            textInputAction   : TextInputAction.done,
            validator  : (v) {
              if (v == null || v.trim().isEmpty) return 'Campo requerido';
              if (!v.contains('@')) return 'Correo inválido';
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.blockGap),

          // ── Lugar (selección predefinida) ───────────────────────
          Text('Lugar de destino', style: AppTextStyles.fieldLabel),
          const SizedBox(height: AppSpacing.xs),
          Text('Selecciona la instalación a visitar.',
              style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.sm),

          ...lugaresDisponibles.map((lugar) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: GestureDetector(
              onTap: () => setState(() => _lugarSeleccionado = lugar),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: _lugarSeleccionado == lugar
                      ? AppColors.primary.withOpacity(0.08)
                      : AppColors.iceBlue,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusCard),
                  border: Border.all(
                    color: _lugarSeleccionado == lugar
                        ? AppColors.primary
                        : AppColors.borderGray,
                    width: _lugarSeleccionado == lugar ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _lugarSeleccionado == lugar
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: _lugarSeleccionado == lugar
                            ? AppColors.primary
                            : AppColors.borderGray,
                        width: 1.5,
                      ),
                    ),
                    child: _lugarSeleccionado == lugar
                        ? const Icon(Icons.check, size: 13, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.location_on_outlined,
                      size: 14,
                      color: _lugarSeleccionado == lugar
                          ? AppColors.primary
                          : AppColors.iconGray),
                  const SizedBox(width: AppSpacing.sm),
                  Text(lugar,
                      style: AppTextStyles.bodyBold.copyWith(
                          color: _lugarSeleccionado == lugar
                              ? AppColors.primary
                              : AppColors.textContrast)),
                ]),
              ),
            ),
          )),

          const SizedBox(height: AppSpacing.blockGap),

          // ── Botón generar QR ────────────────────────────────────
          PrimaryButton(
            label     : 'Generar código QR',
            isLoading : _isLoading,
            isEnabled : !_isLoading,
            icon      : _isLoading
                ? null
                : const Icon(Icons.qr_code, size: 18, color: Colors.white),
            onPressed : _generarQR,
          ),
        ]),
      ),
    );
  }

  Future<void> _generarQR() async {
    if (!_formKey.currentState!.validate()) return;
    if (_lugarSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Selecciona un lugar de destino'),
        backgroundColor: AppColors.warning,
      ));
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final registro = RegistroVisita(
      nombre    : _nombreCtrl.text.trim(),
      correo    : _correoCtrl.text.trim(),
      lugar     : _lugarSeleccionado!,
      timestamp : DateTime.now(),
    );

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistroVisitaView(registro: registro),
      ),
    );

    _formKey.currentState!.reset();
    _nombreCtrl.clear();
    _correoCtrl.clear();
    setState(() => _lugarSeleccionado = null);
  }
}
