/// =============================================================================
/// app_routes.dart
/// -----------------------------------------------------------------------------
/// Generador de rutas centralizado (onGenerateRoute). Apartado 4.2 del MPF.
/// Recibe `RouteSettings` y devuelve la pantalla correspondiente, permitiendo
/// además recibir argumentos tipados entre vistas (Figuras 47-48 del MPF).
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../features/autenticacion/view/login_view.dart';
import '../../features/autenticacion/view/splash_view.dart';
import '../../features/busqueda/view/busqueda_view.dart';
import '../../features/busqueda/view/resultados_view.dart';
import '../../features/consulta_aulas/view/aula_detalle_view.dart';
import '../../features/consulta_aulas/view/consulta_aulas_view.dart';
import '../../features/escaneo_qr/view/aula_info_view.dart';
import '../../features/escaneo_qr/view/qr_scanner_view.dart';
import '../../features/escaneo_qr/view/sin_conexion_view.dart';
import '../../features/estatus_docente/view/lista_estatus_view.dart';
import '../../features/estatus_docente/view/registro_estatus_view.dart';
import '../../features/home/view/home_shell_view.dart';
import '../../features/perfil/view/perfil_view.dart';
import '../../features/solicitudes_apertura/view/confirmacion_view.dart';
import '../../features/solicitudes_apertura/view/solicitud_view.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _build(const SplashView(), settings);

      case RouteNames.login:
        return _build(const LoginView(), settings);

      case RouteNames.home:
        return _build(const HomeShellView(), settings);

      case RouteNames.qrScanner:
        return _build(const QrScannerView(), settings);

      case RouteNames.aulaInfo:
        // Ejemplo de paso de parámetros entre pantallas (Fig. 47-48 del MPF).
        final args = settings.arguments as Map<String, dynamic>?;
        return _build(
          AulaInfoView(codigoAula: args?['codigoAula'] as String? ?? '---'),
          settings,
        );

      case RouteNames.sinConexion:
        return _build(const SinConexionView(), settings);

      case RouteNames.consultaAulas:
        return _build(const ConsultaAulasView(), settings);

      case RouteNames.aulaDetalle:
        final args = settings.arguments as Map<String, dynamic>?;
        return _build(
          AulaDetalleView(codigoAula: args?['codigoAula'] as String? ?? '---'),
          settings,
        );

      case RouteNames.busqueda:
        return _build(const BusquedaView(), settings);

      case RouteNames.resultadosBusqueda:
        final args = settings.arguments as Map<String, dynamic>?;
        return _build(
          ResultadosView(query: args?['query'] as String? ?? ''),
          settings,
        );

      case RouteNames.registroEstatus:
        return _build(const RegistroEstatusView(), settings);

      case RouteNames.listaEstatus:
        return _build(const ListaEstatusView(), settings);

      case RouteNames.solicitudApertura:
        final args = settings.arguments as Map<String, dynamic>?;
        return _build(
          SolicitudView(codigoLab: args?['codigoLab'] as String? ?? '---'),
          settings,
        );

      case RouteNames.confirmacionSolicitud:
        return _build(const ConfirmacionView(), settings);

      case RouteNames.perfil:
        return _build(const PerfilView(), settings);

      default:
        return _build(const _RutaNoEncontrada(), settings);
    }
  }

  static MaterialPageRoute<dynamic> _build(Widget child, RouteSettings s) {
    return MaterialPageRoute(builder: (_) => child, settings: s);
  }
}

class _RutaNoEncontrada extends StatelessWidget {
  const _RutaNoEncontrada();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ruta no encontrada')),
    );
  }
}
