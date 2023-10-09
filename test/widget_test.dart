// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:anywhere_app/pages/topic_details.dart';
import 'package:anywhere_app/pages/topics_model.dart';

void main() {
  testWidgets('AppBar title smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TopicDetails(
        isInTabletLayout: true,
        topic: Topic(
            result: 'Test Result', iconHeight: '10', iconURL: '/test.png', iconWidth: '10', detail: 'Test Details')));

    // Create the Finders.
    final detailsFinder = find.text('Result Details');

    // Verify that our result text is rendered.
    expect(detailsFinder, findsOneWidget);
  });
}
