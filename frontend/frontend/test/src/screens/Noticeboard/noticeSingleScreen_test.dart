import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';

void main() {
  testWidgets('noticeSingleScreen ...', (WidgetTester tester) async {
    await tester.pumpWidget(Notice());

    //final fabFinder = find.widgetWithIcon(FloatingActionButton, Icons.add);
    //expect(fabFinder, findsOneWidget);
    expect(
        find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
  });
}
