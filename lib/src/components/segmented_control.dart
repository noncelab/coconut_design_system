import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable segmented control widget that allows users to select
/// one option from multiple choices.
///
/// This widget supports various styling options, including colors, border radius,
/// padding, and text styles. It is designed to fit seamlessly within the Coconut Design System.
class CoconutSegmentedControl extends StatefulWidget {
  /// A list of labels for each segment.
  final List<String> labels;

  /// A list of boolean values indicating the selected state of each segment.
  final List<bool> isSelected;

  /// Callback function that is triggered when a segment is selected.
  final Function(int) onPressed;

  /// The border radius of the entire segmented control container.
  final double? containerBorderRadius;

  /// The border radius of each individual label inside the segmented control.
  final double? labelBorderRadius;

  /// Padding applied to each label inside the segmented control.
  final EdgeInsets? labelPadding;

  /// Background color of the selected segment.
  final Color? selectedColor;

  /// Background color of the unselected segments.
  final Color? unselectedColor;

  /// Text color for the selected segment.
  final Color? selectedTextColor;

  /// Text color for the unselected segments.
  final Color? unselectedTextColor;

  /// Background color of the segmented control container.
  final Color? segmentedControlContainerColor;

  /// Creates a `CoconutSegmentedControl` widget.
  ///
  /// - [labels] must be provided to define the segment options.
  /// - [isSelected] determines the initial selection state.
  /// - [onPressed] is required to handle selection changes.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutSegmentedControl(
  ///   labels: ['Option 1', 'Option 2'],
  ///   isSelected: [true, false],
  ///   onPressed: (index) {
  ///     print('Selected index: $index');
  ///   },
  /// )
  /// ```
  const CoconutSegmentedControl({
    super.key,
    required this.labels,
    required this.isSelected,
    required this.onPressed,
    this.containerBorderRadius,
    this.labelBorderRadius,
    this.labelPadding,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.segmentedControlContainerColor,
  });

  @override
  State<CoconutSegmentedControl> createState() =>
      _CoconutSegmentedControlState();
}

class _CoconutSegmentedControlState extends State<CoconutSegmentedControl> {
  /// Stores the selection state of each segment.
  late List<bool> _selections;

  @override
  Widget build(BuildContext context) {
    // Determines whether the theme is in dark mode.
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    // Set default values if not provided by the user.
    final containerBorderRadius =
        widget.containerBorderRadius ?? CoconutStyles.radius_200;
    final labelBorderRadius =
        widget.labelBorderRadius ?? CoconutStyles.radius_150;
    final labelPadding = widget.labelPadding ??
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        );
    final selectedColor = widget.selectedColor ??
        (isDarkMode ? CoconutColors.gray900 : CoconutColors.gray900);
    final unselectedColor = widget.unselectedColor ?? Colors.transparent;
    final segmentedControlContainerColor =
        widget.segmentedControlContainerColor ??
            (isDarkMode ? CoconutColors.gray800 : CoconutColors.gray150);
    final selectedTextColor = widget.selectedTextColor ?? CoconutColors.white;
    final unselectedTextColor = widget.unselectedTextColor ??
        (isDarkMode ? CoconutColors.gray500 : CoconutColors.gray400);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerBorderRadius),
        color: segmentedControlContainerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.labels.length, (index) {
          final bool isSelected = _selections[index];

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(labelBorderRadius),
                  splashColor: selectedColor.withOpacity(0.2),
                  highlightColor: selectedColor.withOpacity(0.4),
                  onTap: () => _handlePress(index),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(labelBorderRadius),
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                    alignment: Alignment.center,
                    padding: labelPadding,
                    child: Text(
                      widget.labels[index],
                      style: isSelected
                          ? CoconutTypography.body3_12_Bold
                              .setColor(selectedTextColor)
                          : CoconutTypography.body3_12
                              .setColor(unselectedTextColor),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selections = List.from(widget.isSelected);
  }

  /// Handles segment selection when a user taps a segment.
  ///
  /// - Updates `_selections` to reflect the new selected state.
  /// - Calls the `onPressed` callback to notify the parent widget.
  void _handlePress(int index) {
    setState(() {
      _selections = List.generate(widget.labels.length, (i) => i == index);
    });
    widget.onPressed(index);
  }
}
