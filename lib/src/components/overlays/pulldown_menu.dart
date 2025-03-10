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
///   dividerIndex: 2, // Adds a thicker divider after the second item
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

  /// The size of the checkmark icon for selected items (default: `24`).
  final double iconSize;

  /// The blur radius of the dropdown menu's shadow effect. (default: `12`)
  final double blurRadius;

  /// The spread radius of the dropdown menu's shadow effect. (default: `4`)
  final double spreadRadius;

  /// The index where a thicker divider should be placed (optional).
  final int? dividerIndex;

  /// The text color of menu items.
  final Color? textColor;

  /// The background color of the menu.
  final Color? backgroundColor;

  /// The color of normal dividers between items.
  final Color? dividerColor;

  /// The color of the thick divider (used for `dividerIndex`).
  final Color? dividerPointColor;

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
    this.blurRadius = 12,
    this.spreadRadius = 4,
    this.iconSize = 24,
    this.dividerIndex,
    this.textColor,
    this.backgroundColor,
    this.dividerColor,
    this.dividerPointColor,
    this.iconColor,
    this.splashColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      margin: margin,
      constraints:
          const BoxConstraints(minWidth: 124), // Minimum width for dropdown
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? CoconutColors.onGray300(brightness),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: Offset.zero,
          ),
        ],
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(buttons.length, (index) {
            return _button(buttons[index], index, brightness);
          }),
        ),
      ),
    );
  }

  /// Builds a single dropdown button item.
  Widget _button(String title, int index, Brightness brightness) {
    return Column(
      children: [
        Material(
          color: backgroundColor ?? CoconutColors.onGray100(brightness),
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(index, buttons.length, brightness) ??
                BorderRadius.zero,
          ),
          child: InkWell(
            onTap: () {
              onTap.call(index);
            },
            borderRadius: _getBorderRadius(index, buttons.length, brightness),
            splashColor: splashColor ?? CoconutColors.onGray200(brightness),
            highlightColor: Colors.transparent,
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
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
            height: index + 1 == dividerIndex ? 3 : 2,
            color: index + 1 == dividerIndex
                ? dividerPointColor ?? CoconutColors.onGray350(brightness)
                : dividerColor ?? CoconutColors.onGray200(brightness),
          ),
        }
      ],
    );
  }

  /// Determines the border radius for the first and last items.
  BorderRadius? _getBorderRadius(int index, int length, Brightness brightness) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    } else if (index == length - 1) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return null; // No border radius for middle items
  }
}
