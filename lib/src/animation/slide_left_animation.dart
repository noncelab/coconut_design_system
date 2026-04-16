import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutSlideLeftAnimation extends StatelessWidget {
  const CoconutSlideLeftAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 280),
    this.delay = Duration.zero,
    this.offset = const Offset(24, 0),
    this.curve = Curves.easeOutCubic,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;
  final Curve curve;
  final bool autoStart;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return CoconutTransitionAnimation(
      duration: duration,
      delay: delay,
      beginOffset: offset,
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
