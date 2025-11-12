import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// ## **Coconut Design System - Underlined Button**
///
/// `CoconutUnderlinedButton` is a text-based button with an underline effect.
/// - It supports **light and dark mode** themes.
/// - Provides **pressing color change effects**.
/// - Fully customizable with **text styles, colors, padding, and active states**.
///
/// ### **Example Usage**
/// ```dart
/// CoconutUnderlinedButton(
///   text: "Click Me",
///   onTap: () {
///     print("Underlined Button Clicked!");
///   },
/// )
/// ```

class CoconutUnderlinedButton extends StatefulWidget {
  /// - Deprecated: This parameter will be removed in version `0.9.0`.
  /// - Now automatically inferred from `CoconutTheme.brightness()`.
  @Deprecated('This parameter will be removed in version 0.8. It is now inferred from CoconutTheme.brightness.')
  final Brightness? brightness;

  /// **The text label displayed on the button.**
  final String text;

  /// **The text style for the button label.**
  /// - Default: `CoconutTypography.body2_14_Bold`
  final TextStyle textStyle;

  /// **The width of the underline (default: `1.0`).**
  final double lineWidth;

  /// **Callback function executed when the button is tapped.**
  final VoidCallback onTap;

  /// **Padding around the button (optional).**
  /// - Default: `EdgeInsets.all(4)`
  final EdgeInsetsGeometry? padding;

  /// **Default underline color (optional).**
  /// - If `null`, it uses the default `CoconutColors.onPrimary(brightness)`.
  final Color? defaultColor;

  /// **Underline color when the button is pressed (optional).**
  /// - If `null`, it falls back to `defaultColor.withOpacity(0.5)`.
  final Color? pressingColor;

  final bool isActive;

  /// **Determines if the button is active or disabled.**
  /// - If `false`, the button is grayed out and cannot be pressed.
  /// **Constructor for `CoconutUnderlinedButton`**
  CoconutUnderlinedButton({
    super.key,
    this.brightness,
    required this.text,
    TextStyle? textStyle,
    this.lineWidth = 1,
    required this.onTap,
    this.padding,
    this.defaultColor,
    this.pressingColor,
    this.isActive = true,
  }) : textStyle = textStyle ?? CoconutTypography.body2_14_Bold;

  @override
  State<CoconutUnderlinedButton> createState() => _CoconutUnderlinedButtonState();
}

class _CoconutUnderlinedButtonState extends State<CoconutUnderlinedButton> {
  /// **Tracks whether the button is currently being pressed.**
  late bool _isPressing;
  Brightness brightnesss = CoconutTheme.brightness();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!widget.isActive) return;
        widget.onTap();
        setState(() {
          _isPressing = false;
        });
      },
      onTapDown: (details) {
        if (!widget.isActive) return;
        setState(() {
          _isPressing = true;
        });
      },
      onTapCancel: () {
        if (!widget.isActive) return;
        setState(() {
          _isPressing = false;
        });
      },
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(4),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                softWrap: true,
                style: widget.textStyle.setColor(
                  _getColorForBrightness(brightnesss),
                ),
              ),
              Container(
                width: _getTextWidth(context),
                height: widget.lineWidth,
                color: _getColorForBrightness(brightnesss),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Returns the appropriate color based on the button state.**
  ///
  /// - If `isActive` is `false`, returns a faded color.
  /// - If the button is pressed, returns `pressingColor` or a faded version of `defaultColor`.
  /// - Otherwise, returns `defaultColor` or the primary theme color.
  Color _getColorForBrightness(Brightness brightness) {
    if (!widget.isActive) {
      return CoconutColors.onPrimary(brightness).withOpacity(0.2);
    }
    if (_isPressing) {
      return widget.pressingColor ??
          widget.defaultColor?.withOpacity(0.5) ??
          CoconutColors.onPrimary(brightness).withOpacity(0.5);
    }
    return widget.defaultColor ?? CoconutColors.onPrimary(brightness);
  }

  double _getTextWidth(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  void initState() {
    super.initState();
    _isPressing = false;
  }
}
