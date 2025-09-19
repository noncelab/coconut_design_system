import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable segmented control widget that allows users to select
/// one option from multiple choices.
///
/// This widget supports various styling options, including colors, border radius,
/// padding, and text styles. It is designed to fit seamlessly within the Coconut Design System.
class CoconutSegmentedControl extends StatefulWidget {
  /// A list of GlobalKeys assigned to each segment.
  final List<GlobalKey>? keys;

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

  /// Whether to show animation when a segment is selected.
  final bool showAnimation;

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
    this.keys,
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
    this.showAnimation = true,
  });

  @override
  State<CoconutSegmentedControl> createState() => _CoconutSegmentedControlState();
}

class _CoconutSegmentedControlState extends State<CoconutSegmentedControl>
    with TickerProviderStateMixin {
  /// Stores the selection state of each segment.
  late List<bool> _selections;

  /// Animation controller for the sliding animation.
  late AnimationController _animationController;

  /// Animation for the position of the selected background.
  late Animation<double> _positionAnimation;

  /// Current selected index for animation.
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Determines whether the theme is in dark mode.
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    // Set default values if not provided by the user.
    final containerBorderRadius = widget.containerBorderRadius ?? CoconutStyles.radius_200;
    final labelBorderRadius = widget.labelBorderRadius ?? CoconutStyles.radius_150;
    final labelPadding = widget.labelPadding ??
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        );
    final selectedColor =
        widget.selectedColor ?? (isDarkMode ? CoconutColors.gray900 : CoconutColors.gray900);
    final unselectedColor = widget.unselectedColor ?? Colors.transparent;
    final segmentedControlContainerColor = widget.segmentedControlContainerColor ??
        (isDarkMode ? CoconutColors.gray800 : CoconutColors.gray150);
    final selectedTextColor = widget.selectedTextColor ?? CoconutColors.white;
    final unselectedTextColor =
        widget.unselectedTextColor ?? (isDarkMode ? CoconutColors.gray500 : CoconutColors.gray400);

    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerBorderRadius),
        color: segmentedControlContainerColor,
      ),
      child: widget.showAnimation
          ? _buildAnimatedSegmentedControl(
              (MediaQuery.sizeOf(context).width - 24) / 2 - 2,
              containerBorderRadius,
              labelBorderRadius,
              labelPadding,
              selectedColor,
              unselectedColor,
              selectedTextColor,
              unselectedTextColor,
            )
          : _buildStaticSegmentedControl(
              labelBorderRadius,
              labelPadding,
              selectedColor,
              unselectedColor,
              selectedTextColor,
              unselectedTextColor,
            ),
    );
  }

  /// Builds the animated version of the segmented control.
  Widget _buildAnimatedSegmentedControl(
    double containerWidth,
    double containerBorderRadius,
    double labelBorderRadius,
    EdgeInsets labelPadding,
    Color selectedColor,
    Color unselectedColor,
    Color selectedTextColor,
    Color unselectedTextColor,
  ) {
    // Update animation position if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showAnimation && _animationController.isDismissed) {
        final currentPosition = _calculatePosition(_currentSelectedIndex, containerWidth);
        _positionAnimation = Tween<double>(
          begin: currentPosition,
          end: currentPosition,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        if (mounted) setState(() {});
      }
    });

    return Stack(
      children: [
        // Animated background
        AnimatedBuilder(
          animation: _positionAnimation,
          builder: (context, child) {
            return Positioned(
              left: _positionAnimation.value,
              top: 2.0,
              bottom: 2.0,
              child: Container(
                width: containerWidth,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(labelBorderRadius),
                  color: selectedColor,
                ),
              ),
            );
          },
        ),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.labels.length, (index) {
            final bool isSelected = _selections[index];
            final GlobalKey? key = widget.keys?[index];

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(labelBorderRadius),
                    splashColor: selectedColor.withOpacity(0.2),
                    highlightColor: selectedColor.withOpacity(0.4),
                    onTap: () => _handlePress(index, containerWidth),
                    child: Container(
                      alignment: Alignment.center,
                      padding: labelPadding,
                      child: Text(
                        key: key,
                        widget.labels[index],
                        style: isSelected
                            ? CoconutTypography.body3_12_Bold.setColor(selectedTextColor)
                            : CoconutTypography.body3_12.setColor(unselectedTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Builds the static version of the segmented control (original behavior).
  Widget _buildStaticSegmentedControl(
    double labelBorderRadius,
    EdgeInsets labelPadding,
    Color selectedColor,
    Color unselectedColor,
    Color selectedTextColor,
    Color unselectedTextColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.labels.length, (index) {
        final bool isSelected = _selections[index];
        final GlobalKey? key = widget.keys?[index];

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
                    key: key,
                    widget.labels[index],
                    style: isSelected
                        ? CoconutTypography.body3_12_Bold.setColor(selectedTextColor)
                        : CoconutTypography.body3_12.setColor(unselectedTextColor),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _selections = List.from(widget.isSelected);

    // Find the initially selected index
    _currentSelectedIndex = _selections.indexWhere((selected) => selected);
    if (_currentSelectedIndex == -1) _currentSelectedIndex = 0;

    // Initialize animation controller if animation is enabled
    if (widget.showAnimation) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      );

      // Initialize with default values, will be updated in build
      _positionAnimation = Tween<double>(
        begin: 2.0,
        end: 2.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void didUpdateWidget(covariant CoconutSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync selections and current index when parent updates selection state
    if (oldWidget.isSelected != widget.isSelected) {
      _selections = List.from(widget.isSelected);
      int newIndex = _selections.indexWhere((selected) => selected);
      if (newIndex == -1) newIndex = 0;
      if (newIndex != _currentSelectedIndex) {
        _currentSelectedIndex = newIndex;
        if (widget.showAnimation) {
          // Ensure next frame re-evaluates the position at the new index
          _animationController.reset();
        }
        if (mounted) setState(() {});
      }
    }
  }

  @override
  void dispose() {
    if (widget.showAnimation) {
      _animationController.dispose();
    }
    super.dispose();
  }

  /// Calculates the left position for the animated background based on the index.
  double _calculatePosition(int index, double containerWidth) {
    return 2 + (containerWidth * index) + 4 * (index);
  }

  /// Handles segment selection when a user taps a segment.
  ///
  /// - Updates `_selections` to reflect the new selected state.
  /// - Animates the background position if animation is enabled.
  /// - Calls the `onPressed` callback to notify the parent widget.
  void _handlePress(int index, [double? containerWidth]) {
    if (index == _currentSelectedIndex) return; // No change needed

    setState(() {
      _selections = List.generate(widget.labels.length, (i) => i == index);
    });

    if (widget.showAnimation && containerWidth != null) {
      final double newPosition = _calculatePosition(index, containerWidth);

      _positionAnimation = Tween<double>(
        begin: _positionAnimation.value,
        end: newPosition,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _animationController.reset();
      _animationController.forward();
    }

    _currentSelectedIndex = index;
    widget.onPressed(index);
  }
}
