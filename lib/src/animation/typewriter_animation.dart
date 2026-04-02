import 'package:flutter/material.dart';

/// A text animation widget that reveals characters one by one.
///
/// This widget is useful for typewriter-style introductions, onboarding text,
/// or small motion accents in content areas.
///
/// Example usage:
/// ```dart
/// CoconutTypewriterAnimation(
///   text: 'Hello Coconut',
///   textStyle: TextStyle(fontSize: 16),
///   autoStart: true,
/// )
/// ```
class CoconutTypewriterAnimation extends StatefulWidget {
  const CoconutTypewriterAnimation({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.linear,
    this.autoStart = true,
    this.onCompleted,
  });

  /// The full text to reveal progressively.
  final String text;

  /// The style applied to the animated text.
  final TextStyle? textStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text.
  final int? maxLines;

  /// The overflow behavior of the text.
  final TextOverflow? overflow;

  /// The total duration required to reveal the full text.
  final Duration duration;

  /// The animation curve used for the text reveal progression.
  final Curve curve;

  /// Whether to start the animation automatically after the first frame.
  final bool autoStart;

  /// Callback triggered when the animation completes.
  final VoidCallback? onCompleted;

  @override
  State<CoconutTypewriterAnimation> createState() => _CoconutTypewriterAnimationState();
}

class _CoconutTypewriterAnimationState extends State<CoconutTypewriterAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call();
      }
    });

    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          start();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant CoconutTypewriterAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.text != widget.text && widget.autoStart) {
      start();
    }
  }

  /// Restarts the typewriter animation from the beginning.
  void start() {
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final visibleLength = (widget.text.characters.length * _progressAnimation.value).round();
        final visibleText = widget.text.characters.take(visibleLength).toString();

        return Text(
          visibleText,
          style: widget.textStyle,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        );
      },
    );
  }
}
