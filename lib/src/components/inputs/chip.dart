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

  /// The child widget inside the chip, usually a `Text` or an `Icon`.
  final Widget child;

  /// Determines whether the chip should have a rectangular shape.
  ///
  /// - If `true`, the chip has a small border radius (`radius-50`).
  /// - If `false`, the chip is fully rounded (`radius-500`).
  ///
  /// Defaults to `false` (rounded shape).
  final bool isRectangle;

  /// Padding inside the chip.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 8, vertical: 4)`.
  final EdgeInsets padding;

  /// The width of the chip's border.
  ///
  /// Defaults to `1.0`.
  final double borderWidth;

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

  /// Optional callback function triggered when the chip is tapped.
  ///
  /// If `null`, the chip will not respond to taps.
  final Function? onTap;

  /// Creates a `CoconutChip` widget.
  ///
  /// - [color] sets the chip's background color.
  /// - [child] defines the content inside the chip (e.g., `Text`, `Icon`).
  /// - [isRectangle] controls whether the chip is rectangular (`true`) or rounded (`false`).
  /// - [padding] adjusts the internal spacing inside the chip.
  /// - [borderWidth] defines the thickness of the chip's border.
  /// - [borderColor] allows customization of the border color.
  /// - [minWidth] ensures that the chip maintains a minimum width.
  /// - [onTap] enables interactive behavior when the chip is tapped.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutChip(
  ///   color: Colors.blue,
  ///   child: Text('Label', style: TextStyle(color: Colors.white)),
  ///   minWidth: 40,  // Ensures the chip is at least 50px wide
  ///   isRectangle: false,
  ///   onTap: () {
  ///     print("Chip tapped!");
  ///   },
  /// )
  /// ```
  const CoconutChip({
    super.key,
    required this.color,
    required this.child,
    this.isRectangle = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderWidth = 1.0,
    this.minWidth = 40,
    this.borderColor,
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
            color: color,
            borderRadius: BorderRadius.circular(
              isRectangle ? CoconutStyles.radius_50 : CoconutStyles.radius_500,
            ),
            border: Border.all(color: borderColor ?? color, width: borderWidth),
          ),
          child: child),
    );
  }
}
