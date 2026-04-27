/// @file    home_anfitrion_view.dart
/// @author  Jesús David Johnson Soto
/// @version 3.0
/// Panel del Jefe — autoriza visitas y consulta sus detalles.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

// ─── Modelo local de solicitud ────────────────────────────────────────────────
enum _EstadoSolicitud { pendiente, autorizada, rechazada }

class _Solicitud {
  _Solicitud({
    required this.nombre,
    required this.empresa,
    required this.motivo,
    required this.fecha,
    required this.hora,
    required this.correo,
    this.estado = _EstadoSolicitud.pendiente,
  });
  final String        nombre;
  final String        empresa;
  final String        motivo;
  final String        fecha;
  final String        hora;
  final String        correo;
  _EstadoSolicitud    estado;
}

// ─── Vista principal del Jefe ─────────────────────────────────────────────────
class HomeAnfitrionView extends StatefulWidget {
  const HomeAnfitrionView({super.key});

  @override
  State<HomeAnfitrionView> createState() => _HomeAnfitrionViewState();
}

class _HomeAnfitrionViewState extends State<HomeAnfitrionView> {
  final List<_Solicitud> _solicitudes = [
    _Solicitud(
      nombre  : 'Carlos Mejía',
      empresa : 'SoftTech S.A.',
      motivo  : 'Reunión de proyecto con el equipo de sistemas.',
      fecha   : '26/04/2026',
      hora    : '10:00',
      correo  : 'carlos.mejia@softtech.com',
    ),
    _Solicitud(
      nombre  : 'Andrea Ríos',
      empresa : 'Auditores MX',
      motivo  : 'Revisión de contratos y documentación legal.',
      fecha   : '26/04/2026',
      hora    : '11:30',
      correo  : 'andrea.rios@auditores.mx',
    ),
    _Solicitud(
      nombre  : 'Roberto Fuentes',
      empresa : 'Consultoría JF',
      motivo  : 'Capacitación al personal administrativo.',
      fecha   : '27/04/2026',
      hora    : '09:00',
      correo  : 'r.fuentes@cjf.com.mx',
    ),
  ];

