import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutBounceInAnimation extends StatelessWidget {
  const CoconutBounceInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 420),
    this.delay = Duration.zero,
    this.beginScale = 0.78,
    this.curve = Curves.elasticOut,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final double beginScale;
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
      beginScale: beginScale,
      endScale: 1,
      curve: curve,
      autoStart: autoStart,
      onCompleted: onCompleted,
      child: child,
    );
  }
}
