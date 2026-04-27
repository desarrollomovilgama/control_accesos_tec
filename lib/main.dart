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
    );
  }
}
