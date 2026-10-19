import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:siga_keep_logged_in/main.dart';

void main() {
  testWidgets('SigaApp usa o título e o tema Material 3', (tester) async {
    // A WebView não roda no ambiente de teste, então injeta um placeholder.
    await tester.pumpWidget(const SigaApp(home: Scaffold(body: Text('home'))));

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.title, 'SIGA Alunos');
    expect(app.theme?.useMaterial3, isTrue);
    expect(find.text('home'), findsOneWidget);
  });

  test('URL de login aponta para o SIGA', () {
    expect(Uri.parse(sigaLoginUrl).host, 'siga.cps.sp.gov.br');
  });
}
