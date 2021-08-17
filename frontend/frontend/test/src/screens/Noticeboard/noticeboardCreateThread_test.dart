import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardCreateThread.dart';

void main() {
  testWidgets('noticeboardCreateThread ...', (WidgetTester tester) async {
    await tester.pumpWidget(NoticeBoardThread());

    final fabFinder = find.widgetWithIcon(FloatingActionButton, Icons.menu);
    expect(fabFinder, findsOneWidget);
  });
}
