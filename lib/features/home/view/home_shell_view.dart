/// =============================================================================
/// home_shell_view.dart
/// -----------------------------------------------------------------------------
/// Shell principal con BottomNavigationBar. Apartado 4.2 (Patrones de
/// estructura frecuentes — Figura 38) del MPF.
///
/// Pestañas:
///   0. Inicio   → resumen del día y accesos rápidos
///   1. Escanear → cámara para leer QR del aula
///   2. Buscar   → búsqueda de aulas / docentes / materias
///   3. Perfil   → datos del usuario y opciones (estatus, historial)
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../busqueda/view/busqueda_view.dart';
import '../../escaneo_qr/view/qr_scanner_view.dart';
import '../../perfil/view/perfil_view.dart';
import '../viewmodel/home_viewmodel.dart';
import 'inicio_view.dart';

class HomeShellView extends StatelessWidget {
  const HomeShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeShellScaffold(),
    );
  }
}

class _HomeShellScaffold extends StatelessWidget {
  const _HomeShellScaffold();

  static const _pestanas = <Widget>[
    InicioView(),
    QrScannerView(),
    BusquedaView(),
    PerfilView(),
  ];

  static const _titulos = ['Inicio', 'Escanear QR', 'Búsqueda', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(_titulos[vm.indiceActual])),
      body: IndexedStack(
        index: vm.indiceActual,
        children: _pestanas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: vm.indiceActual,
        onTap: vm.cambiarIndice,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.qrScan),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.profile),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
