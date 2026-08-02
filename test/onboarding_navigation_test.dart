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

  testWidgets('paywall supports plan selection and the free continuation', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(440, 956);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: OnboardingFlow()));
    await tester.pump();

    final controller = tester
        .widget<PageView>(find.byType(PageView))
        .controller!;
    controller.jumpToPage(11);
    await tester.pump();

    final monthly = find.byKey(const Key('paywall_plan_monthly'));
    final annual = find.byKey(const Key('paywall_plan_annual'));
    bool isSelected(Finder target) => tester
        .widget<Semantics>(
          find.descendant(of: target, matching: find.byType(Semantics)).first,
        )
        .properties
        .selected!;
    expect(monthly, findsOneWidget);
    expect(annual, findsOneWidget);
    expect(isSelected(monthly), isFalse);
    expect(isSelected(annual), isTrue);

    await tester.tap(monthly);
    await tester.pump(const Duration(milliseconds: 200));
    expect(isSelected(monthly), isTrue);
    expect(isSelected(annual), isFalse);

    await tester.tap(find.byKey(const Key('paywall_continue_free')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(controller.page, closeTo(12, .01));
  });

  testWidgets('paywall keeps controls inside iPhone safe areas', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(440, 956);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(
            size: Size(440, 956),
            padding: EdgeInsets.only(top: 62, bottom: 34),
          ),
          child: OnboardingFlow(),
        ),
      ),
    );
    await tester.pump();

    final controller = tester
        .widget<PageView>(find.byType(PageView))
        .controller!;
    controller.jumpToPage(11);
    await tester.pump(const Duration(milliseconds: 300));

    final close = find.byKey(const Key('paywall_close'));
    final cta = find.byKey(const Key('paywall_continue'));
    final restore = find.byKey(const Key('paywall_restore'));
    expect(tester.getTopLeft(close).dy, greaterThanOrEqualTo(62));
    expect(tester.getTopLeft(cta).dy, greaterThan(650));
    expect(tester.getBottomRight(restore).dy, lessThanOrEqualTo(922));
  });
}
