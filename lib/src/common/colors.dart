import 'package:flutter/material.dart';

/// **Coconut Design System - Global Color Helper**
///
/// Provides easy access to theme-aware colors.
class CoconutColors {
  static const Color primary = Color(0xFFDEFF58);
  static const Color black = Color(0xFF141318);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFFCFCFC);
  static const Color gray150 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFDFDFDF);
  static const Color gray350 = Color(0xFFC8C8C8);
  static const Color gray400 = Color(0xFFB7B7B7);
  static const Color gray500 = Color(0xFF949494);
  static const Color gray600 = Color(0xFF777777);
  static const Color gray700 = Color(0xFF555555);
  static const Color gray800 = Color(0xFF303030);
  static const Color gray900 = Color(0xFF1C1C1C);
  static const Color hotPink = Color(0xFFDA415C);
  static const Color hotPink150 = Color(0x26DA415C);
  static const Color cyan = Color(0xFF45CCEE);
  static const Color purple = Color(0xFFA364D9);
  static const Color tangerine = Color(0xFFFA9C5A);
  static const Color yellow = Color(0xFFFECC2F);
  static const Color green = Color(0xFF88C125);
  static const Color sky = Color(0xFF41A4D8);
  static const Color pink = Color(0xFF88C125);
  static const Color red = Color(0xFFDB3937);
  static const Color orange = Color(0xFFF56321);
  static const Color mint = Color(0xFF33BFB8);

  /// **Light mode color palette**
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

  /// **Light mode background color palette (with opacity)**
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

  /// **Dark mode color palette**
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

  /// **Dark mode background color palette (with opacity)**
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

  static Color onPrimary(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF141318);

  static Color surface(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFF141318)
      : const Color(0xFFFFFFFF);
}
