import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable stepper widget that allows users to increase or decrease a numeric value.
///
/// The `CoconutStepper` consists of decrement (`-`) and increment (`+`) buttons, with a middle section
/// displaying the current count. The stepper allows defining a maximum limit, and its appearance
/// can be customized with different sizes, fonts, and colors.
class CoconutStepper extends StatefulWidget {
  /// The maximum count value that the stepper can reach.
  final int maxCount;

  /// The font size of the count displayed in the center.
  ///
  /// Defaults to `24.0`.
  final double fontSize;

  /// The size of the plus and minus icons.
  ///
  /// Defaults to `20.0`.
  final double iconSize;

  /// The size of the stepper buttons (circular area surrounding the icons).
  ///
  /// Defaults to `32.0`.
  final double buttonSize;

  /// The width of the count display area.
  ///
  /// Defaults to `80.0`.
  final double countWidth;

  /// Callback function triggered when the count value changes.
  ///
  /// The function receives the updated count as an argument.
  final Function(int) onCount;

  /// Creates a `CoconutStepper` widget.
  ///
  /// - [maxCount] defines the upper limit for the stepper value.
  /// - [brightness] is used to adjust colors for light or dark mode.
  /// - [onCount] is triggered whenever the count value changes.
  /// - [fontSize] customizes the text size of the displayed count.
  /// - [iconSize] defines the size of the stepper icons.
  /// - [buttonSize] sets the circular button size surrounding the icons.
  /// - [countWidth] adjusts the width of the center count display.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutStepper(
  ///   maxCount: 10,
  ///   brightness: Theme.of(context).brightness,
  ///   onCount: (int count) {
  ///     print("Current stepper count: $count");
  ///   },
  /// )
  /// ```
  const CoconutStepper({
    super.key,
    required this.maxCount,
    required this.onCount,
    this.fontSize = 24.0,
    this.iconSize = 20.0,
    this.buttonSize = 32.0,
    this.countWidth = 80.0,
  });

  @override
  State<CoconutStepper> createState() => _CoconutStepperState();
}

class _CoconutStepperState extends State<CoconutStepper> {
  /// Stores the current count value.
  int _currentCount = 1;

  /// Updates the count when the plus or minus button is pressed.
  ///
  /// - Ensures that the count remains within the valid range (`1` to `maxCount`).
  /// - Calls `onCount` callback with the updated value.
  void _updateCount(int change) {
    int newCount = _currentCount + change;
    if (newCount >= 1 && newCount <= widget.maxCount) {
      setState(() {
        _currentCount = newCount;
      });
      widget.onCount(_currentCount);
    }
  }

  /// Builds a stepper button (either `+` or `-`) with an icon.
  ///
  /// - [asset] is the icon asset name (`stepper_minus` or `stepper_plus`).
  /// - [isDisabled] determines whether the button is active.
  /// - [onTap] is the function triggered when the button is tapped.
  Widget _buildStepperButton(
      {required String asset,
      required bool isDisabled,
      required VoidCallback onTap,
      required Brightness brightness}) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: widget.buttonSize,
        height: widget.buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: CoconutColors.onGray300(brightness),
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'packages/coconut_design_system/assets/svg/$asset.svg',
            width: widget.iconSize,
            height: widget.iconSize,
            colorFilter: ColorFilter.mode(
              isDisabled
                  ? CoconutColors.onGray300(brightness)
                  : CoconutColors.onBlack(brightness),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStepperButton(
          asset: 'stepper_minus',
          isDisabled: _currentCount == 1,
          onTap: () => _updateCount(-1),
          brightness: brightness,
        ),
        Container(
          width: widget.countWidth,
          alignment: Alignment.center,
          child: Text(
            '$_currentCount',
            style: CoconutTypography.heading3_21_Number.copyWith(
              color: CoconutColors.onBlack(brightness),
              fontSize: widget.fontSize,
            ),
          ),
        ),
        _buildStepperButton(
          asset: 'stepper_plus',
          isDisabled: _currentCount == widget.maxCount,
          onTap: () => _updateCount(1),
          brightness: brightness,
        ),
      ],
    );
  }
}
