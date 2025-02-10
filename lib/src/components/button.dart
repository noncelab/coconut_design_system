import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:coconut_design_system/src/util/vibration.dart';
import 'package:flutter/material.dart';

/// ## **Coconut Design System - Custom Button**
/// **CoconutButton** is a fully customizable button widget for the Coconut Design System.
///
/// ### **Features:**
/// - Supports **filled, outlined, and none** button types.
/// - Automatically adjusts colors for **light and dark mode**.
/// - Includes **vibration feedback** on click (optional).
/// - Allows buttons to be **fully expanded** to the screen width.
/// - Customizable **border, radius, padding, and typography**.
///
/// ### **Usage Example:**
/// ```dart
/// CoconutButton(
///   brightness: Brightness.light,
///   text: "Click Me",
///   onPressed: () {
///     print("Button Clicked!");
///   },
/// )
/// ```
class CoconutButton extends StatefulWidget {
  /// **Brightness of the button**
  /// - Affects default color scheme (light/dark mode).
  final Brightness brightness;

  /// **Button width**
  /// - If `isExpand` is `true`, it takes the full screen width.
  final double? width;

  /// **Button height** (Optional)
  final double? height;

  /// **Padding inside the button**
  /// - Default: `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`
  final EdgeInsets padding;

  /// **Border width**
  /// - Default: `1`
  final double borderWidth;

  /// **Border radius (rounded corners)**
  /// - Default: `12`
  final double borderRadius;

  /// **Callback function when button is clicked**
  final VoidCallback onPressed;

  /// **Button label text**
  final String text;

  /// **Text style for the button label**
  final TextStyle textStyle;

  /// **Background color (default varies based on brightness)**
  final Color backgroundColor;

  /// **Text color (default varies based on brightness)**
  final Color foregroundColor;

  /// **Background color when button is pressed**
  final Color pressedBackgroundColor;

  /// **Text color when button is pressed**
  final Color pressedForegroundColor;

  /// **Text color when button is pressed**
  final Color pressedTextColor;

  /// **Background color when button is disabled**
  final Color disabledBackgroundColor;

  /// **Text color when button is disabled**
  final Color disabledForegroundColor;

  /// **Enable vibration feedback when clicked**
  /// - Default: `false`
  final bool isVibrateActive;

  /// **Button active state**
  /// - If `false`, the button appears disabled.
  final bool isActive;

  /// **Expand button width to full screen**
  /// - If `true`, the button takes the full width of the screen.
  final bool isExpand;

  /// **Button type (filled, outlined, none)**
  final CoconutButtonType buttonType;

  /// **Constructor for CoconutButton**
  CoconutButton({
    super.key,
    required this.brightness,
    this.width,
    this.height,
    EdgeInsets? padding,
    this.borderWidth = 1,
    this.borderRadius = 12,
    required this.onPressed,
    required this.text,
    TextStyle? textStyle,
    this.isVibrateActive = false,
    this.isActive = true,
    this.isExpand = false,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? pressedBackgroundColor,
    Color? pressedForegroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? pressedTextColor,
    this.buttonType = CoconutButtonType.filled,
  })  : padding =
            padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        backgroundColor = backgroundColor ??
            (brightness == Brightness.light
                ? CoconutColors.black
                : CoconutColors.white),
        foregroundColor = foregroundColor ??
            (brightness == Brightness.light
                ? CoconutColors.white
                : CoconutColors.black),
        pressedBackgroundColor = pressedBackgroundColor ??
            (backgroundColor ??
                    (brightness == Brightness.light
                        ? CoconutColors.black
                        : CoconutColors.white))
                .withOpacity(0.5),
        pressedForegroundColor = pressedForegroundColor ??
            (brightness == Brightness.light
                ? CoconutColors.white
                : CoconutColors.black),
        pressedTextColor = pressedTextColor ??
            (brightness == Brightness.light
                ? CoconutColors.white
                : CoconutColors.black),
        disabledBackgroundColor = disabledBackgroundColor ??
            (brightness == Brightness.light
                ? CoconutColors.gray150
                : CoconutColors.gray800),
        disabledForegroundColor = disabledForegroundColor ??
            (brightness == Brightness.light
                ? CoconutColors.gray350
                : CoconutColors.gray700),
        textStyle = textStyle ??
            CoconutTypography.body2_14_Bold
                .setColor(CoconutColors.onPrimary(brightness));

  @override
  State<CoconutButton> createState() => _CoconutButtonState();
}

/// **Button types for CoconutButton**
enum CoconutButtonType {
  filled, // Solid button with background color
  outlined, // Border-only button
  none, // No background, text-only button
}

