<<<<<<< HEAD
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
=======
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Ya lo tienes así — está bien
import 'package:pr_c/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ControlAccesosApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
  });
}
