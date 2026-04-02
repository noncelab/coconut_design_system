import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutScaleInAnimation extends StatelessWidget {
  const CoconutScaleInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 240),
    this.beginScale = 0.92,
    this.curve = Curves.easeOutCubic,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final double beginScale;
  final Curve curve;
  final bool autoStart;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return CoconutTransitionAnimation(
      duration: duration,
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
