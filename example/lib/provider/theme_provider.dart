import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// [ThemeProvider] is a ChangeNotifier that manages the application's theme mode (light/dark).
///
/// This class allows real-time theme switching using `Provider`.
///
/// Example:
/// ```dart
/// ChangeNotifierProvider(
///   create: (context) => ThemeProvider(),
///   child: MyApp(),
/// )
/// ```
class ThemeProvider with ChangeNotifier {
  /// The current theme mode of the app (default: `ThemeMode.system`).
  ThemeMode _themeMode =
      CoconutTheme.brightness() == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

  /// Returns the current theme mode.
  ///
  /// Possible values: `ThemeMode.light` or `ThemeMode.dark`.
  ThemeMode get themeMode => _themeMode;

  /// Returns whether the current theme is dark mode.
  ///
  /// Example:
  /// ```dart
  /// if (themeProvider.isDarkMode) {
  ///   print("Dark mode is enabled.");
  /// }
  /// ```
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Toggles the theme between light and dark mode.
  ///
  /// - If the current theme is `ThemeMode.light`, it switches to `ThemeMode.dark`.
  /// - If the current theme is `ThemeMode.dark`, it switches to `ThemeMode.light`.
  /// - Calls `notifyListeners()` to update the UI.
  ///
  /// Example:
  /// ```dart
  /// themeProvider.toggleTheme();
  /// ```
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    CoconutTheme.setTheme(_themeMode == ThemeMode.light
        ? Brightness.light
        : Brightness.dark); // Set the theme globally
    notifyListeners(); // Notify UI updates
  }
}
