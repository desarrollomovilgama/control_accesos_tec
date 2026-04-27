/// @file    home_guardia_view.dart
/// @author  Jesús David Johnson Soto
/// @version 3.0
/// Home del Guardia — scaffold + BottomNav únicamente.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_styles.dart';
import 'tab_escaneo_qr.dart';
import 'tab_nueva_visita.dart';
import 'tab_registro_manual.dart';
import 'tab_visitas_activas.dart';

class HomeGuardiaView extends StatefulWidget {
  const HomeGuardiaView({super.key});

  @override
  State<HomeGuardiaView> createState() => _HomeGuardiaViewState();
}

class _HomeGuardiaViewState extends State<HomeGuardiaView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Control de Accesos · Guardia'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell, size: 18),
            onPressed: () {},
            tooltip: 'Notificaciones',
          ),
          IconButton(
            icon: const FaIcon(
                FontAwesomeIcons.rightFromBracket, size: 18),
            onPressed: () => _confirmLogout(context),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          TabEscaneoQR(),       // 0
          TabVisitasActivas(),  // 1
          TabRegistroManual(),  // 2
          TabNuevaVisita(),     // 3
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.qrcode, size: 17),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.usersLine, size: 17),
            label: 'Visitas',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.hashtag, size: 17),
            label: 'Manual',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plus, size: 17),
            label: 'Nueva visita',
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title  : Text('Cerrar sesión', style: AppTextStyles.subtitle),
        content: Text('¿Deseas salir del sistema?', style: AppTextStyles.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Salir',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
