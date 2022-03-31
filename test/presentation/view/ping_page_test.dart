import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:nitor_ping/core/constant.dart';
import 'package:nitor_ping/injection_container.dart' as ic;

import 'package:nitor_ping/main.dart';

void main() {
  setUpAll((){
    ic.getIt = GetIt.instance;
    //Setting up DI
    ic.setUp();
  });
  testWidgets(
      'when button is not pressed then Press button message should be displayed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text(Constant.initMsg), findsOneWidget);
  });

  testWidgets(
      'when button is pressed then Press button message should not be displayed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.runAsync(() async {
      await tester.tap(find.byIcon(Icons.network_ping_sharp));

      await tester.pumpAndSettle();
      expect(find.text(Constant.initMsg), findsNothing);
    });
  });
}
