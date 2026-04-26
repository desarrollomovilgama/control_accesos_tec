// =============================================================================
// widget_test.dart
// -----------------------------------------------------------------------------
// Test mínimo de smoke. Solo verifica que la app arranca sin excepciones.
// =============================================================================

import 'package:flutter_test/flutter_test.dart';

import 'package:control_aulas/main.dart';

void main() {
  testWidgets('La app arranca sin excepciones', (WidgetTester tester) async {
    await tester.pumpWidget(const ControlAulasApp());
    // Una bomba inicial es suficiente para validar que el árbol de widgets
    // se construye correctamente.
    await tester.pump();
  });
}
