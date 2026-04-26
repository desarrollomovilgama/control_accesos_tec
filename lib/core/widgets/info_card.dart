/// =============================================================================
/// info_card.dart
/// -----------------------------------------------------------------------------
/// Tarjeta de información estándar. Figura 41 del MPF.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../spacing/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.children = const [],
    this.accentColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final List<Widget> children;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: AppSpacing.paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    AppSpacing.hGapMd,
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.textTheme.titleMedium?.copyWith(
                            color: accentColor ?? AppColors.textPrimary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          AppSpacing.vGapXs,
                          Text(
                            subtitle!,
                            style: AppTypography.textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              if (children.isNotEmpty) ...[
                AppSpacing.vGapMd,
                ...children,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
