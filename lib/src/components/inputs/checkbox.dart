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

  /// The color of the checkbox when selected.
  /// If not provided, it defaults to the appropriate color based on the brightness mode.
  final Color? color;

  /// The color of the checkbox when it is unselected.
  final Color? unSelectedColor;

  @Deprecated('Use unSelectedColor instead. This property will be removed in a future version.')
  final Color? disabledColor;

  /// The color of the checkbox when it is disabled.
  final Color? inactiveColor;

  /// Whether the checkbox is interactive.
  /// Defaults to `false`.
  final bool isDisabled;

  /// Creates a `CoconutCheckbox` widget.
  const CoconutCheckbox({
    super.key,
    required this.isSelected,
    required this.onChanged,
    this.width = 20.0,
    this.color,
    this.unSelectedColor,
    this.inactiveColor,
    this.disabledColor,
    this.isDisabled = false,
  }) : assert(unSelectedColor == null || disabledColor == null,
            'Cannot provide both unSelectedColor and disabledColor. Use unSelectedColor.');

  @override
  Widget build(BuildContext context) {
    final brightness = CoconutTheme.brightness();
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
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
    if (isDisabled) {
      return inactiveColor ?? CoconutColors.onGray200(brightness);
    }
    if (!isSelected) {
      return unSelectedColor ?? disabledColor ?? CoconutColors.onGray200(brightness);
    }
    return color ?? CoconutColors.onBlack(brightness);
  }
}
