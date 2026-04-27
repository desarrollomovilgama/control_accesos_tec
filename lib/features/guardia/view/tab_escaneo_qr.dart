/// @file    tab_escaneo_qr.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de escaneo QR — panel del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../widgets/corner_painter.dart';

class TabEscaneoQR extends StatelessWidget {
  const TabEscaneoQR({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card de punto de acceso
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            ),
            child: Row(children: [
              const FaIcon(AppIcons.guardia, size: 28, color: Colors.white),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Guardia de Seguridad',
                      style: AppTextStyles.subtitleWhite),
                  Text('Puerta Principal · Activo',
                      style: AppTextStyles.caption
                          .copyWith(color: Colors.white70)),
                ]),
              ),
              Container(
                width: 10, height: 10,
                decoration: const BoxDecoration(
                    color: AppColors.success, shape: BoxShape.circle),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.blockGap),

          Text('Validar código QR', style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.elementGap),

          // Scanner placeholder con esquinas
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: AppColors.textContrast,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Stack(alignment: Alignment.center, children: [
              ..._buildCorners(),
              Column(mainAxisSize: MainAxisSize.min, children: [
                const FaIcon(AppIcons.qrcode,
                    size: 56, color: Colors.white54),
                const SizedBox(height: AppSpacing.sm),
                Text('Apunta la cámara al código QR',
                    style: AppTextStyles.bodyWhite),
              ]),
            ]),
          ),
          const SizedBox(height: AppSpacing.blockGap),

          // Último escaneo
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
              Row(children: [
                const FaIcon(AppIcons.circleInfo,
                    size: 14, color: AppColors.info),
                const SizedBox(width: AppSpacing.xs),
                Text('Último escaneo', style: AppTextStyles.captionBold),
              ]),
              const SizedBox(height: AppSpacing.xs),
              Text('Sin escaneos recientes', style: AppTextStyles.caption),
            ]),
          ),
        ],
      ),
    );
  }

  static const _cornerColor = Color(0xFF4FC3F7);

  List<Widget> _buildCorners() => [
    const Positioned(top: 16, left: 16,
        child: Corner(
            color: _cornerColor, size: 20, sw: 3, tl: true)),
    const Positioned(top: 16, right: 16,
        child: Corner(
            color: _cornerColor, size: 20, sw: 3, tr: true)),
    const Positioned(bottom: 16, left: 16,
        child: Corner(
            color: _cornerColor, size: 20, sw: 3, bl: true)),
    const Positioned(bottom: 16, right: 16,
        child: Corner(
            color: _cornerColor, size: 20, sw: 3, br: true)),
  ];
}
