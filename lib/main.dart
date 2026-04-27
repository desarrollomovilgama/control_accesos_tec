<<<<<<< HEAD
/// =============================================================================
/// main.dart
/// -----------------------------------------------------------------------------
/// Punto de entrada de la aplicación Control de Aulas.
/// Apartado 4.2 (Figura 14) y 7.1 del Manual de Programación Flutter (MPF).
///
/// Responsabilidades:
///   - Cargar variables de entorno (.env) antes de runApp.
///   - Inicializar Hive (persistencia local).
///   - Registrar SessionService global (Provider raíz).
///   - Configurar tema, localizaciones y rutas nombradas.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'core/session/session_service.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carga de variables de entorno (.env). En modo demo no es obligatorio.
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // .env aún no existe; el archivo .env.example documenta las claves.
  }

  // Inicialización de Hive para persistencia local (apartado 6 del MPF).
  await Hive.initFlutter();

  runApp(const ControlAulasApp());
}

class ControlAulasApp extends StatelessWidget {
  const ControlAulasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Sesión global accesible desde cualquier vista (apartado 4.3 del MPF).
        ChangeNotifierProvider<SessionService>(
          create: (_) => SessionService(),
        ),
      ],
      child: MaterialApp(
        title: 'Control de Aulas',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        // Localización (apartado 4.2, Figura 11 del MPF).
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
          Locale('en'),
        ],
        locale: const Locale('es'),
        // Navegación por rutas nombradas (Figura 46 del MPF).
        initialRoute: RouteNames.splash,
        onGenerateRoute: AppRoutes.generate,
      ),
=======
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ControlAccesosApp());
}

class ControlAccesosApp extends StatelessWidget {
  const ControlAccesosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title           : 'Control de Accesos · ITT',
      debugShowCheckedModeBanner: false,
      theme           : AppTheme.theme,
      initialRoute    : initialRoute,        // '/login'
      onGenerateRoute : onGenerateRoute,     // app_router.dart
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
    );
  }
}
