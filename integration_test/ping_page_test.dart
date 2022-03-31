import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nitor_ping/core/constant.dart';
import 'package:nitor_ping/main.dart';
import 'package:nitor_ping/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const String btnText = Constant.initMsg;
  testWidgets('Complete workflow test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
    expect(find.text(btnText), findsOneWidget);

    final Finder fab = find.byIcon(Icons.network_ping_sharp);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    expect(find.text(Constant.loading), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text(btnText), findsNothing);

    await tester.pump(const Duration(seconds: 10));
  });
}
