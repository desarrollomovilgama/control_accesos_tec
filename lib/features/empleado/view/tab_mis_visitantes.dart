/// @file    tab_mis_visitantes.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de visitantes activos — perspectiva del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../model/visitante_emp_model.dart';
import '../widgets/visitante_emp_card.dart';

class TabMisVisitantes extends StatefulWidget {
  const TabMisVisitantes({super.key});

  @override
  State<TabMisVisitantes> createState() => _TabMisVisitantesState();
}

class _TabMisVisitantesState extends State<TabMisVisitantes> {
  // Datos demo — reemplazar con repositorio filtrado por empleado actual
  final List<VisitanteEmp> _visitantes = [
    VisitanteEmp(
      nombre       : 'Carlos Mejía Hernández',
      correo       : 'carlos.mejia@softtech.com',
      horaEstimada : '08:30',
      estatus      : EstatusVisitante.enInstituto,
    ),
    VisitanteEmp(
      nombre       : 'Andrea Ríos Castillo',
      correo       : 'andrea.rios@indtech.mx',
      horaEstimada : '10:00',
      estatus      : EstatusVisitante.enEspera,
    ),
    VisitanteEmp(
      nombre       : 'Pedro Sánchez Vargas',
      correo       : 'pedro.sv@outlook.com',
      horaEstimada : '09:15',
      estatus      : EstatusVisitante.salidoInstituto,
    ),
  ];

  void _confirmarLlegadaOficina(VisitanteEmp v) {
    setState(() => v.estatus = EstatusVisitante.enOficina);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${v.nombre} llegó a tu oficina'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _confirmarSalidaOficina(VisitanteEmp v) {
    setState(() => v.estatus = EstatusVisitante.salidoOficina);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${v.nombre} salió de tu oficina — sigue en el instituto'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: _visitantes.length + 1,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.listItemGap),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mis visitantes de hoy', style: AppTextStyles.subtitle),
                const SizedBox(height: 2),
                Text(
                  'Confirma la llegada a tu oficina y su salida.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          );
        }
        final v = _visitantes[i - 1];
        return VisitanteEmpCard(
          visitante        : v,
          onLlegadaOficina : v.estatus == EstatusVisitante.enInstituto
              ? () => _confirmarLlegadaOficina(v)
              : null,
          onSalidaOficina  : v.estatus == EstatusVisitante.enOficina
              ? () => _confirmarSalidaOficina(v)
              : null,
        );
      },
    );
  }
}
