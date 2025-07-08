import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A reusable widget that applies a shaking animation to its child.
///
/// Useful for indicating invalid input or disabled interaction feedback.
///
/// The shake can be customized in direction, magnitude, duration, curve, and frequency.
///
/// Example usage:
/// ```dart
/// CoconutShakeAnimation(
///   shakeOffset: 4,
///   shakeAmount: 3,
///   direction: Axis.horizontal,
///   autoStart: true,
///   child: Text('Invalid input'),
/// )
/// ```
class CoconutShakeAnimation extends StatefulWidget {
  /// The widget to apply the shake animation to.
  final Widget child;

  /// The total duration of the shake animation in milliseconds.
  final int duration;

  /// The maximum distance (in logical pixels) the widget moves during the shake.
  final double shakeOffset;

  /// The number of full shake cycles (left and right or up and down).
  final double shakeAmount;

  /// The axis along which the widget will shake. Defaults to [Axis.horizontal].
  final Axis direction;

  /// The animation curve to apply to the shake motion.
  final Curve curve;

  /// Callback triggered when the animation completes.
  final VoidCallback? onCompleted;

  /// Whether to start the shake animation automatically when the widget is built.
  final bool autoStart;

  const CoconutShakeAnimation({
    super.key,
    required this.child,
    this.duration = 500,
    this.shakeOffset = 3,
    this.shakeAmount = 3,
    this.direction = Axis.horizontal,
    this.curve = Curves.linear,
    this.onCompleted,
    this.autoStart = false,
  });

  @override
  CoconutShakeAnimationState createState() => CoconutShakeAnimationState();
}

class CoconutShakeAnimationState extends State<CoconutShakeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    final items = <TweenSequenceItem<double>>[];
    final offset = widget.shakeOffset;

    items.add(TweenSequenceItem(tween: Tween(begin: 0.0, end: -offset), weight: 1));
    for (int i = 0; i < widget.shakeAmount; i++) {
      items.add(TweenSequenceItem(tween: Tween(begin: -offset, end: offset), weight: 2));
      items.add(TweenSequenceItem(tween: Tween(begin: offset, end: -offset), weight: 2));
    }
    items.add(TweenSequenceItem(tween: Tween(begin: -offset, end: 0.0), weight: 1));

    _offsetAnimation = TweenSequence<double>(items)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call();
      }
    });

    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) => shake());
    }
  }

  void shake() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.direction == Axis.horizontal
              ? Offset(_offsetAnimation.value, 0)
              : Offset(0, _offsetAnimation.value),
          child: widget.child,
        );
      },
    );
  }
}
