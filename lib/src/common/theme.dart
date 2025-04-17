import 'dart:ui';

/// A utility class for managing theme brightness within the Coconut Design System.
///
/// This class provides a way to override the system's brightness globally across
/// the app without needing a BuildContext. If not explicitly set, it falls back
/// to the system brightness.
///
/// Use [setTheme] to force the app into a specific theme mode (light or dark).
/// This is useful if you want to lock your app's theme regardless of the system setting.
class CoconutTheme {
  static Brightness? _brightnessOverride;

  static void setTheme(Brightness brightness) {
    _brightnessOverride = brightness;
  }

  /// Returns the effective brightness used by Coconut Design System.
  ///
  /// If [setTheme] has been called with a specific [Brightness], that value will be returned.
  /// Otherwise, the method falls back to the system's current brightness.
  ///
  /// To apply a fixed theme throughout the app, call `CoconutTheme.setTheme(Brightness.light or dark)`
  /// in the main entry point of your app.
  static Brightness brightness() {
    return _brightnessOverride ?? PlatformDispatcher.instance.platformBrightness;
  }
}
