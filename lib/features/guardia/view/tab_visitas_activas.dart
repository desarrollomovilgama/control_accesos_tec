/// @file    tab_visitas_activas.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de visitas activas — Guardia gestiona el ciclo de vida completo.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_icons.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../model/visitante_model.dart';
import '../widgets/visitante_card.dart';
import '../widgets/visitante_chips.dart';

class TabVisitasActivas extends StatefulWidget {
  const TabVisitasActivas({super.key});

  @override
  State<TabVisitasActivas> createState() => _TabVisitasActivasState();
}

class _TabVisitasActivasState extends State<TabVisitasActivas> {
  late final Timer _timer;

  final List<Visitante> _visitantes = [
    Visitante(
      id: 'VIS-001', nombre: 'Carlos Mejía Hernández',
      destino: 'Depto. Sistemas · Ofic. 204', horaEstimada: '08:30',
      entradaAt: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 48)),
      estatus: EstatusVisita.enInstituto,
    ),
    Visitante(
      id: 'VIS-002', nombre: 'Laura Torres Ríos',
      destino: 'Dirección General · Piso 3', horaEstimada: '09:00',
      entradaAt: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 10)),
      estatus: EstatusVisita.enOficina,
    ),
    Visitante(
      id: 'VIS-003', nombre: 'Roberto Fuentes Cruz',
      destino: 'Depto. Académico · Ofic. 101', horaEstimada: '07:45',
      entradaAt: DateTime.now().subtract(
          const Duration(hours: 2, minutes: 25)),
      estatus: EstatusVisita.salidoOficina,
    ),
    Visitante(
      id: 'VIS-004', nombre: 'Andrea Ríos Castillo',
      destino: 'Recursos Humanos · Ofic. 015', horaEstimada: '10:00',
      estatus: EstatusVisita.enEspera,
    ),
  ];

  EstatusVisita? _filtro;
  bool _mostrarSalidos = false;

  List<Visitante> get _filtrados {
    var lista = _mostrarSalidos
        ? _visitantes
        : _visitantes
            .where((v) => v.estatus != EstatusVisita.salidoInstituto)
            .toList();
    if (_filtro != null) {
      lista = lista.where((v) => v.estatus == _filtro).toList();
    }
    return lista;
  }

  int _count(EstatusVisita e) =>
      _visitantes.where((v) => v.estatus == e).length;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _confirmarEntrada(Visitante v) {
    setState(() {
      v.estatus  = EstatusVisita.enInstituto;
      v.entradaAt = DateTime.now();
    });
    _snack('Entrada registrada: ${v.nombre}', AppColors.success);
  }

  void _confirmarSalidaOficina(Visitante v) {
    setState(() => v.estatus = EstatusVisita.salidoOficina);
    _snack('${v.nombre} salió de la oficina', AppColors.info);
  }

  void _confirmarSalidaInstituto(Visitante v) {
    setState(() => v.estatus = EstatusVisita.salidoInstituto);
    _snack('Salida del instituto: ${v.nombre}', AppColors.error);
  }

  void _snack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  String _tiempo(DateTime desde) {
    final d = DateTime.now().difference(desde);
    if (d.inHours >= 1) {
      final m = d.inMinutes.remainder(60);
      return m > 0 ? '${d.inHours}h ${m}min' : '${d.inHours}h';
    }
    return '${d.inMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Resumen ──────────────────────────────────────────────
        Container(
          color: AppColors.iceBlue,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH, vertical: AppSpacing.sm),
          child: Row(children: [
            ResChip(label: 'Espera',
                count: _count(EstatusVisita.enEspera),
                color: AppColors.iconGray),
            const SizedBox(width: AppSpacing.xs),
            ResChip(label: 'Instituto',
                count: _count(EstatusVisita.enInstituto),
                color: AppColors.warning),
            const SizedBox(width: AppSpacing.xs),
            ResChip(label: 'Oficina',
                count: _count(EstatusVisita.enOficina),
                color: AppColors.success),
            const SizedBox(width: AppSpacing.xs),
            ResChip(label: 'Salió',
                count: _count(EstatusVisita.salidoOficina),
                color: AppColors.info),
          ]),
        ),

        // ── Filtros ──────────────────────────────────────────────
        Container(
          color: AppColors.appBackground,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenH, vertical: AppSpacing.xs),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              FiltroChip(
                label    : 'Todos',
                selected : _filtro == null,
                color    : AppColors.primary,
                onTap    : () => setState(() => _filtro = null),
              ),
              const SizedBox(width: AppSpacing.xs),
              ...[
                EstatusVisita.enEspera,
                EstatusVisita.enInstituto,
                EstatusVisita.enOficina,
                EstatusVisita.salidoOficina,
              ].map((e) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: FiltroChip(
                  label    : e.label,
                  selected : _filtro == e,
                  color    : e.color,
                  onTap    : () => setState(() => _filtro = e),
                ),
              )),
              GestureDetector(
                onTap: () => setState(() {
                  _mostrarSalidos = !_mostrarSalidos;
                  if (!_mostrarSalidos &&
                      _filtro == EstatusVisita.salidoInstituto) {
                    _filtro = null;
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: _mostrarSalidos
                        ? AppColors.borderGray.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderGray),
                  ),
                  child: Text(
                    _mostrarSalidos ? 'Ocultar salidos' : 'Ver salidos',
                    style: AppTextStyles.captionBold
                        .copyWith(color: AppColors.iconGray),
                  ),
                ),
              ),
            ]),
          ),
        ),

        // ── Lista ────────────────────────────────────────────────
        Expanded(
          child: _filtrados.isEmpty
              ? Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const FaIcon(AppIcons.users,
                        size: 48, color: AppColors.borderGray),
                    const SizedBox(height: AppSpacing.md),
                    Text('Sin visitantes',
                        style: AppTextStyles.body
                            .copyWith(color: AppColors.iconGray)),
                  ]),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.screenH),
                  itemCount: _filtrados.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.listItemGap),
                  itemBuilder: (ctx, i) {
                    final v = _filtrados[i];
                    return VisitanteCard(
                      visitante         : v,
                      tiempoTranscurrido: v.entradaAt != null
                          ? _tiempo(v.entradaAt!)
                          : null,
                      onEntrada         : v.estatus == EstatusVisita.enEspera
                          ? () => _confirmarEntrada(v)
                          : null,
                      onSalidaOficina   : v.estatus == EstatusVisita.enOficina
                          ? () => _confirmarSalidaOficina(v)
                          : null,
                      onSalidaInstituto :
                          v.estatus.dentroDelInstituto
                          ? () => _confirmarSalidaInstituto(v)
                          : null,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
