import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';

/// A customizable switch widget based on `CupertinoSwitch`.
///
/// `CoconutSwitch` allows users to toggle between two states (`on` and `off`).
/// It supports theming based on brightness (light/dark mode) and provides options
/// for customizing the track and thumb colors.
class CoconutSwitch extends StatelessWidget {
  /// Default size of CupertinoSwitch
  static const double cupertinoSwitchWidth = 51.0;
  static const double cupertinoSwitchHeight = 31.0;

  /// Indicates whether the switch is in the "on" state.
  final bool isOn;

  /// Callback function triggered when the switch state changes.
  ///
  /// The function receives the new `isOn` state as an argument.
  final Function(bool) onChanged;

  /// The color of the switch's active track (when the switch is turned on).
  ///
  /// If `null`, it defaults to `CoconutColors.onBlack(brightness)`.
  final Color? activeTrackColor;

  /// The color of the switch's thumb when active.
  ///
  /// If `null`, it defaults to `CoconutColors.onWhite(brightness)` when active
  /// and `CoconutColors.onGray200(brightness)` when inactive.
  final Color? activeThumbColor;

  /// The color of the switch's track when inactive.
  ///
  /// If `null`, it defaults to `CoconutColors.onGray300(brightness)`.
  final Color? inactiveTrackColor;

  /// The color of the switch's thumb when inactive.
  ///
  /// If `null`, it defaults to `CoconutColors.onGray200(brightness)`.
  final Color? inactiveThumbColor;

  /// The color of the switch's active track (when the switch is turned on).
  ///
  /// If `null`, [activeTrackColor] is used.
  @Deprecated('Use activeTrackColor instead.')
  final Color? activeColor;

  /// The color of the switch's track when inactive.
  ///
  /// If `null`, [inactiveTrackColor] is used.
  @Deprecated('Use inactiveTrackColor instead.')
  final Color? trackColor;

  /// The color of the switch's thumb (circular handle).
  ///
  /// If `null`, [activeThumbColor] is used.
  @Deprecated('Use activeThumbColor instead.')
  final Color? thumbColor;

  /// Scales the entire switch widget.
  ///
  /// A value less than 1 shrinks the switch, and greater than 1 enlarges it.
  /// Defaults to 1 (no scaling).
  final double scale;

  /// Creates a `CoconutSwitch` widget.
  ///
  /// - [isOn] determines whether the switch is turned on or off.
  /// - [onChanged] is triggered when the switch state changes.
  /// - [activeTrackColor] customizes the active track color.
  /// - [activeThumbColor] customizes the active thumb color.
  /// - [inactiveTrackColor] customizes the inactive track color.
  /// - [inactiveThumbColor] customizes the inactive thumb color.
  /// - [scale] adjusts the size of the switch.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutSwitch(
  ///   isOn: true,
  ///   onChanged: (bool value) {
  ///     print("Switch state: $value");
  ///   },
  ///   activeTrackColor: Colors.green,
  ///   activeThumbColor: Colors.white,
  ///   inactiveTrackColor: Colors.grey,
  ///   inactiveThumbColor: Colors.white70,
  ///   scale: 0.8,
  /// )
  /// ```
  const CoconutSwitch({
    super.key,
    required this.isOn,
    required this.onChanged,
    this.activeTrackColor,
    this.activeThumbColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    @Deprecated('Use activeTrackColor instead.') this.activeColor,
    @Deprecated('Use inactiveTrackColor instead.') this.trackColor,
    @Deprecated('Use activeThumbColor instead.') this.thumbColor,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = CoconutTheme.brightness();

    // ignore: deprecated_member_use_from_same_package
    final resolvedActiveTrackColor = activeTrackColor ?? activeColor;
    // ignore: deprecated_member_use_from_same_package
    final resolvedInactiveTrackColor = inactiveTrackColor ?? trackColor;
    // ignore: deprecated_member_use_from_same_package
    final resolvedActiveThumbColor = activeThumbColor ?? thumbColor;

    final activeTrack =
        resolvedActiveTrackColor ?? (isOn ? CoconutColors.onBlack(brightness) : CoconutColors.onGray300(brightness));
    final activeThumb =
        resolvedActiveThumbColor ?? (isOn ? CoconutColors.onWhite(brightness) : CoconutColors.onGray200(brightness));

    final inactiveThumb = inactiveThumbColor ?? CoconutColors.onGray200(brightness);
    final inactiveTrack = resolvedInactiveTrackColor ?? CoconutColors.onGray300(brightness);

    return SizedBox(
      width: cupertinoSwitchWidth * scale,
      height: cupertinoSwitchHeight * scale,
      child: Transform.scale(
        scale: scale,
        child: CupertinoSwitch(
          value: isOn,
          activeTrackColor: activeTrack,
          inactiveTrackColor: inactiveTrack,
          thumbColor: activeThumb,
          inactiveThumbColor: inactiveThumb,
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
