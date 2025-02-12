import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable button designed for use in the `CoconutAppBar`.
///
/// This button supports different states such as active, disabled, and closable app bars,
/// and allows customization of its primary color usage.
///
/// ### Example usage:
/// ```dart
/// CoconutAppbarButton(
///   isActive: true,
///   onPressed: () {
///     print("Button clicked!");
///   },
///   text: "Next",
///   brightness: Brightness.light,
/// )
/// ```
///
/// #### Parameters:
/// - `isActive` (bool): Determines whether the button is enabled or disabled.
/// - `onPressed` (VoidCallback?): Callback function triggered when the button is tapped.
/// - `text` (String): The text displayed on the button.
/// - `brightness` (Brightness): Determines the theme (light or dark) for color adjustments.
/// - `usePrimaryActiveColor` (bool, optional): Defines whether to use the primary color for the button when active. Default is `true`.
/// - `isUseInClosableAppbar` (bool, optional): Adjusts vertical padding when used inside a closable app bar. Default is `false`.
class CoconutAppbarButton extends StatelessWidget {
  /// Determines whether the button is enabled or disabled.
  final bool isActive;

  /// Determines whether the primary color should be used when active.
  final bool usePrimaryActiveColor;

  /// Adjusts vertical padding when used inside a closable app bar.
  final bool isUseInClosableAppbar;

  /// Callback function triggered when the button is tapped.
  final VoidCallback? onPressed;

  /// The text displayed on the button.
  final String text;

  /// Determines the theme (light or dark) for color adjustments.
  final Brightness brightness;

  /// Creates a `CoconutAppbarButton` with customizable properties.
  const CoconutAppbarButton({
    super.key,
    required this.isActive,
    required this.onPressed,
    required this.text,
    required this.brightness,
    this.usePrimaryActiveColor = true,
    this.isUseInClosableAppbar = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: (isUseInClosableAppbar ? 7.0 : 4.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : CoconutColors.onPrimary(brightness).withOpacity(0.2),
            ),
            color: isActive
                ? usePrimaryActiveColor
                    ? CoconutColors.primary
                    : CoconutColors.onPrimary(brightness)
                : CoconutColors.disabledButtonColor(brightness),
          ),
          child: Center(
            child: Text(
              text,
              style: CoconutTypography.body2_14_Bold.copyWith(
                color: isActive
                    ? usePrimaryActiveColor
                        ? CoconutColors.black
                        : CoconutColors.surface(brightness)
                    : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
