import 'package:flutter/material.dart';

class CoconutTransitionAnimation extends StatefulWidget {
  const CoconutTransitionAnimation({
    super.key,
    required this.child,
    required this.beginOffset,
    required this.endOffset,
    required this.beginOpacity,
    required this.endOpacity,
    required this.beginScale,
    required this.endScale,
    required this.curve,
    required this.duration,
    this.delay = Duration.zero,
    this.alignment = Alignment.center,
    this.autoStart = true,
    this.onCompleted,
  });

  final Widget child;
  final Offset beginOffset;
  final Offset endOffset;
  final double beginOpacity;
  final double endOpacity;
  final double beginScale;
  final double endScale;
  final Curve curve;
  final Duration duration;
  final Duration delay;
  final Alignment alignment;
  final bool autoStart;
  final VoidCallback? onCompleted;

  @override
  State<CoconutTransitionAnimation> createState() => _CoconutTransitionAnimationState();
}

class _CoconutTransitionAnimationState extends State<CoconutTransitionAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;
  int _startToken = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _offsetAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(_animation);
    _opacityAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(_animation);
    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(_animation);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call();
      }
    });

    if (widget.autoStart) {
      _startAnimationWithDelay();
    }
  }

  @override
  void didUpdateWidget(covariant CoconutTransitionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((oldWidget.autoStart != widget.autoStart || oldWidget.delay != widget.delay) && widget.autoStart) {
      _startAnimationWithDelay();
    }
  }

  void _startAnimationWithDelay() {
    final token = ++_startToken;

    if (widget.delay <= Duration.zero) {
      _controller.forward(from: 0);
      return;
    }

    Future<void>.delayed(widget.delay, () {
      if (!mounted || token != _startToken) return;
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: _offsetAnimation.value,
            child: Transform.scale(
              alignment: widget.alignment,
              scale: _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
