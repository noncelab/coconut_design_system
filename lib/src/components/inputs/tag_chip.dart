import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A customizable tag chip widget for displaying hashtags or labels.
///
/// `CoconutTagChip` supports various styles, including selected, unselected,
/// and default states. It allows customization of colors, text styles, shapes,
/// and border properties.
class CoconutTagChip extends StatelessWidget {
  /// The text of the tag displayed inside the chip.
  ///
  /// This text will be prefixed with `#` automatically.
  final String tag;

  /// The background and border color of the tag chip.
  final Color color;

  /// The text style used for the tag label.
  ///
  /// Defaults to `CoconutTypography.caption_10`.
  final TextStyle textStyle;

  /// The status of the chip, which determines its appearance.
  ///
  /// - `none`: Default style.
  /// - `selected`: Uses a higher opacity.
  /// - `unselected`: Uses a lower opacity.
  final CoconutChipStatus status;

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

  /// Optional callback function triggered when the chip is tapped.
  ///
  /// The function receives the `tag` string as an argument.
  final Function(String)? onTap;

  /// Creates a `CoconutTagChip` widget.
  ///
  /// - [tag] sets the text inside the chip (automatically prefixed with `#`).
  /// - [color] sets the background and border color.
  /// - [textStyle] defines the font style.
  /// - [status] controls the chip's appearance (`none`, `selected`, `unselected`).
  /// - [isRectangle] sets the chip shape (rounded or rectangular).
  /// - [padding] customizes the internal spacing inside the chip.
  /// - [borderWidth] defines the thickness of the chip's border.
  /// - [onTap] allows interaction when the chip is tapped.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutTagChip(
  ///   tag: "flutter",
  ///   color: Colors.blue,
  ///   status: CoconutChipStatus.selected,
  ///   onTap: (String tag) {
  ///     print("Tag tapped: $tag");
  ///   },
  /// )
  /// ```
  const CoconutTagChip({
    super.key,
    required this.tag,
    required this.color,
    this.textStyle = CoconutTypography.caption_10,
    this.status = CoconutChipStatus.none,
    this.isRectangle = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderWidth = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call(tag);
            }
          : null,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color.withOpacity(status == CoconutChipStatus.selected ? 0.3 : 0.18),
          borderRadius: BorderRadius.circular(
            isRectangle ? CoconutStyles.radius_50 : CoconutStyles.radius_500,
          ),
          border: Border.all(
              color: color.withOpacity(status == CoconutChipStatus.unselected ? 0.15 : 1), width: borderWidth),
        ),
        child: Text(
          '#$tag',
          style: textStyle.copyWith(
            color: color.withOpacity(status == CoconutChipStatus.unselected ? 0.18 : 1),
            //fontWeight: status == CoconutChipStatus.selected ? FontWeight.w700 : null,
          ),
        ),
      ),
    );
  }
}

/// Defines the different states of `CoconutTagChip`.
///
/// - `none`: Default style.
/// - `selected`: The chip has a higher opacity.
/// - `unselected`: The chip has a lower opacity.
enum CoconutChipStatus {
  none,
  selected,
  unselected,
}
