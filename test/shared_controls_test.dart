import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  setUp(() => CoconutTheme.setTheme(Brightness.light));

  group('semantics', () {
    testWidgets('chip announces selected state only when it is selectable', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(_app(Column(children: [
        CoconutChip(color: Colors.black, label: 'On', isSelected: true, onTap: () {}),
        CoconutChip(color: Colors.black, label: 'Off', isSelected: false, onTap: () {}),
        const CoconutChip(color: Colors.black, label: 'Tag'),
      ])));
      expect(
        tester.getSemantics(find.text('On')),
        containsSemantics(label: 'On', isButton: true, hasSelectedState: true, isSelected: true, hasTapAction: true),
      );
      expect(
        tester.getSemantics(find.text('Off')),
        containsSemantics(label: 'Off', isButton: true, hasSelectedState: true, isSelected: false, hasTapAction: true),
      );
      expect(
        tester.getSemantics(find.text('Tag')),
        containsSemantics(isButton: false, hasSelectedState: false, hasTapAction: false),
      );
      semantics.dispose();
    });

    testWidgets('checkbox announces checked and enabled state; disabled ignores taps', (tester) async {
      final semantics = tester.ensureSemantics();
      var changes = 0;
      await tester.pumpWidget(_app(Column(children: [
        CoconutCheckbox(key: const Key('on'), isSelected: true, onChanged: (_) => changes++),
        CoconutCheckbox(key: const Key('off'), isSelected: false, onChanged: (_) => changes++),
        CoconutCheckbox(key: const Key('disabled'), isSelected: true, isDisabled: true, onChanged: (_) => changes++),
      ])));
      expect(
        tester.getSemantics(find.byKey(const Key('on'))),
        containsSemantics(
            hasCheckedState: true,
            isChecked: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            isImage: false),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('off'))),
        containsSemantics(
            hasCheckedState: true,
            isChecked: false,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            isImage: false),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('disabled'))),
        containsSemantics(
            hasCheckedState: true,
            isChecked: true,
            hasEnabledState: true,
            isEnabled: false,
            hasTapAction: false,
            isImage: false),
      );
      await tester.tap(find.byKey(const Key('disabled')));
      expect(changes, 0);
      await tester.tap(find.byKey(const Key('off')));
      expect(changes, 1);
      semantics.dispose();
    });

    // Both buttons keep absorbing pointer taps when inactive; only the announced action changes.
    for (final (name, build) in <(String, Widget Function(String, bool, VoidCallback))>[
      (
        'button',
        (text, active, onPressed) => CoconutButton(text: text, isActive: active, onPressed: onPressed),
      ),
      (
        'underlined button',
        (text, active, onPressed) => CoconutUnderlinedButton(
            text: text, textStyle: CoconutTypography.body2_14, isActive: active, onTap: onPressed),
      ),
    ]) {
      testWidgets('$name announces enabled state; disabled has no tap action and ignores taps', (tester) async {
        final semantics = tester.ensureSemantics();
        var presses = 0;
        var ancestorTaps = 0;
        await tester.pumpWidget(_app(GestureDetector(
          onTap: () => ancestorTaps++,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            build('Go', true, () => presses++),
            build('Stop', false, () => presses++),
          ]),
        )));
        expect(
          tester.getSemantics(find.text('Go')),
          containsSemantics(label: 'Go', isButton: true, hasEnabledState: true, isEnabled: true, hasTapAction: true),
        );
        expect(
          tester.getSemantics(find.text('Stop')),
          containsSemantics(
              label: 'Stop', isButton: true, hasEnabledState: true, isEnabled: false, hasTapAction: false),
        );
        expect(() => tester.semantics.tap(find.semantics.byLabel('Stop')), throwsStateError);
        await tester.tap(find.text('Stop'));
        await tester.pump();
        expect(presses, 0);
        expect(ancestorTaps, 0);
        await tester.tap(find.text('Go'));
        await tester.pump();
        expect(presses, 1);
        expect(ancestorTaps, 0);
        semantics.dispose();
      });
    }
  });

  group('outlined button colors', () {
    BoxDecoration decoration(WidgetTester tester) => tester
        .widget<Container>(find.descendant(of: find.byType(CoconutButton), matching: find.byType(Container)).first)
        .decoration! as BoxDecoration;
    Color textColor(WidgetTester tester) => tester.widget<Text>(find.text('Retry')).style!.color!;
    Color borderColor(WidgetTester tester) => (decoration(tester).border! as Border).top.color;

    Future<TestGesture> press(WidgetTester tester) async {
      final gesture = await tester.startGesture(tester.getCenter(find.byType(CoconutButton)));
      await tester.pump(const Duration(milliseconds: 150));
      return gesture;
    }

    // Warm, light-brightness theme roles (the app's third theme) that brightness defaults cannot express.
    const fill = Color(0xFFFAF8F3);
    const text = Color(0xFF6E3D18);
    const border = Color(0xFFD9C3A5);
    const pressedFill = Color(0xFFF4E9D3);
    const pressedText = Color(0xFF5A3214);

    testWidgets('with a borderColor, honors provided fill, text and pressed colors', (tester) async {
      await tester.pumpWidget(_app(CoconutButton(
        text: 'Retry',
        buttonType: CoconutButtonType.outlined,
        backgroundColor: fill,
        foregroundColor: text,
        borderColor: border,
        pressedBackgroundColor: pressedFill,
        pressedTextColor: pressedText,
        onPressed: () {},
      )));
      expect(decoration(tester).color, fill);
      expect(textColor(tester), text);
      expect(borderColor(tester), border);
      final gesture = await press(tester);
      expect(decoration(tester).color, pressedFill);
      expect(textColor(tester), pressedText);
      await gesture.up();
      await tester.pump();
      expect(decoration(tester).color, fill);
      expect(textColor(tester), text);
    });

    testWidgets('without a borderColor, backgroundColor stays the border (PIN toggle style)', (tester) async {
      await tester.pumpWidget(_app(CoconutButton(
        text: 'Retry',
        buttonType: CoconutButtonType.outlined,
        backgroundColor: CoconutColors.gray350,
        pressedBackgroundColor: CoconutColors.gray800,
        textStyle: CoconutTypography.body2_14.setColor(CoconutColors.black),
        onPressed: () {},
      )));
      expect(decoration(tester).color, CoconutColors.white);
      expect(borderColor(tester), CoconutColors.gray350);
      expect(textColor(tester), CoconutColors.black);
      final gesture = await press(tester);
      expect(decoration(tester).color, CoconutColors.gray150);
      expect(textColor(tester), CoconutColors.gray500);
      await gesture.up();
      await tester.pump();
    });

    for (final type in [CoconutButtonType.outlined, CoconutButtonType.none]) {
      testWidgets('${type.name}: foregroundColor wins over the text style color', (tester) async {
        await tester.pumpWidget(_app(CoconutButton(
          text: 'Retry',
          buttonType: type,
          foregroundColor: text,
          textStyle: CoconutTypography.body2_14.setColor(Colors.red),
          onPressed: () {},
        )));
        expect(textColor(tester), text);
      });
    }

    for (final brightness in Brightness.values) {
      testWidgets('keeps the ${brightness.name} defaults when no role colors are provided', (tester) async {
        CoconutTheme.setTheme(brightness);
        final light = brightness == Brightness.light;
        await tester.pumpWidget(_app(CoconutButton(
          text: 'Retry',
          buttonType: CoconutButtonType.outlined,
          onPressed: () {},
        )));
        expect(decoration(tester).color, light ? CoconutColors.white : CoconutColors.black);
        expect(textColor(tester), CoconutColors.onPrimary(brightness));
        expect(borderColor(tester), light ? CoconutColors.black : CoconutColors.white);
        final gesture = await press(tester);
        expect(decoration(tester).color, light ? CoconutColors.gray150 : CoconutColors.gray800);
        expect(textColor(tester), light ? CoconutColors.gray500 : CoconutColors.gray200);
        expect(borderColor(tester), light ? CoconutColors.gray500 : CoconutColors.gray200);
        await gesture.up();
        await tester.pump();
      });
    }
  });

  group('app bar status bar style', () {
    for (final brightness in Brightness.values) {
      testWidgets('all three builders set a complete ${brightness.name} status bar style', (tester) async {
        CoconutTheme.setTheme(brightness);
        final styles = <SystemUiOverlayStyle?>[];
        await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
          final plain = CoconutAppBar.build(context: context, title: 'Plain');
          final next = CoconutAppBar.buildWithNext(context: context, title: 'Next', onNextPressed: () {});
          final home = CoconutAppBar.buildHomeAppbar(
              context: context, leadingSvgAsset: const SizedBox(), appTitle: 'Home', actionButtonList: const []);
          styles
            ..clear()
            ..addAll([plain.systemOverlayStyle, next.systemOverlayStyle, home.systemOverlayStyle]);
          return Scaffold(appBar: plain, body: CustomScrollView(slivers: [home]));
        })));
        final iconBrightness = brightness == Brightness.light ? Brightness.dark : Brightness.light;
        expect(styles, hasLength(3));
        for (final style in styles) {
          expect(style!.statusBarBrightness, brightness);
          expect(style.statusBarIconBrightness, iconBrightness);
          expect(style.statusBarColor, Colors.transparent);
          expect(style.systemNavigationBarColor, isNull);
          expect(style.systemNavigationBarIconBrightness, isNull);
        }
        final layers = tester.layers.whereType<AnnotatedRegionLayer<SystemUiOverlayStyle>>();
        expect(layers, hasLength(2));
        for (final layer in layers) {
          expect(layer.value.statusBarBrightness, brightness);
          expect(layer.value.statusBarIconBrightness, iconBrightness);
        }
      });
    }
  });
}
