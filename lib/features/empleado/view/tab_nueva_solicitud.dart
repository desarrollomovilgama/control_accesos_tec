/// @file    tab_nueva_solicitud.dart
/// @author  Jesús David Johnson Soto
/// @version 2.0
/// Tab de nueva solicitud de visita — panel del Empleado (RF-01).
/// Incluye margen de llegada estimada (±30 min).
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/persona_card.dart';

class TabNuevaSolicitud extends StatefulWidget {
  const TabNuevaSolicitud({super.key});

  @override
  State<TabNuevaSolicitud> createState() => _TabNuevaSolicitudState();
}

class _TabNuevaSolicitudState extends State<TabNuevaSolicitud> {
  final _formKey    = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _motivoCtrl = TextEditingController();
  final _fechaCtrl  = TextEditingController();
  final _horaCtrl   = TextEditingController();
  bool _isLoading   = false;

  // Margen de llegada: 'antes' | 'despues' | null
  String? _margenLlegada;

  final List<PersonaAdicional> _personasAdicionales = [];

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
    _motivoCtrl.dispose();
    _fechaCtrl.dispose();
    _horaCtrl.dispose();
    for (final p in _personasAdicionales) {
      p.dispose();
    }
    super.dispose();
  }

  void _agregarPersona() =>
      setState(() => _personasAdicionales.add(PersonaAdicional()));

  void _eliminarPersona(int index) {
    setState(() {
      _personasAdicionales[index].dispose();
      _personasAdicionales.removeAt(index);
    });
  }

  /// Calcula la hora estimada con el margen seleccionado.
  /// Devuelve null si falta la hora base o el margen.
  String? _calcularHoraEstimada() {
    if (_horaCtrl.text.isEmpty || _margenLlegada == null) return null;
    final parts = _horaCtrl.text.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;

    var total = h * 60 + m;
    total += _margenLlegada == 'antes' ? -30 : 30;
    // Mantener dentro de 00:00–23:59
    total = total.clamp(0, 23 * 60 + 59);
    final hh = (total ~/ 60).toString().padLeft(2, '0');
    final mm = (total % 60).toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final horaEstimada = _calcularHoraEstimada();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Nueva solicitud de visita', style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.xs),
            Text('Completa los datos del visitante principal.',
                style: AppTextStyles.caption),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Visitante principal ─────────────────────────────────
            Text('Visitante principal', style: AppTextStyles.fieldLabel),
            const SizedBox(height: AppSpacing.sm),

            AppTextField(
              label      : 'Nombre completo',
              hint       : 'Nombre del visitante',
              controller : _nombreCtrl,
              prefixIcon : AppIcons.person,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator  : (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: AppSpacing.elementGap),

            AppTextField(
              label        : 'Correo electrónico',
              hint         : 'correo@ejemplo.com',
              controller   : _correoCtrl,
              prefixIcon   : AppIcons.email,
              keyboardType : TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              textInputAction   : TextInputAction.next,
              validator  : (v) {
                if (v == null || v.trim().isEmpty) return 'Campo requerido';
                if (!v.contains('@')) return 'Correo inválido';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.elementGap),

            AppTextField(
              label      : 'Fecha de visita',
              hint       : 'DD/MM/AAAA',
              controller : _fechaCtrl,
              prefixIcon : AppIcons.calendar,
              readOnly   : true,
              textInputAction: TextInputAction.next,
              validator  : (v) =>
                  (v == null || v.trim().isEmpty) ? 'Selecciona una fecha' : null,
              onTap      : () => _pickDate(context),
            ),
            const SizedBox(height: AppSpacing.elementGap),

            AppTextField(
              label      : 'Hora de la visita',
              hint       : 'HH:MM',
              controller : _horaCtrl,
              prefixIcon : AppIcons.clock,
              readOnly   : true,
              validator  : (v) =>
                  (v == null || v.trim().isEmpty) ? 'Selecciona una hora' : null,
              onTap      : () => _pickTime(context),
            ),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Hora estimada de llegada ────────────────────────────
            Text('Hora estimada de llegada', style: AppTextStyles.fieldLabel),
            const SizedBox(height: AppSpacing.xs),
            Text('Indica si el visitante podría llegar antes o después '
                'de la hora indicada (±30 min).',
                style: AppTextStyles.caption),
            const SizedBox(height: AppSpacing.sm),

            Row(children: [
              Expanded(
                child: _MargenChip(
                  label    : 'Llega antes',
                  sublabel : '−30 min',
                  icon     : FontAwesomeIcons.arrowLeft,
                  selected : _margenLlegada == 'antes',
                  color    : AppColors.info,
                  onTap    : () => setState(
                      () => _margenLlegada =
                          _margenLlegada == 'antes' ? null : 'antes'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _MargenChip(
                  label    : 'Llega después',
                  sublabel : '+30 min',
                  icon     : FontAwesomeIcons.arrowRight,
                  selected : _margenLlegada == 'despues',
                  color    : AppColors.warning,
                  onTap    : () => setState(
                      () => _margenLlegada =
                          _margenLlegada == 'despues' ? null : 'despues'),
                ),
              ),
            ]),

            // Resultado de la hora estimada
            if (horaEstimada != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.iceBlue,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.borderGray),
                ),
                child: Row(children: [
                  const FaIcon(AppIcons.clock,
                      size: 14, color: AppColors.secondary),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Llegada estimada: ', style: AppTextStyles.caption),
                  Text(horaEstimada,
                      style: AppTextStyles.captionBold
                          .copyWith(color: AppColors.secondary)),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    _margenLlegada == 'antes'
                        ? '(30 min antes de ${_horaCtrl.text})'
                        : '(30 min después de ${_horaCtrl.text})',
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.iconGray),
                  ),
                ]),
              ),
            ],

            const SizedBox(height: AppSpacing.blockGap),

            AppTextField(
              label      : 'Motivo de la visita',
              hint       : 'Describe brevemente el propósito...',
              controller : _motivoCtrl,
              prefixIcon : AppIcons.circleInfo,
              maxLines   : 3,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              validator  : (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Personas adicionales ───────────────────────────────
            const Divider(),
            const SizedBox(height: AppSpacing.sm),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personas adicionales',
                        style: AppTextStyles.fieldLabel),
                    Text(
                      '${_personasAdicionales.length} persona(s) añadida(s)',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _agregarPersona,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const FaIcon(FontAwesomeIcons.plus,
                          size: 12, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.xs),
                      Text('Añadir persona',
                          style: AppTextStyles.captionBold
                              .copyWith(color: AppColors.primary)),
                    ]),
                  ),
                ),
              ],
            ),

            if (_personasAdicionales.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              ..._personasAdicionales.asMap().entries.map((entry) {
                final i = entry.key;
                final p = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: PersonaCard(
                    persona   : p,
                    numero    : i + 1,
                    onEliminar: () => _eliminarPersona(i),
                  ),
                );
              }),
            ],

            const SizedBox(height: AppSpacing.blockGap),

            PrimaryButton(
              label     : 'Enviar solicitud',
              isLoading : _isLoading,
              isEnabled : !_isLoading,
              icon      : _isLoading
                  ? null
                  : const FaIcon(FontAwesomeIcons.paperPlane,
                      size: 14, color: Colors.white),
              onPressed : _submit,
            ),
          ],
        ),
      ),
    );
  }

  // ── Pickers ────────────────────────────────────────────────────────────────
  Future<void> _pickDate(BuildContext context) async {
    final now  = DateTime.now();
    final date = await showDatePicker(
      context     : context,
      initialDate : now,
      firstDate   : now,
      lastDate    : now.add(const Duration(days: 60)),
    );
    if (date != null) {
      _fechaCtrl.text =
          '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final time = await showTimePicker(
      context     : context,
      initialTime : TimeOfDay.now(),
    );
    if (time != null && context.mounted) {
      setState(() {
        _horaCtrl.text =
            '${time.hour.toString().padLeft(2, '0')}:'
            '${time.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: llamar a repositorio de solicitudes (RF-01)
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final total = 1 + _personasAdicionales.length;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Solicitud enviada para $total persona(s)'),
        backgroundColor: AppColors.success,
      ),
    );

    _formKey.currentState!.reset();
    _nombreCtrl.clear();
    _correoCtrl.clear();
    _motivoCtrl.clear();
    _fechaCtrl.clear();
    _horaCtrl.clear();
    for (final p in _personasAdicionales) {
      p.dispose();
    }
    setState(() {
      _personasAdicionales.clear();
      _margenLlegada = null;
    });
  }
}

// ─── Chip de margen de llegada ────────────────────────────────────────────────
class _MargenChip extends StatelessWidget {
  const _MargenChip({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String       label;
  final String       sublabel;
  final IconData     icon;
  final bool         selected;
  final Color        color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.1) : AppColors.iceBlue,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: selected ? color : AppColors.borderGray,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(children: [
          FaIcon(icon,
              size: 14, color: selected ? color : AppColors.iconGray),
          const SizedBox(height: 4),
          Text(label,
              style: AppTextStyles.captionBold.copyWith(
                  color: selected ? color : AppColors.textContrast),
              textAlign: TextAlign.center),
          Text(sublabel,
              style: AppTextStyles.caption.copyWith(
                  color: selected ? color : AppColors.iconGray),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
