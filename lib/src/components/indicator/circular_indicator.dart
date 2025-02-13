import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A customizable circular loading indicator using Lottie animations.
///
/// This widget provides a flexible way to integrate Lottie-based loading animations
/// with support for custom asset paths, looping, reversing, animation speed, and
/// theming support.
///
/// Example usage:
/// ```dart
/// CoconutCircularIndicator(
///   lottieAsset: 'assets/lottie/loading.json',
///   reverse: true,
///   loop: false,
///   size: 150.0,
///   duration: 3,
/// )
/// ```
class CoconutCircularIndicator extends StatefulWidget {
  /// The local asset path of the Lottie animation file.
  ///
  /// If not provided, the widget will use default loading animations
  /// based on the current theme (light/dark).
  final String? lottieAsset;

  /// The network URL of the Lottie animation file.
  final String? lottieNetwork;

  /// Whether the animation should play in reverse.
  ///
  /// Default is `false`.
  final bool reverse;

  /// Whether the animation should loop indefinitely.
  ///
  /// Default is `true`.
  final bool loop;

  /// The size of the indicator (width & height).
  ///
  /// Default is `200.0`.
  final double size;

  /// The duration of the animation in seconds.
  ///
  /// Default is `2` seconds.
  final int duration;

  /// A color filter to apply to the Lottie animation.
  ///
  /// If set, it changes the color of the animation.
  final Color? colorFilter;

  /// An optional external animation controller for managing the animation manually.
  ///
  /// If provided, the animation is controlled externally.
  final AnimationController? controller;

  /// Creates a new instance of `CoconutCircularIndicator`.
  const CoconutCircularIndicator({
    super.key,
    this.lottieAsset,
    this.lottieNetwork,
    this.reverse = false,
    this.loop = true,
    this.size = 200.0,
    this.duration = 2,
    this.colorFilter,
    this.controller,
  });

  @override
  State<CoconutCircularIndicator> createState() =>
      _CoconutCircularIndicatorState();
}

class _CoconutCircularIndicatorState extends State<CoconutCircularIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Lottie.asset(
          widget.lottieAsset ??
              (brightness == Brightness.light
                  ? 'packages/coconut_design_system/assets/lottie/loading_light.json'
                  : 'packages/coconut_design_system/assets/lottie/loading_dark.json'),
          controller: _controller,
          repeat: widget.loop,
          reverse: widget.reverse,
          animate: true,
          fit: BoxFit.contain,
          delegates: LottieDelegates(
            values: [
              if (widget.colorFilter != null)
                ValueDelegate.color(['**'], value: widget.colorFilter!),
            ],
          ),
        ));
  }

  @override
  void didUpdateWidget(covariant CoconutCircularIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart animation when reverse or loop properties change
    if (widget.reverse != oldWidget.reverse || widget.loop != oldWidget.loop) {
      _controller.stop();
      _startAnimation();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: Duration(seconds: widget.duration),
        );

    _startAnimation();
  }

  /// Starts the animation based on the provided properties.
  void _startAnimation() {
    if (widget.reverse) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    if (widget.loop) {
      _controller.repeat(reverse: widget.reverse);
    }
  }
}
