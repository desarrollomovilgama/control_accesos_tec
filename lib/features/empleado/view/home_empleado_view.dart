/// @file    home_empleado_view.dart
/// @author  Jesús David Johnson Soto
/// @version 2.0
/// Home del rol Empleado — scaffold + BottomNav únicamente.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_text_styles.dart';
import 'tab_mis_solicitudes.dart';
import 'tab_mis_visitantes.dart';
import 'tab_nueva_solicitud.dart';
import 'tab_perfil.dart';

class HomeEmpleadoView extends StatefulWidget {
  const HomeEmpleadoView({super.key});

  @override
  State<HomeEmpleadoView> createState() => _HomeEmpleadoViewState();
}

class _HomeEmpleadoViewState extends State<HomeEmpleadoView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Mi Espacio'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(
                FontAwesomeIcons.rightFromBracket, size: 18),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),

      // Orden: 0-Solicitudes | 1-Mis visitantes | 2-Nueva solicitud | 3-Perfil
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          TabMisSolicitudes(),  // 0
          TabMisVisitantes(),   // 1
          TabNuevaSolicitud(),  // 2
          TabPerfil(),          // 3
        ],
      ),

      // FAB "Nueva visita" visible en tab 0 y tab 1
      floatingActionButton:
          (_selectedIndex == 0 || _selectedIndex == 1)
              ? FloatingActionButton.extended(
                  onPressed: () => setState(() => _selectedIndex = 2),
                  backgroundColor: AppColors.primary,
                  icon: const FaIcon(FontAwesomeIcons.plus,
                      size: 16, color: Colors.white),
                  label: Text('Nueva visita',
                      style: AppTextStyles.button
                          .copyWith(fontSize: 13, color: Colors.white)),
                )
              : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.listCheck, size: 17),
            label: 'Solicitudes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.usersLine, size: 17),
            label: 'Mis visitantes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plus, size: 17),
            label: 'Nueva',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, size: 17),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
