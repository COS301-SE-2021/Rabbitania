import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';

void main() {
  testWidgets(
      'noticeboardScreen, the user on then home page can access and press the add floating action button',
      (WidgetTester tester) async {
    await tester.pumpWidget(NoticeBoard());

    final fabFinder = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabFinder, findsOneWidget);
  });
}
