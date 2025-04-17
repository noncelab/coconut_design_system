import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';

/// A customizable switch widget based on `CupertinoSwitch`.
///
/// `CoconutSwitch` allows users to toggle between two states (`on` and `off`).
/// It supports theming based on brightness (light/dark mode) and provides options
/// for customizing the active track color and thumb color.
class CoconutSwitch extends StatelessWidget {
  /// Indicates whether the switch is in the "on" state.
  final bool isOn;

  /// Callback function triggered when the switch state changes.
  ///
  /// The function receives the new `isOn` state as an argument.
  final Function(bool) onChanged;

  /// The color of the switch's active track (when the switch is turned on).
  ///
  /// If `null`, it defaults to `CoconutColors.onBlack(brightness)`.
  final Color? activeColor;

  /// The color of the switch's thumb (circular handle).
  ///
  /// If `null`, it defaults to `CoconutColors.onWhite(brightness)` when active
  /// and `CoconutColors.onGray200(brightness)` when inactive.
  final Color? thumbColor;

  /// Creates a `CoconutSwitch` widget.
  ///
  /// - [isOn] determines whether the switch is turned on or off.
  /// - [onChanged] is triggered when the switch state changes.
  /// - [activeColor] customizes the active track color.
  /// - [thumbColor] customizes the switch thumb color.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutSwitch(
  ///   isOn: true,
  ///   onChanged: (bool value) {
  ///     print("Switch state: $value");
  ///   },
  /// )
  /// ```
  const CoconutSwitch({
    super.key,
    required this.isOn,
    required this.onChanged,
    this.activeColor,
    this.thumbColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = CoconutTheme.brightness();

    final active = activeColor == null
        ? isOn
            ? CoconutColors.onBlack(brightness)
            : CoconutColors.onGray300(brightness)
        : activeColor!;
    final thumb = thumbColor == null
        ? isOn
            ? CoconutColors.onWhite(brightness)
            : CoconutColors.onGray200(brightness)
        : thumbColor!;

    return CupertinoSwitch(
      value: isOn,
      activeColor: active,
      thumbColor: thumb,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