  void _autorizar(_Solicitud s) {
    setState(() => s.estado = _EstadoSolicitud.autorizada);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Visita de ${s.nombre} autorizada'),
      backgroundColor: AppColors.success,
    ));
  }

  void _rechazar(_Solicitud s) {
    setState(() => s.estado = _EstadoSolicitud.rechazada);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Visita de ${s.nombre} rechazada'),
      backgroundColor: AppColors.error,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final pendientes  = _solicitudes
        .where((s) => s.estado == _EstadoSolicitud.pendiente).length;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Panel del Jefe'),
        actions: [
          // Badge de pendientes
          if (pendientes > 0)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: Stack(alignment: Alignment.center, children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.bell, size: 18),
                  onPressed: () {},
                  tooltip: 'Notificaciones',
                ),
                Positioned(
                  right: 8, top: 8,
                  child: Container(
                    width: 9, height: 9,
                    decoration: const BoxDecoration(
                        color: AppColors.error, shape: BoxShape.circle),
                  ),
                ),
              ]),
            ),
          IconButton(
            icon: const FaIcon(
                FontAwesomeIcons.rightFromBracket, size: 18),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/login'),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),

      body: Column(
        children: [
          // ── Resumen superior ──────────────────────────────────────
          Container(
            color: AppColors.iceBlue,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
                vertical: AppSpacing.sm),
            child: Row(children: [
              _ResumenChip(
                label : 'Pendientes',
                count : _solicitudes
                    .where((s) => s.estado == _EstadoSolicitud.pendiente)
                    .length,
                color : AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.sm),
              _ResumenChip(
                label : 'Autorizadas',
                count : _solicitudes
                    .where((s) => s.estado == _EstadoSolicitud.autorizada)
                    .length,
                color : AppColors.success,
              ),
              const SizedBox(width: AppSpacing.sm),
              _ResumenChip(
                label : 'Rechazadas',
                count : _solicitudes
                    .where((s) => s.estado == _EstadoSolicitud.rechazada)
                    .length,
                color : AppColors.error,
              ),
            ]),
          ),

          // ── Lista de solicitudes ──────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              itemCount: _solicitudes.length + 1,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.listItemGap),
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Text('Solicitudes de visita',
                        style: AppTextStyles.subtitle),
                  );
                }
                final s = _solicitudes[i - 1];
                return _SolicitudJefeCard(
                  solicitud  : s,
                  onAutorizar: s.estado == _EstadoSolicitud.pendiente
                      ? () => _autorizar(s)
                      : null,
                  onRechazar : s.estado == _EstadoSolicitud.pendiente
                      ? () => _rechazar(s)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chip de resumen ──────────────────────────────────────────────────────────
class _ResumenChip extends StatelessWidget {
  const _ResumenChip({
    required this.label,
    required this.count,
    required this.color,
  });
  final String label;
  final int    count;
  final Color  color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(children: [
          Text('$count',
              style: AppTextStyles.title
                  .copyWith(color: color, fontSize: 20)),
          Text(label,
              style: AppTextStyles.caption,
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

// ─── Tarjeta de solicitud (con detalles expandibles) ─────────────────────────
class _SolicitudJefeCard extends StatefulWidget {
  const _SolicitudJefeCard({
    required this.solicitud,
    this.onAutorizar,
    this.onRechazar,
  });
  final _Solicitud    solicitud;
  final VoidCallback? onAutorizar;
  final VoidCallback? onRechazar;

  @override
  State<_SolicitudJefeCard> createState() => _SolicitudJefeCardState();
}

class _SolicitudJefeCardState extends State<_SolicitudJefeCard> {
  bool _expandido = false;

  Color get _badgeColor => switch (widget.solicitud.estado) {
    _EstadoSolicitud.autorizada => AppColors.success,
    _EstadoSolicitud.rechazada  => AppColors.error,
    _EstadoSolicitud.pendiente  => AppColors.warning,
  };

  String get _badgeLabel => switch (widget.solicitud.estado) {
    _EstadoSolicitud.autorizada => 'Autorizada',
    _EstadoSolicitud.rechazada  => 'Rechazada',
    _EstadoSolicitud.pendiente  => 'Pendiente',
  };

  IconData get _badgeIcon => switch (widget.solicitud.estado) {
    _EstadoSolicitud.autorizada => AppIcons.circleCheck,
    _EstadoSolicitud.rechazada  => AppIcons.circleXmark,
    _EstadoSolicitud.pendiente  => AppIcons.clock,
  };

  @override
  Widget build(BuildContext context) {
    final s = widget.solicitud;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
            color: _badgeColor.withOpacity(0.35), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Encabezado ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: _badgeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Center(
                  child: FaIcon(AppIcons.person,
                      size: 20, color: _badgeColor),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(s.nombre, style: AppTextStyles.bodyBold),
                  Text(s.empresa, style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Row(children: [
                    FaIcon(AppIcons.calendar,
                        size: 10, color: AppColors.iconGray),
                    const SizedBox(width: 4),
                    Text('${s.fecha}  ·  ${s.hora}',
                        style: AppTextStyles.caption),
                  ]),
                ]),
              ),
              // Badge de estado
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: 4),
                decoration: BoxDecoration(
                  color: _badgeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  FaIcon(_badgeIcon, size: 10, color: _badgeColor),
                  const SizedBox(width: 3),
                  Text(_badgeLabel,
                      style: AppTextStyles.caption.copyWith(
                          color: _badgeColor,
                          fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),

          // ── Botón "Ver detalles" ───────────────────────────────
          GestureDetector(
            onTap: () => setState(() => _expandido = !_expandido),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.cardPadding,
                  vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.iceBlue,
                border: Border(
                  top: BorderSide(color: AppColors.borderGray),
                ),
              ),
              child: Row(children: [
                FaIcon(
                  _expandido
                      ? FontAwesomeIcons.chevronUp
                      : FontAwesomeIcons.chevronDown,
                  size: 11, color: AppColors.iconGray,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  _expandido ? 'Ocultar detalles' : 'Ver detalles',
                  style: AppTextStyles.captionBold
                      .copyWith(color: AppColors.iconGray),
                ),
              ]),
            ),
          ),

          // ── Detalles expandibles ───────────────────────────────
          if (_expandido) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.cardPadding,
                AppSpacing.sm,
                AppSpacing.cardPadding,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetalleRow(
                      icon: AppIcons.email, label: 'Correo', value: s.correo),
                  const Divider(height: AppSpacing.blockGap),
                  _DetalleRow(
                      icon: AppIcons.circleInfo,
                      label: 'Motivo',
                      value: s.motivo),
                ],
              ),
            ),

            // Botones de acción — solo si está pendiente
            if (widget.onAutorizar != null || widget.onRechazar != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.cardPadding, 0,
                  AppSpacing.cardPadding, AppSpacing.cardPadding,
                ),
                child: Row(children: [
                  Expanded(
                    child: PrimaryButton(
                      label   : 'Autorizar',
                      variant : PrimaryButtonVariant.success,
                      icon    : const FaIcon(FontAwesomeIcons.check,
                          size: 12, color: Colors.white),
                      onPressed: widget.onAutorizar,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: PrimaryButton(
                      label   : 'Rechazar',
                      variant : PrimaryButtonVariant.danger,
                      icon    : const FaIcon(FontAwesomeIcons.xmark,
                          size: 12, color: Colors.white),
                      onPressed: widget.onRechazar,
                    ),
                  ),
                ]),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// ─── Fila de detalle ──────────────────────────────────────────────────────────
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
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FaIcon(icon, size: 13, color: AppColors.secondary),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: AppTextStyles.caption
                  .copyWith(color: AppColors.iconGray)),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.bodyBold),
        ]),
      ),
    ]);
  }
}
