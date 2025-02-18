import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable pulldown widget with a title and an icon indicating open/close state.
///
/// This widget is commonly used for dropdown-like behavior, where the state toggles between
/// expanded and collapsed views.
///
/// The pulldown supports theming based on brightness (light/dark mode) and allows customization
/// of the title color, icon size, and interaction callback.
class CoconutPulldown extends StatelessWidget {
  /// The title text displayed next to the pulldown icon.
  final String title;

  /// Indicates whether the pulldown is open or closed.
  final bool isOpen;

  /// Callback function triggered when the pulldown is tapped.
  ///
  /// The function receives the new `isOpen` state.
  final Function(bool) onChanged;

  /// The size of the pulldown icon.
  ///
  /// Defaults to `24.0` pixels.
  final double iconSize;

  /// The color of the pulldown icon.
  ///
  /// If `null`, it defaults to the appropriate color based on the brightness mode.
  final Color? iconColor;

  /// The color of the title text.
  ///
  /// If `null`, it defaults to the appropriate color based on the brightness mode.
  final Color? textColor;

  /// The font size of the title text.
  ///
  /// If `null`, it uses the default text style.
  final double? fontSize;

  /// Creates a `CoconutPulldown` widget.
  ///
  /// - [title] sets the text displayed in the pulldown.
  /// - [brightness] is used to adjust colors for light or dark mode.
  /// - [isOpen] determines whether the pulldown is currently expanded or collapsed.
  /// - [onChanged] is called when the pulldown is tapped.
  /// - [iconSize] sets the icon's size (default: `24.0`).
  /// - [iconColor] allows customization of the pulldown icon color.
  /// - [fontColor] allows customization of the title text color.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutPulldown(
  ///   title: "Options",
  ///   brightness: Theme.of(context).brightness,
  ///   isOpen: false,
  ///   onChanged: (bool isOpen) {
  ///     print("Pulldown state: $isOpen");
  ///   },
  /// )
  /// ```
  const CoconutPulldown({
    super.key,
    required this.title,
    required this.isOpen,
    required this.onChanged,
    this.iconSize = 24,
    this.iconColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GestureDetector(
      onTap: () {
        onChanged(!isOpen);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title text
          Container(
            margin: const EdgeInsets.only(left: 8),
            alignment: Alignment.center,
            child: Text(
              title,
              style: CoconutTypography.caption_10.copyWith(
                fontSize: fontSize,
                color: textColor ?? CoconutColors.onBlack(brightness),
              ),
            ),
          ),

          /// Open/Close icon
          SvgPicture.asset(
            'packages/coconut_design_system/assets/svg/pulldown_${isOpen ? 'open' : 'close'}.svg',
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              iconColor ?? CoconutColors.onBlack(brightness),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
