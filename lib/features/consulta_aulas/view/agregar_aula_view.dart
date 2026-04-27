/// =============================================================================
/// agregar_aula_view.dart
/// -----------------------------------------------------------------------------
/// Formulario para registrar un aula nueva en el catálogo. Solo accesible
/// para docentes / laboratoristas (la vista no se enlaza para estudiantes).
///
/// Este archivo orquesta el formulario; los campos se delegan a
/// /widgets/agregar_aula_form.dart para mantener el archivo bajo 200 líneas.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/spacing/app_spacing.dart';
import '../viewmodel/consulta_viewmodel.dart';
import '../widgets/agregar_aula_form.dart';

class AgregarAulaView extends StatelessWidget {
  /// Recibe el ViewModel de la lista para poder agregar el aula al catálogo
  /// existente y refrescar la vista padre cuando se vuelve.
  const AgregarAulaView({super.key, required this.viewModel});

  final ConsultaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // Inyectamos el VM existente para que el form pueda llamarle agregarAula().
    return ChangeNotifierProvider<ConsultaViewModel>.value(
      value: viewModel,
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar aula')),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingScreen,
        child: AgregarAulaForm(
          onGuardada: (mensaje) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(mensaje)),
            );
            Navigator.of(context).pop();
          },
          onError: (mensaje) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(mensaje)),
            );
          },
        ),
      ),
    );
  }
}
