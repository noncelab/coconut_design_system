import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A customizable chip widget for displaying small UI elements like tags, labels, or badges.
///
/// `CoconutChip` supports both rounded and rectangular shapes, customizable colors, borders,
/// and optional tap interactions.
class CoconutChip extends StatelessWidget {
  /// The background color of the chip.
  final Color color;

  /// The text label displayed inside the chip.
  final String label;

  /// The font family of the label text.
  ///
  /// Defaults to `CoconutTypography.kTextFontFamily`.
  final String labelFontFamily;

  /// The font size of the label text.
  ///
  /// Defaults to `12.0`.
  final double labelSize;

  /// Determines whether the chip should have a rectangular shape.
  ///
  /// - If `true`, the chip has a small border radius (`radius-50`).
  /// - If `false`, the chip is fully rounded (`radius-500`).
  ///
  /// Defaults to `false` (rounded shape).
  final bool isRectangle;

  /// Determines whether the chip is selected.
  ///
  /// - If `true`, the border width increases (`selectedBorderWidth`).
  /// - If `false`, the default border width (`borderWidth`) is used.
  ///
  /// Defaults to `false` (not selected).
  final bool? isSelected;

  /// Determines whether the chip has reduced opacity.
  ///
  /// - If `true`, the chip's background color will have lower opacity.
  /// - If `false`, the background color remains fully opaque.
  ///
  /// Defaults to `false`.
  final bool hasOpacity;

  /// Padding inside the chip.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 8, vertical: 4)`.
  final EdgeInsets padding;

  /// The width of the chip's border.
  ///
  /// Defaults to `0.5`.
  final double borderWidth;

  /// The width of the border when the chip is selected.
  ///
  /// Defaults to `1.0`.
  final double selectedBorderWidth;

  /// The minimum width of the chip.
  ///
  /// - Ensures that the chip does not shrink below this width.
  /// - If the chip's content is wider than `minWidth`, it will expand accordingly.
  ///
  /// Defaults to `40.0`.
  final double minWidth;

  /// The color of the chip's border.
  ///
  /// - If `null`, it defaults to the same color as the chip's background.
  final Color? borderColor;

  /// The color of the label text.
  ///
  /// - If `null`, it defaults to `borderColor`, or `CoconutColors.white`.
  final Color? labelColor;

  /// Optional callback function triggered when the chip is tapped.
  ///
  /// If `null`, the chip will not respond to taps.
  final Function? onTap;

  /// Creates a `CoconutChip` widget.
  ///
  /// - [color] sets the chip's background color.
  /// - [label] defines the text content inside the chip.
  /// - [labelFontFamily] specifies the font family for the label text.
  /// - [labelSize] sets the font size of the label text.
  /// - [labelColor] allows customization of the label text color.
  /// - [isRectangle] controls whether the chip has a rectangular shape (`true`) or a rounded shape (`false`).
  /// - [isSelected] determines whether the chip is in a selected state.
  ///   - When `true`, the border width increases to `selectedBorderWidth`.
  /// - [hasOpacity] controls whether the chip's background has reduced opacity.
  ///   - If `true`, the background color will be slightly transparent.
  /// - [padding] adjusts the internal spacing inside the chip.
  /// - [borderWidth] defines the thickness of the chip's border when not selected.
  /// - [selectedBorderWidth] defines the thickness of the chip's border when selected.
  /// - [borderColor] allows customization of the border color.
  /// - [minWidth] ensures that the chip maintains a minimum width.
  /// - [onTap] enables interactive behavior when the chip is tapped.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutChip(
  ///   color: Colors.blue,
  ///   label: 'Chip Label',
  ///   labelFontFamily: 'Arial',
  ///   labelSize: 14,
  ///   isRectangle: false,
  ///   isSelected: true,
  ///   hasOpacity: true,
  ///   minWidth: 50,  // Ensures the chip is at least 50px wide
  ///   borderWidth: 0.5,
  ///   selectedBorderWidth: 1.5,
  ///   borderColor: Colors.blueAccent,
  ///   labelColor: Colors.white,
  ///   onTap: () {
  ///     print("Chip tapped!");
  ///   },
  /// )
  /// ```
  const CoconutChip({
    super.key,
    required this.color,
    required this.label,
    this.labelFontFamily = CoconutTypography.kTextFontFamily,
    this.labelSize = 12,
    this.isRectangle = false,
    this.isSelected,
    this.hasOpacity = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderWidth = 0.5,
    this.selectedBorderWidth = 1,
    this.minWidth = 40,
    this.borderColor,
    this.labelColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Container(
        padding: padding,
        constraints: BoxConstraints(
          minWidth: minWidth,
        ),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(
            isRectangle ? CoconutStyles.radius_50 : CoconutStyles.radius_500,
          ),
          border: Border.all(
              color: (borderColor ?? color)
                  .withOpacity(isSelected == false ? 0.6 : 1.0),
              width: isSelected == true ? selectedBorderWidth : borderWidth),
        ),
        child: Text(
          label,
          style: getLabelStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    if (hasOpacity) {
      return color.withOpacity(isSelected == true ? 0.35 : 0.18);
    }
    return color;
  }

  TextStyle getLabelStyle() => TextStyle(
      fontFamily: labelFontFamily,
      fontSize: labelSize,
      fontWeight: isSelected == true ? FontWeight.bold : FontWeight.normal,
      color: (labelColor ?? borderColor ?? CoconutColors.white)
          .withOpacity(isSelected == false ? 0.5 : 1.0));
}
