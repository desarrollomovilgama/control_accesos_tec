/// @file    registro_visita_view.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Pantalla de resultado — muestra el QR generado tras registrar una visita.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../model/registro_visita_model.dart';

class RegistroVisitaView extends StatelessWidget {
  const RegistroVisitaView({super.key, required this.registro});

  final RegistroVisita registro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Registro generado'),
        leading: IconButton(
          icon: const FaIcon(AppIcons.back, size: 18),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Regresar',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Encabezado de éxito ─────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Row(children: [
                const FaIcon(AppIcons.circleCheck,
                    size: 22, color: AppColors.success),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Visita registrada', style: AppTextStyles.bodyBold
                          .copyWith(color: AppColors.success)),
                      Text('Muestra el QR al guardia para validar el acceso.',
                          style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Código QR ───────────────────────────────────────────
            Center(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                  border: Border.all(color: AppColors.borderGray),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12, offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data           : registro.toQRData(),
                  version        : QrVersions.auto,
                  size           : 220,
                  backgroundColor: Colors.white,
                  eyeStyle       : const QrEyeStyle(
                    eyeShape : QrEyeShape.square,
                    color    : AppColors.primary,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color          : AppColors.textContrast,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Detalles del registro ───────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.iceBlue,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                border: Border.all(color: AppColors.borderGray),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detalles del registro', style: AppTextStyles.fieldLabel),
                  const SizedBox(height: AppSpacing.sm),
                  _DetalleRow(icon: AppIcons.hashtag,  label: 'ID',     value: registro.id),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(icon: AppIcons.person,   label: 'Nombre', value: registro.nombre),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(icon: AppIcons.email,    label: 'Correo', value: registro.correo),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(icon: AppIcons.building, label: 'Lugar',  value: registro.lugar),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(icon: AppIcons.calendar, label: 'Fecha',  value: registro.fechaFormateada),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(icon: AppIcons.clock,    label: 'Hora',   value: registro.horaFormateada),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.blockGap),

            // ── Botón regresar ──────────────────────────────────────
            PrimaryButton(
              label   : 'Nuevo registro',
              variant : PrimaryButtonVariant.outlined,
              icon    : const FaIcon(AppIcons.add, size: 14, color: AppColors.primary),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Fila de detalle ─────────────────────────────────────────────────────────
class _DetalleRow extends StatelessWidget {
  const _DetalleRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String   label;
  final String   value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 13, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.iconGray)),
            const SizedBox(height: 2),
            Text(value, style: AppTextStyles.bodyBold),
          ]),
        ),
      ],
    );
  }
}
