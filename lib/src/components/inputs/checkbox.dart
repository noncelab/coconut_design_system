import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable checkbox widget using SVG assets.
///
/// This checkbox allows users to toggle a selection state.
/// It supports theming based on brightness (light/dark mode) and allows
/// customization of size and color.
class CoconutCheckbox extends StatelessWidget {
  /// Indicates whether the checkbox is selected.
  final bool isSelected;

  /// Callback function that is triggered when the checkbox state changes.
  final Function(bool) onChanged;

  /// The width and height of the checkbox (since it is a square).
  /// Defaults to `20.0` pixels.
  final double width;

  /// The color of the checkbox.
  /// If not provided, it defaults to the appropriate color based on the brightness mode.
  final Color? color;

  /// The color of the checkbox when it is disabled.
  final Color? disabledColor;

  /// Creates a `CoconutCheckbox` widget.
  ///
  /// - [isSelected] determines whether the checkbox is checked or not.
  /// - [onChanged] is triggered when the checkbox is tapped.
  /// - [width] sets the checkbox size (default: `20.0`).
  /// - [color] allows customization of the checkbox color.
  /// - [disabledColor] allows customization of the checkbox color when it is disabled.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutCheckbox(
  ///   isSelected: true,
  ///   onChanged: (bool value) {
  ///     print("Checkbox state: $value");
  ///   },
  /// )
  /// ```
  const CoconutCheckbox({
    super.key,
    required this.isSelected,
    required this.onChanged,
    this.width = 20.0,
    this.color,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = CoconutTheme.brightness();
    return GestureDetector(
      onTap: () {
        onChanged(!isSelected);
      },
      child: SvgPicture.asset(
        'packages/coconut_design_system/assets/svg/checkbox${isSelected ? '_selected' : ''}.svg',
        width: width,
        height: width,
        colorFilter: ColorFilter.mode(
          _getColor(brightness),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Color _getColor(Brightness brightness) {
    if (!isSelected) {
      return disabledColor ?? CoconutColors.onGray200(brightness);
    }
    return color ?? CoconutColors.onBlack(brightness);
  }
}
