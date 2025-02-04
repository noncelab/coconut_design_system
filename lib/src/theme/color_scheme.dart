import 'package:coconut_design_system/src/common/colors.dart';
import 'package:flutter/material.dart';

@immutable
class CoconutColorScheme {
  /// **Light Mode Theme**
  static CoconutColorScheme light = CoconutColorScheme(
    primary: CoconutColors.primary,
    onPrimary: CoconutColors.onPrimary(Brightness.light),
    surface: CoconutColors.surface(Brightness.light),
    black: CoconutColors.black,
    white: CoconutColors.white,
    gray100: CoconutColors.gray100,
    gray150: CoconutColors.gray150,
    gray200: CoconutColors.gray200,
    gray300: CoconutColors.gray300,
    gray350: CoconutColors.gray350,
    gray400: CoconutColors.gray400,
    gray500: CoconutColors.gray500,
    gray600: CoconutColors.gray600,
    gray700: CoconutColors.gray700,
    gray800: CoconutColors.gray800,
    gray900: CoconutColors.gray900,
    hotPink: CoconutColors.hotPink,
    hotPink150: CoconutColors.hotPink150,
    cyan: CoconutColors.cyan,
    purple: CoconutColors.purple,
    tangerine: CoconutColors.tangerine,
    yellow: CoconutColors.yellow,
    green: CoconutColors.green,
    sky: CoconutColors.sky,
    pink: CoconutColors.pink,
    red: CoconutColors.red,
    orange: CoconutColors.orange,
    mint: CoconutColors.mint,
    colorPalette: CoconutColors.colorPaletteLight,
    backgroundColorPalette: CoconutColors.backgroundColorPaletteLight,
  );

  /// **Dark Mode Theme**
  static CoconutColorScheme dark = CoconutColorScheme(
    primary: CoconutColors.primary,
    onPrimary: CoconutColors.onPrimary(Brightness.dark),
    surface: CoconutColors.surface(Brightness.dark),
    black: CoconutColors.black,
    white: CoconutColors.white,
    gray100: CoconutColors.gray100,
    gray150: CoconutColors.gray150,
    gray200: CoconutColors.gray200,
    gray300: CoconutColors.gray300,
    gray350: CoconutColors.gray350,
    gray400: CoconutColors.gray400,
    gray500: CoconutColors.gray500,
    gray600: CoconutColors.gray600,
    gray700: CoconutColors.gray700,
    gray800: CoconutColors.gray800,
    gray900: CoconutColors.gray900,
    hotPink: CoconutColors.hotPink,
    hotPink150: CoconutColors.hotPink150,
    cyan: CoconutColors.cyan,
    purple: CoconutColors.purple,
    tangerine: CoconutColors.tangerine,
    yellow: CoconutColors.yellow,
    green: CoconutColors.green,
    sky: CoconutColors.sky,
    pink: CoconutColors.pink,
    red: CoconutColors.red,
    orange: CoconutColors.orange,
    mint: CoconutColors.mint,
    colorPalette: CoconutColors.colorPaletteDark,
    backgroundColorPalette: CoconutColors.backgroundColorPaletteDark,
  );
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
}
