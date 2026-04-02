import 'package:coconut_design_system/src/animation/transition_animation.dart';
import 'package:flutter/material.dart';

class CoconutSlideDownAnimation extends StatelessWidget {
  const CoconutSlideDownAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 280),
    this.offset = const Offset(0, -24),
    this.curve = Curves.easeOutCubic,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final Offset offset;
  final Curve curve;
  final bool autoStart;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return CoconutTransitionAnimation(
      duration: duration,
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
