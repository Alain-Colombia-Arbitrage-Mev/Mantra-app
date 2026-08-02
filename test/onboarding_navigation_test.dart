import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantralia/screens/onboarding_flow.dart';

void main() {
  testWidgets('manifestation story advances to the intention story', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(440, 956);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: OnboardingFlow()));
    await tester.pump();

    PageController controller() =>
        tester.widget<PageView>(find.byType(PageView)).controller!;

    controller().jumpToPage(2);
    await tester.pump();
    expect(controller().page, closeTo(2, .01));

    await tester.tapAt(const Offset(392, 876));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(controller().page, closeTo(3, .01));

    await tester.tapAt(const Offset(392, 876));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(controller().page, closeTo(4, .01));
  });
}
