import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// Importamos el main de nuestra app para poder lanzarla
import 'package:flutter_ci_lab/main.dart' as app;

void main() {
  // Inicializamos el puente entre el test y el dispositivo
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flujo completo: Verificar inicio e incremento', (tester) async {
    // 1. ARRANGE: Cargar la app
    app.main();
    // Esperamos a que la app termine de "pintarse" completamente
    await tester.pumpAndSettle();

    // 2. ASSERT (Estado Inicial): Verificar que el contador está en 0
    expect(find.text('0'), findsOneWidget);

    // Buscamos el botón por su Key
    final Finder fab = find.byKey(const Key('increment_button'));

    // 3. ACT: Simular el toque del usuario
    await tester.tap(fab);

    // Esperamos a que la animación del botón termine
    await tester.pumpAndSettle();

    // 4. ASSERT (Estado Final): Verificar que cambió a 1
    expect(find.text('1'), findsOneWidget);
  });
}
