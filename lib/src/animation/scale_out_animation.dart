import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutScaleOutAnimation extends StatelessWidget {
  const CoconutScaleOutAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 220),
    this.delay = Duration.zero,
    this.endScale = 0.92,
    this.curve = Curves.easeInCubic,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final double endScale;
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
      beginOpacity: 1,
      endOpacity: 0,
      beginScale: 1,
      endScale: endScale,
      curve: curve,
      autoStart: autoStart,
      onCompleted: onCompleted,
      child: child,
    );
  }
}
