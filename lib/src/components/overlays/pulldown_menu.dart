import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable dropdown menu with selectable items and dividers.
///
/// The `CoconutPulldownMenu` provides a structured dropdown menu:
/// - Displays a **list of buttons** with optional selection states.
/// - Supports **custom dividers** between specific items.
/// - Allows **custom styling** for background, text, and icons.
///
/// Example Usage:
/// ```dart
/// CoconutPulldownMenu(
///   brightness: Brightness.light,
///   buttons: ["Option 1", "Option 2", "Option 3"],
///   selectedIndex: 1,
///   onTap: (index) {
///     print("Selected: $index");
///   },
///   buttonHeight: 50, // Custom button height
///   buttonPadding: EdgeInsets.symmetric(horizontal: 20), // Custom padding
///   dividerHeight: 2,
/// );
/// ```
class CoconutPulldownMenu extends StatelessWidget {
  /// The list of button labels displayed in the dropdown.
  final List<String> buttons;

  /// The index of the currently selected item (optional).
  final int? selectedIndex;

  /// Callback function when an item is tapped.
  final Function(int) onTap;

  /// The margin around the dropdown menu (default: `EdgeInsets.zero`).
  final EdgeInsets margin;

  /// The padding inside each button (default: `EdgeInsets.symmetric(horizontal: 16)`).
  final EdgeInsets? buttonPadding;

  /// The height of each dropdown button (default: `44.0`).
  final double buttonHeight;

  /// The size of the checkmark icon for selected items (default: `24`).
  final double iconSize;

  /// The blur radius of the dropdown menu's shadow effect. (default: `12`)
  final double blurRadius;

  /// The border radius of the dropdown menu. (default: `8`)
  final double borderRadius;

  /// The spread radius of the dropdown menu's shadow effect. (default: `4`)
  final double spreadRadius;

  /// The height of divider between buttons. (default: `1`)
  final double? dividerHeight;

  /// The text color of menu items.
  final Color? textColor;

  /// The background color of the menu.
  final Color? backgroundColor;

  /// The color of normal dividers between items.
  final Color? dividerColor;

  /// The color of the checkmark icon for selected items.
  final Color? iconColor;

  /// The color of the splash effect when an item is tapped.
  final Color? splashColor;

  /// The color of the shadow effect under the dropdown.
  final Color? shadowColor;

  /// Creates an instance of `CoconutPulldownMenu`.
  const CoconutPulldownMenu({
    super.key,
    required this.buttons,
    required this.onTap,
    this.selectedIndex,
    this.margin = EdgeInsets.zero,
    this.buttonPadding,
    this.buttonHeight = 44,
    this.blurRadius = 16,
    this.spreadRadius = 1,
    this.borderRadius = 16,
    this.iconSize = 24,
    this.dividerHeight = 1,
    this.textColor,
    this.backgroundColor,
    this.dividerColor,
    this.iconColor,
    this.splashColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        margin: margin,
        constraints:
            const BoxConstraints(minWidth: 152), // Minimum width for dropdown
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.black.withOpacity(0.5),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(buttons.length, (index) {
              return _button(buttons[index], index, borderRadius, brightness);
            }),
          ),
        ),
      ),
    );
  }

  /// Builds a single dropdown button item.
  Widget _button(
    String title,
    int index,
    double borderRadius,
    Brightness brightness,
  ) {
    return Column(
      children: [
        Material(
          color: backgroundColor ?? CoconutColors.onGray100(brightness),
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(
                  index,
                  buttons.length,
                  borderRadius,
                  brightness,
                ) ??
                BorderRadius.zero,
          ),
          child: InkWell(
            onTap: () {
              onTap.call(index);
            },
            borderRadius: _getBorderRadius(
              index,
              buttons.length,
              borderRadius,
              brightness,
            ),
            splashColor: splashColor ?? CoconutColors.onGray200(brightness),
            highlightColor: Colors.transparent,
            child: Container(
              height: buttonHeight,
              padding:
                  buttonPadding ?? const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: _getBorderRadius(
                  index,
                  buttons.length,
                  borderRadius,
                  brightness,
                ),
              ),
              child: Row(
                children: [
                  /// Button Label
                  Text(
                    title,
                    style: CoconutTypography.body2_14.copyWith(
                      color: textColor ?? CoconutColors.onBlack(brightness),
                    ),
                  ),

                  /// Checkmark Icon for Selected Item
                  const Spacer(),
                  if (selectedIndex == index) ...{
                    SvgPicture.asset(
                      'packages/coconut_design_system/assets/svg/pulldown_check.svg',
                      width: iconSize,
                      height: iconSize,
                      colorFilter: ColorFilter.mode(
                        iconColor ?? CoconutColors.onBlack(brightness),
                        BlendMode.srcIn,
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        ),

        /// Adds a divider between items
        if (index < buttons.length - 1) ...{
          Container(
            height: dividerHeight,
            color: dividerColor ?? CoconutColors.onGray200(brightness),
          ),
        }
      ],
    );
  }

  /// Determines the border radius for the first and last items.
  BorderRadius? _getBorderRadius(
      int index, int length, double borderRadius, Brightness brightness) {
    if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      );
    } else if (index == length - 1) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      );
    }
    return null; // No border radius for middle items
  }
}
