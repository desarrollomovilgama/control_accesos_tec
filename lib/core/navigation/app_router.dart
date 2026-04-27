/// @file    app_router.dart
/// @author  Jesús David Johnson Soto
/// @version 2.0
/// Enrutador central — GAMA MPF v1.0
/// Roles: guardia | anfitrion | empleado

import 'package:flutter/material.dart';

import '../../features/auth/view/login_view.dart';
import '../../features/guardia/view/home_guardia_view.dart';
import '../../features/guardia/view/registro_visita_view.dart';
import '../../features/guardia/model/registro_visita_model.dart';
import '../../features/anfitrion/view/home_anfitrion_view.dart';
import '../../features/empleado/view/home_empleado_view.dart';

abstract class AppRoutes {
  static const login          = '/login';
  static const homeGuardia    = '/home/guardia';
  static const homeAnfitrion  = '/home/anfitrion';
  static const homeEmpleado   = '/home/empleado';
  static const registroVisita = '/registro-visita';
}

const String initialRoute = AppRoutes.login;

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
    case '/':
    case AppRoutes.login:
      page = const LoginView();

    case AppRoutes.homeGuardia:
      page = const HomeGuardiaView();

    case AppRoutes.homeAnfitrion:
      page = const HomeAnfitrionView();

    case AppRoutes.homeEmpleado:
      page = const HomeEmpleadoView();

    case AppRoutes.registroVisita:
      final registro = settings.arguments as RegistroVisita;
      page = RegistroVisitaView(registro: registro);

    default:
      page = Scaffold(
        body: Center(
          child: Text('Ruta no encontrada: ${settings.name}'),
        ),
      );
  }

  return MaterialPageRoute(builder: (_) => page, settings: settings);
}
