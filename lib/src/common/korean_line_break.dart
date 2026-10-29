import 'package:flutter/painting.dart';

const String _wordJoiner = '⁠';

/// Prevents line breaks inside Korean words, like CSS `word-break: keep-all`.
///
/// Flutter allows a line break between any two Hangul syllables, so a Korean word can be split across lines.
/// This inserts a word joiner (U+2060) between adjacent word characters when at least one of them is Hangul,
/// so lines break at spaces instead. Text without Hangul is returned unchanged, and a word that is longer than
/// the line is still wrapped by the text layout.
String keepKoreanWords(String text) {
  if (text.isEmpty) return text;

  final buffer = StringBuffer();
  int? previous;
  for (final rune in text.runes) {
    if (previous != null &&
        (_isHangul(previous) || _isHangul(rune)) &&
        _isWordCharacter(previous) &&
        _isWordCharacter(rune)) {
      buffer.write(_wordJoiner);
    }
    buffer.writeCharCode(rune);
    previous = rune;
  }
  return buffer.toString();
}

/// Applies [keepKoreanWords] to every text in [span] and its children.
InlineSpan keepKoreanWordsInSpan(InlineSpan span) {
  if (span is! TextSpan) return span;

  return TextSpan(
    text: span.text == null ? null : keepKoreanWords(span.text!),
    children: span.children?.map(keepKoreanWordsInSpan).toList(),
    style: span.style,
    recognizer: span.recognizer,
    mouseCursor: span.mouseCursor,
    onEnter: span.onEnter,
    onExit: span.onExit,
    semanticsLabel: span.semanticsLabel ?? span.text,
    locale: span.locale,
    spellOut: span.spellOut,
  );
}

bool _isHangul(int rune) =>
    (rune >= 0xAC00 && rune <= 0xD7A3) || // syllables
    (rune >= 0x1100 && rune <= 0x11FF) || // jamo
    (rune >= 0x3130 && rune <= 0x318F); // compatibility jamo

bool _isWordCharacter(int rune) =>
    _isHangul(rune) ||
    (rune >= 0x30 && rune <= 0x39) || // 0-9
    (rune >= 0x41 && rune <= 0x5A) || // A-Z
    (rune >= 0x61 && rune <= 0x7A); // a-z
