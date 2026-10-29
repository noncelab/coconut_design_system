import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:coconut_design_system/src/common/korean_line_break.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _wj = '⁠';

/// Lines of [text] laid out at [width], with word joiners removed for readability.
List<String> _lines(String text, double width) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: const TextStyle(fontSize: 10)),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: width);
  final lines = <String>[];
  var offset = 0;
  while (offset < text.length) {
    final range = painter.getLineBoundary(TextPosition(offset: offset));
    lines.add(text.substring(range.start, range.end).replaceAll(_wj, '').trim());
    offset = range.end > offset ? range.end : offset + 1;
    while (offset < text.length && text[offset] == ' ') {
      offset++;
    }
  }
  painter.dispose();
  return lines;
}

void main() {
  group('keepKoreanWords', () {
    test('joins characters inside Korean words only', () {
      expect(keepKoreanWords('키가 없어요'), '키$_wj가 없$_wj어$_wj요');
    });

    test('joins Hangul with adjacent digits and Latin letters', () {
      expect(keepKoreanWords('12자리 BTC로'), '12$_wj자$_wj리 BTC$_wj로');
    });

    test('leaves text without Hangul unchanged', () {
      const xpub =
          'xpub6CUGRUonZSQ4TWtTMmzXdrXDtypWKiKrhko4egpiMZbpiaQL2jkwSB1icqYh2cfDfVxdx4df189oLKnC5fSwqPfgyP3hooxujYzAu3fDVmz';
      expect(keepKoreanWords(xpub), xpub);
      expect(keepKoreanWords('マルチシグ'), 'マルチシグ');
    });

    test('does not join across spaces or punctuation', () {
      expect(keepKoreanWords('네, 아니오'), '네, 아$_wj니$_wj오');
    });
  });

  group('layout', () {
    test('without keep-all, Flutter splits a Korean word', () {
      // 5 glyphs fit per line; "만드시겠어요" (6) must wrap somewhere.
      final lines = _lines('지갑을 먼저 만드시겠어요', 55);
      expect(lines.any((line) => line.contains('만드') && !line.contains('만드시겠어요')), isTrue);
    });

    test('with keep-all, lines break at spaces', () {
      final lines = _lines(keepKoreanWords('지갑을 먼저 만들까요'), 55);
      expect(lines, ['지갑을', '먼저', '만들까요']);
    });

    test('a word longer than the line still wraps instead of overflowing', () {
      final lines = _lines(keepKoreanWords('가나다라마바사아자차'), 55);
      expect(lines.length, greaterThan(1));
      expect(lines.join(), '가나다라마바사아자차');
    });
  });

  testWidgets('CoconutPopup applies keep-all and exposes the original text to semantics', (tester) async {
    CoconutTheme.setTheme(Brightness.light);
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CoconutPopup(
            languageCode: 'kr',
            title: '볼트에 저장된 키가 없어요',
            description: '다중 서명 지갑 만들기를 종료할까요?',
            onTapRight: () {},
          ),
        ),
      ),
    );

    expect(find.text(keepKoreanWords('볼트에 저장된 키가 없어요')), findsOneWidget);
    expect(find.text(keepKoreanWords('다중 서명 지갑 만들기를 종료할까요?')), findsOneWidget);
    final label = tester.getSemantics(find.text(keepKoreanWords('볼트에 저장된 키가 없어요'))).label;
    expect(label, contains('볼트에 저장된 키가 없어요'));
    expect(label, isNot(contains(_wj)));
    semantics.dispose();
  });
}
