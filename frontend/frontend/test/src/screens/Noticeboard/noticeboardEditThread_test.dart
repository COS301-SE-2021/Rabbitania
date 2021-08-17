import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';

void main() {
  testWidgets('noticeboardEditThread ...', (WidgetTester tester) async {
    await tester.pumpWidget(NoticeBoardEditThread());

    final fabFinder = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabFinder, findsOneWidget);
  });
}