class _CoconutButtonState extends State<CoconutButton> {
  bool isPressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isPressing = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressing = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressing = false;
        });
      },
      onTap: () {
        onTap();
        setState(() {
          isPressing = false;
        });
      },
      child: Container(
        width: getButtonWidth(context),
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: getBackgroundColor(
              isDarkMode: widget.brightness == Brightness.dark),
          border: Border.all(
              width: widget.borderWidth,
              color: getOutlineColor(
                  isDarkMode: widget.brightness == Brightness.dark)),
          borderRadius: BorderRadius.circular(
            widget.borderRadius,
          ),
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: widget.textStyle.merge(
            TextStyle(
              color: getForegroundColor(
                  isDarkMode: widget.brightness == Brightness.dark),
            ),
          ),
        ),
      ),
    );
  }

  /// **Returns the appropriate background color based on state**
  Color getBackgroundColor({bool isDarkMode = false}) {
    if (!widget.isActive) {
      return switch (widget.buttonType) {
        CoconutButtonType.filled => widget.disabledBackgroundColor,
        CoconutButtonType.outlined => Colors.transparent,
        CoconutButtonType.none => Colors.transparent,
      };
    }
    if (widget.buttonType == CoconutButtonType.none) return Colors.transparent;
    if (isPressing) {
      final outlinePressingColor =
          isDarkMode ? CoconutColors.gray800 : CoconutColors.gray150;
      return switch (widget.buttonType) {
        CoconutButtonType.filled => widget.pressedBackgroundColor,
        CoconutButtonType.outlined => outlinePressingColor,
        CoconutButtonType.none => Colors.transparent,
      };
    }
    return widget.buttonType == CoconutButtonType.filled
        ? widget.backgroundColor
        : widget.brightness == Brightness.light
            ? CoconutColors.white
            : CoconutColors.black;
  }

  /// **Determines button width based on `isExpand` flag**
  double? getButtonWidth(BuildContext context) =>
      widget.isExpand ? MediaQuery.sizeOf(context).width : widget.width;

  /// **Returns the appropriate text color based on state**
  Color getForegroundColor({bool isDarkMode = false}) {
    if (!widget.isActive) return widget.disabledForegroundColor;
    final Color textColor =
        widget.textStyle.color ?? CoconutColors.onPrimary(widget.brightness);
    final outlinePressingColor =
        isDarkMode ? CoconutColors.gray200 : CoconutColors.gray500;
    return switch (widget.buttonType) {
      CoconutButtonType.filled =>
        isPressing ? widget.pressedTextColor : widget.foregroundColor,
      CoconutButtonType.outlined =>
        isPressing ? outlinePressingColor : textColor,
      CoconutButtonType.none =>
        isPressing ? textColor.withOpacity(0.5) : textColor,
    };
  }

  /// **Returns the appropriate border color based on state**
  Color getOutlineColor({bool isDarkMode = false}) {
    if (!widget.isActive) {
      return switch (widget.buttonType) {
        CoconutButtonType.filled => widget.disabledBackgroundColor,
        CoconutButtonType.outlined => widget.disabledForegroundColor,
        CoconutButtonType.none => Colors.transparent,
      };
    }
    if (isPressing) {
      final outlinePressingColor =
          isDarkMode ? CoconutColors.gray200 : CoconutColors.gray500;
      return switch (widget.buttonType) {
        CoconutButtonType.filled => Colors.transparent,
        CoconutButtonType.outlined => outlinePressingColor,
        CoconutButtonType.none => Colors.transparent,
      };
    }
    return switch (widget.buttonType) {
      CoconutButtonType.filled => widget.backgroundColor,
      CoconutButtonType.outlined => widget.backgroundColor,
      CoconutButtonType.none => Colors.transparent,
    };
  }

  /// **Handles button click action**
  void onTap() {
    if (!widget.isActive) return;
    if (widget.isVibrateActive) vibrateLight();
    widget.onPressed.call();
  }
}

extension CoconutButtonCopy on CoconutButton {
  CoconutButton copyWith({
    Brightness? brightness,
    String? text,
    Color? backgroundColor,
    Color? foregroundColor,
    bool? isActive,
    bool? isExpand,
    double? width,
    double? height,
  }) {
    return CoconutButton(
      brightness: brightness ?? this.brightness,
      text: text ?? this.text,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      isActive: isActive ?? this.isActive,
      isExpand: isExpand ?? this.isExpand,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      height: height ?? this.height,
      width: width ?? this.width,
      padding: padding,
      textStyle: textStyle,
      buttonType: buttonType,
      isVibrateActive: isVibrateActive,
    );
  }
}
