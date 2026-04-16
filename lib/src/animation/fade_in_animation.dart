import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutFadeInAnimation extends StatelessWidget {
  const CoconutFadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 220),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoStart;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return CoconutTransitionAnimation(
      duration: duration,
      delay: delay,
      beginOffset: Offset.zero,
      endOffset: Offset.zero,
      beginOpacity: 0,
      endOpacity: 1,
      beginScale: 1,
      endScale: 1,
      curve: curve,
      autoStart: autoStart,
      onCompleted: onCompleted,
      child: child,
    );
  }
}
