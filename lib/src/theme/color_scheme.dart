import 'package:flutter/material.dart';

@immutable
class CoconutColorScheme {
  const CoconutColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.black,
    required this.white,
    required this.gray100,
    required this.gray150,
    required this.gray200,
    required this.gray300,
    required this.gray350,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
    required this.hotPink,
    required this.hotPink150,
    required this.cyan,
    required this.purple,
    required this.tangerine,
    required this.yellow,
    required this.green,
    required this.sky,
    required this.pink,
    required this.red,
    required this.orange,
    required this.mint,
    required this.colorPalette,
    required this.backgroundColorPalette,
  });

  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color black;
  final Color white;
  final Color gray100;
  final Color gray150;
  final Color gray200;
  final Color gray300;
  final Color gray350;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;
  final Color hotPink;
  final Color hotPink150;
  final Color cyan;
  final Color purple;
  final Color tangerine;
  final Color yellow;
  final Color green;
  final Color sky;
  final Color pink;
  final Color red;
  final Color orange;
  final Color mint;
  final List<Color> colorPalette;
  final List<Color> backgroundColorPalette;

  /// 🎨 **Light mode color palette**
  static const List<Color> colorPaletteLight = [
    Color(0xFFA364D9), // Purple
    Color(0xFFFA9C5A), // Apricot
    Color(0xFFFECC2F), // Yellow
    Color(0xFF88C125), // Green
    Color(0xFF41A4D8), // Blue
    Color(0xFFEE6579), // Pink
    Color(0xFFDB3937), // Red
    Color(0xFFF56321), // Orange
    Color(0xFF787878), // Light Grey
    Color(0xFF33BFB8), // Mint
  ];

  /// 🎨 **Light mode background color palette (with opacity)**
  static const List<Color> backgroundColorPaletteLight = [
    Color(0x21A364D9), // Purple (opacity 0.13)
    Color(0x21FA9C5A), // Apricot (opacity 0.13)
    Color(0x21FECC2F), // Yellow (opacity 0.13)
    Color(0x21B2C125), // Green (opacity 0.13)
    Color(0x1A41A4D8), // Blue (opacity 0.1)
    Color(0x1EEE6579), // Pink (opacity 0.12)
    Color(0x21DB3937), // Red (opacity 0.13)
    Color(0x21F56321), // Orange (opacity 0.13)
    Color(0x1A656565), // Light Grey (opacity 0.1)
    Color(0x1A33BFB8), // Mint (opacity 0.1)
  ];

  /// 🌙 **Dark mode color palette**
  static const List<Color> colorPaletteDark = [
    Color(0xFFA364D9), // Purple
    Color(0xFFFA9C5A), // Apricot
    Color(0xFFFECC2F), // Yellow
    Color(0xFF88C125), // Green
    Color(0xFF41A4D8), // Blue
    Color(0xFFEE6579), // Pink
    Color(0xFFDB3937), // Red
    Color(0xFFF56321), // Orange
    Color(0xFF9A9A9A), // Light Grey
    Color(0xFF33BFB8), // Mint
  ];

  /// 🌙 **Dark mode background color palette (with opacity)**
  static const List<Color> backgroundColorPaletteDark = [
    Color(0x2DA77AFE), // Purple (opacity 0.18)
    Color(0x2DF29392), // Apricot (opacity 0.18)
    Color(0x2DF6D776), // Yellow (opacity 0.18)
    Color(0x2D92C79A), // Green (opacity 0.18)
    Color(0x2D91B3F2), // Blue (opacity 0.18)
    Color(0x2DEB8CD7), // Pink (opacity 0.18)
    Color(0x2DCE5B6F), // Red (opacity 0.18)
    Color(0x2DE5A467), // Orange (opacity 0.18)
    Color(0x2DE6E6E6), // Light Grey (opacity 0.18)
    Color(0x2D9EE2E6), // Mint (opacity 0.18)
  ];

  /// 🌞 **Light Mode Theme**
  static const CoconutColorScheme light = CoconutColorScheme(
    primary: Color(0xFFDEFF58),
    onPrimary: Color(0xFF141318),
    surface: Color(0xFFFFFFFF),
    black: Color(0xFF141318),
    white: Color(0xFFFFFFFF),
    gray100: Color(0xFFFCFCFC),
    gray150: Color(0xFFF5F5F5),
    gray200: Color(0xFFEEEEEE),
    gray300: Color(0xFFDFDFDF),
    gray350: Color(0xFFC8C8C8),
    gray400: Color(0xFFB7B7B7),
    gray500: Color(0xFF949494),
    gray600: Color(0xFF777777),
    gray700: Color(0xFF555555),
    gray800: Color(0xFF303030),
    gray900: Color(0xFF1C1C1C),
    hotPink: Color(0xFFDA415C),
    hotPink150: Color(0x26DA415C),
    cyan: Color(0xFF45CCEE),
    purple: Color(0xFFA364D9),
    tangerine: Color(0xFFFA9C5A),
    yellow: Color(0xFFFECC2F),
    green: Color(0xFF88C125),
    sky: Color(0xFF41A4D8),
    pink: Color(0xFF88C125),
    red: Color(0xFFDB3937),
    orange: Color(0xFFF56321),
    mint: Color(0xFF33BFB8),
    colorPalette: colorPaletteLight,
    backgroundColorPalette: backgroundColorPaletteLight,
  );

  /// 🌙 **Dark Mode Theme**
  static const CoconutColorScheme dark = CoconutColorScheme(
    primary: Color(0xFFDEFF58),
    onPrimary: Color(0xFFFFFFFF),
    surface: Color(0xFF141318),
    black: Color(0xFF141318),
    white: Color(0xFFFFFFFF),
    gray100: Color(0xFFFCFCFC),
    gray150: Color(0xFFF5F5F5),
    gray200: Color(0xFFEEEEEE),
    gray300: Color(0xFFDFDFDF),
    gray350: Color(0xFFC8C8C8),
    gray400: Color(0xFFB7B7B7),
    gray500: Color(0xFF949494),
    gray600: Color(0xFF777777),
    gray700: Color(0xFF555555),
    gray800: Color(0xFF303030),
    gray900: Color(0xFF1C1C1C),
    hotPink: Color(0xFFDA415C),
    hotPink150: Color(0x26DA415C),
    cyan: Color(0xFF45CCEE),
    purple: Color(0xFFA364D9),
    tangerine: Color(0xFFFA9C5A),
    yellow: Color(0xFFFECC2F),
    green: Color(0xFF88C125),
    sky: Color(0xFF41A4D8),
    pink: Color(0xFF88C125),
    red: Color(0xFFDB3937),
    orange: Color(0xFFF56321),
    mint: Color(0xFF33BFB8),
    colorPalette: colorPaletteDark,
    backgroundColorPalette: backgroundColorPaletteDark,
  );
}
