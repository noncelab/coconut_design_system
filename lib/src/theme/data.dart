import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:coconut_design_system/src/theme/color_scheme.dart';
import 'package:flutter/material.dart';

/// **Coconut Design System Theme Data Class**
///
/// Defines the **light** and **dark** themes with a consistent color scheme and typography.
class CoconutThemeData {
  /// **Dark Theme Configuration**
  ///
  /// - Uses `Pretendard` as the default font.
  /// - Applies `CoconutColorScheme.dark` for a consistent dark mode UI.
  static ThemeData get darkTheme {
    CoconutColorScheme colorScheme = CoconutColorScheme.dark;

    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: CoconutTypography.kTextFontFamily,
      textTheme: CoconutTextTheme.darkTextTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      dividerColor: colorScheme.gray800,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: colorScheme.primary,
        secondary: colorScheme.cyan,
        surface: colorScheme.surface,
        error: colorScheme.red,
        onPrimary: colorScheme.onPrimary,
        onSurface: colorScheme.white,
        onError: colorScheme.black,
      ),
    );
  }

  /// **Light Theme Configuration**
  ///
  /// - Uses `Pretendard` as the default font.
  /// - Applies `CoconutColorScheme.light` for a consistent light mode UI.
  static ThemeData get lightTheme {
    CoconutColorScheme colorScheme = CoconutColorScheme.light;

    return ThemeData(
      brightness: Brightness.light,
      fontFamily: CoconutTypography.kTextFontFamily,
      textTheme: CoconutTextTheme.lightTextTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      dividerColor: colorScheme.gray300,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: colorScheme.primary,
        secondary: colorScheme.cyan,
        surface: colorScheme.surface,
        error: colorScheme.red,
        onPrimary: colorScheme.onPrimary,
        onSurface: colorScheme.black,
        onError: colorScheme.white,
      ),
    );
  }
}
