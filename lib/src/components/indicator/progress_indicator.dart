import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable linear progress indicator.
///
/// This widget displays a horizontal progress bar with adjustable properties
/// such as colors, width, height, animation duration, and curves.
///
/// Example usage:
/// ```dart
/// CoconutProgressIndicator(
///   progress: 0.5,  // 50% progress
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey,
///   borderRadius: 8.0,
///   duration: 1000,  // Animation duration in milliseconds
///   curve: Curves.easeInOut,
/// )
/// ```
class CoconutProgressIndicator extends StatefulWidget {
  /// The color of the progress bar.
  ///
  /// If not provided, it defaults to the primary color based on the theme.
  final Color? progressColor;

  /// The background color of the progress bar.
  ///
  /// If not provided, it adapts to the current brightness mode (light/dark).
  final Color? backgroundColor;

  /// The current progress value (between `0.0` and `1.0`).
  final double progress;

  /// The border radius of the progress bar.
  ///
  /// If not specified, it defaults to `CoconutStyles.radius_100`.
  final double? borderRadius;

  /// The width of the progress bar.
  ///
  /// If not specified, it expands to the available space.
  final double? width;

  /// The height of the progress bar.
  ///
  /// Defaults to `2.0`.
  final double? height;

  /// The duration of the progress animation in milliseconds.
  ///
  /// Defaults to `500` ms.
  final int? duration;

  /// The animation curve for the progress bar transition.
  ///
  /// Defaults to `Curves.easeInOut`.
  final Curve? curve;

  /// Creates a new instance of `CoconutProgressIndicator`.
  ///
  /// - [progress] is required and should be between `0.0` and `1.0`.
  /// - If [progressColor] is not provided, it defaults to the theme-based primary color.
  /// - If [backgroundColor] is not provided, it adapts based on the theme.
  /// - If [borderRadius] is not provided, it defaults to `CoconutStyles.radius_100`.
  /// - If [width] is not provided, it takes the available space.
  /// - If [height] is not provided, it defaults to `2.0`.
  /// - If [duration] is not provided, it defaults to `500` milliseconds.
  /// - If [curve] is not provided, it defaults to `Curves.easeInOut`.
  const CoconutProgressIndicator({
    super.key,
    required this.progress,
    this.progressColor,
    this.backgroundColor,
    this.borderRadius,
    this.duration,
    this.width,
    this.height,
    this.curve,
  });

  @override
  State<StatefulWidget> createState() => _CoconutProgressIndicatorState();
}

class _CoconutProgressIndicatorState extends State<CoconutProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Brightness brightness = CoconutTheme.brightness();
        double progress = widget.progress;

        // Set default colors based on theme
        Color progressColor = widget.progressColor ?? CoconutColors.onPrimary(brightness);
        Color backgroundColor =
            widget.backgroundColor ?? (brightness == Brightness.light ? CoconutColors.gray300 : CoconutColors.gray700);

        // Define default values
        double borderRadius = widget.borderRadius ?? CoconutStyles.radius_100;
        double width = widget.width ?? constraints.maxWidth;
        double height = widget.height ?? 2;
        int duration = widget.duration ?? 500;
        Curve curve = widget.curve ?? Curves.easeInOut;

        // Calculate the width based on progress
        double progressWidth = width * progress.clamp(0.0, 1.0);

        return Stack(
          children: [
            // Background bar
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                height: height,
                width: width,
                color: backgroundColor,
              ),
            ),
            // Progress bar with animation
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: AnimatedContainer(
                duration: Duration(milliseconds: duration),
                curve: curve,
                height: height,
                width: progressWidth,
                color: progressColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
