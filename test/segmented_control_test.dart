import 'dart:ui' show lerpDouble;

import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late int selected;
  late int calls;
  late double width;
  late bool showAnimation;
  late bool acceptTaps;
  late bool disableAnimations;
  late bool accessibleNavigation;
  late StateSetter setHost;

  setUp(() {
    selected = 0;
    calls = 0;
    width = 300;
    showAnimation = true;
    acceptTaps = true;
    disableAnimations = false;
    accessibleNavigation = false;
  });

  Future<void> pumpHost(WidgetTester tester) {
    return tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: StatefulBuilder(builder: (context, setState) {
            setHost = setState;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                disableAnimations: disableAnimations,
                accessibleNavigation: accessibleNavigation,
              ),
              child: SizedBox(
                width: width,
                child: CoconutSegmentedControl(
                  isSelected: [for (var i = 0; i < 3; i++) i == selected],
                  onPressed: (index) => setState(() {
                    if (acceptTaps) selected = index;
                    calls++;
                  }),
                  showAnimation: showAnimation,
                  children: const [Text('A'), Text('B'), Text('C')],
                ),
              ),
            );
          }),
        ),
      ),
    ));
  }

  // Rendered bounds of the sliding pill and of a segment's tappable surface.
  Rect pill(WidgetTester tester) => tester.getRect(find
      .descendant(
        of: find.descendant(of: find.byType(CoconutSegmentedControl), matching: find.byType(Positioned)),
        matching: find.byType(Container),
      )
      .first);
  Rect segment(WidgetTester tester, String label) =>
      tester.getRect(find.ancestor(of: find.text(label), matching: find.byType(InkWell)).first);
  void expectPillOn(WidgetTester tester, String label) =>
      expect(pill(tester), rectMoreOrLessEquals(segment(tester, label), epsilon: 1e-6));
  double eased(WidgetTester tester, String from, String to, double t) =>
      lerpDouble(segment(tester, from).left, segment(tester, to).left, Curves.easeInOut.transform(t))!;

  testWidgets('idle control schedules no frames and settles', (tester) async {
    selected = 1;
    await pumpHost(tester);
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
    await tester.pumpAndSettle();
  });

  testWidgets('first frame paints the pill on the initially selected segment', (tester) async {
    selected = 2;
    await pumpHost(tester);
    expectPillOn(tester, 'C');
  });

  testWidgets('tap slides the pill for 250ms with easeInOut and fires once', (tester) async {
    await pumpHost(tester);
    await tester.tap(find.text('C'));
    await tester.pump();
    expect(calls, 1);
    expect(selected, 2);
    await tester.pump(const Duration(milliseconds: 125));
    expect(pill(tester).left, closeTo(eased(tester, 'A', 'C', 0.5), 1e-6));
    await tester.pump(const Duration(milliseconds: 125));
    expectPillOn(tester, 'C');
    await tester.pumpAndSettle();
    expect(calls, 1);
  });

  testWidgets('re-tap during the slide starts from the current position', (tester) async {
    await pumpHost(tester);
    await tester.tap(find.text('C'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 125));
    final midway = pill(tester).left;
    await tester.tap(find.text('A'));
    await tester.pump();
    expect(pill(tester).left, closeTo(midway, 1e-6));
    await tester.pump(const Duration(milliseconds: 250));
    expectPillOn(tester, 'A');
    await tester.pumpAndSettle();
    expect(calls, 2);
    expect(selected, 0);
  });

  testWidgets('pointer cancel keeps the selection and fires no callback', (tester) async {
    await pumpHost(tester);
    final gesture = await tester.startGesture(tester.getCenter(find.text('B')));
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.cancel();
    await tester.pumpAndSettle();
    expect(calls, 0);
    expect(selected, 0);
    expectPillOn(tester, 'A');
  });

  testWidgets('external selection change jumps to the new segment and idles', (tester) async {
    await pumpHost(tester);
    setHost(() => selected = 2);
    await tester.pump();
    expectPillOn(tester, 'C');
    expect(tester.binding.hasScheduledFrame, isFalse);
    expect(calls, 0);
  });

  testWidgets('resize after a tap keeps the pill on the selected segment', (tester) async {
    await pumpHost(tester);
    await tester.tap(find.text('B'));
    await tester.pumpAndSettle();
    expectPillOn(tester, 'B');
    setHost(() => width = 450);
    await tester.pump();
    expect(segment(tester, 'B').width, closeTo(450 / 3 - 4, 1e-6));
    expectPillOn(tester, 'B');
  });

  testWidgets('a tap the parent rejects keeps the pill on the old segment', (tester) async {
    acceptTaps = false;
    await pumpHost(tester);
    await tester.tap(find.text('C'));
    await tester.pumpAndSettle();
    expect(calls, 1);
    expect(selected, 0);
    expectPillOn(tester, 'A');
  });

  testWidgets('showAnimation can be turned on at runtime after a static tap', (tester) async {
    showAnimation = false;
    selected = 1;
    await pumpHost(tester);
    await tester.tap(find.text('C'));
    await tester.pumpAndSettle();
    expect(selected, 2);
    setHost(() => showAnimation = true);
    await tester.pump();
    expect(tester.takeException(), isNull);
    expectPillOn(tester, 'C');
  });

  testWidgets('turning showAnimation off mid-slide then unmounting is clean', (tester) async {
    await pumpHost(tester);
    await tester.tap(find.text('C'));
    await tester.pump(const Duration(milliseconds: 100));
    setHost(() => showAnimation = false);
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });

  testWidgets('taps leave no undisposed CurvedAnimation behind', (tester) async {
    final alive = <Object>{};
    void track(ObjectEvent event) {
      if (event.object is! CurvedAnimation) return;
      if (event is ObjectCreated) alive.add(event.object);
      if (event is ObjectDisposed) alive.remove(event.object);
    }

    FlutterMemoryAllocations.instance.addListener(track);
    addTearDown(() => FlutterMemoryAllocations.instance.removeListener(track));
    await pumpHost(tester);
    for (final label in ['B', 'C', 'A', 'B']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }
    await tester.pumpWidget(const SizedBox());
    expect(alive, isEmpty);
  });

  // Each reduced-motion flag is tested on its own, from startup and switched live.
  void setFlag(String flag, bool on) {
    if (flag == 'disableAnimations') {
      disableAnimations = on;
    } else {
      accessibleNavigation = on;
    }
  }

  for (final flag in ['disableAnimations', 'accessibleNavigation']) {
    testWidgets('reduced motion via $flag moves the pill without sliding', (tester) async {
      setFlag(flag, true);
      await pumpHost(tester);
      await tester.tap(find.text('C'));
      await tester.pump();
      expectPillOn(tester, 'C');
      expect(calls, 1);
    });

    testWidgets('$flag switched on mid-slide lands the pill at once; switched off, taps slide again', (tester) async {
      await pumpHost(tester);
      await tester.tap(find.text('C'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(pill(tester).left, lessThan(segment(tester, 'C').left - 1));
      setHost(() => setFlag(flag, true));
      await tester.pump();
      expect(tester.takeException(), isNull);
      expectPillOn(tester, 'C');

      await tester.tap(find.text('B'));
      await tester.pump();
      expectPillOn(tester, 'B');

      setHost(() => setFlag(flag, false));
      await tester.pump();
      await tester.tap(find.text('A'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 125));
      expect(pill(tester).left, closeTo(eased(tester, 'B', 'A', 0.5), 1e-6));
      await tester.pumpAndSettle();
      expectPillOn(tester, 'A');
      expect(calls, 3);
      expect(tester.takeException(), isNull);
    });
  }

  for (final animated in [true, false]) {
    testWidgets('segments announce button, group and selected state (showAnimation: $animated)', (tester) async {
      final semantics = tester.ensureSemantics();
      showAnimation = animated;
      selected = 1;
      await pumpHost(tester);
      for (final (index, label) in ['A', 'B', 'C'].indexed) {
        expect(
          tester.getSemantics(find.text(label)),
          containsSemantics(
            label: label,
            isButton: true,
            isInMutuallyExclusiveGroup: true,
            hasSelectedState: true,
            isSelected: index == 1,
            hasTapAction: true,
          ),
        );
      }
      await tester.tap(find.text('C'));
      await tester.pumpAndSettle();
      expect(tester.getSemantics(find.text('C')), containsSemantics(hasSelectedState: true, isSelected: true));
      expect(tester.getSemantics(find.text('B')), containsSemantics(hasSelectedState: true, isSelected: false));
      semantics.dispose();
    });
  }
}
