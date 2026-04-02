import 'package:flutter/material.dart';

/// Defines the optional slide direction used during the character fade-in animation.
enum CoconutCharacterFadeSlideDirection {
  none,
  slideUp,
  slideDown,
}

/// A text animation widget that fades in each character sequentially
/// while keeping the final text layout fixed from the start.
///
/// Unlike a typewriter animation, this widget does not shift the position of
/// later characters as the animation progresses. Every character already
/// occupies its final position and becomes visible with a staggered fade-in.
///
/// You can also combine the fade effect with an optional vertical slide so that
/// each character fades in while moving up or down into place.
///
/// Example usage:
/// ```dart
/// CoconutCharacterFadeInAnimation(
///   text: 'Hello Coconut',
///   textStyle: TextStyle(fontSize: 16),
///   autoStart: true,
/// )
/// ```
class CoconutCharacterFadeInAnimation extends StatefulWidget {
  const CoconutCharacterFadeInAnimation({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.autoStart = true,
    this.fadePortion = 0.45,
    this.slideDirection = CoconutCharacterFadeSlideDirection.none,
    this.slideOffset = 8,
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

  /// Delay before the animation starts automatically.
  final Duration delay;

  /// The animation curve used for the character reveal progression.
  final Curve curve;

  /// Whether to start the animation automatically after the first frame.
  final bool autoStart;

  /// The portion of each character interval used for the fade transition.
  ///
  /// Larger values create more overlap between neighboring character fades.
  final double fadePortion;

  /// The optional vertical slide direction applied during the fade-in.
  final CoconutCharacterFadeSlideDirection slideDirection;

  /// The vertical distance in logical pixels used for the slide animation.
  final double slideOffset;

  /// Callback triggered when the animation completes.
  final VoidCallback? onCompleted;

  @override
  State<CoconutCharacterFadeInAnimation> createState() => _CoconutCharacterFadeInAnimationState();
}

class _CoconutCharacterFadeInAnimationState extends State<CoconutCharacterFadeInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progressAnimation;
  int _startToken = 0;

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
          _startWithDelay();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant CoconutCharacterFadeInAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.curve != widget.curve) {
      _progressAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }

    if (oldWidget.text != widget.text && widget.autoStart) {
      _startWithDelay();
    }
  }

  /// Restarts the character fade-in animation from the beginning.
  void start() {
    _controller.forward(from: 0);
  }

  void _startWithDelay() {
    final token = ++_startToken;
    if (widget.delay <= Duration.zero) {
      start();
      return;
    }

    Future<void>.delayed(widget.delay, () {
      if (!mounted || token != _startToken) return;
      start();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characters = widget.text.characters.toList(growable: false);
    final baseStyle = widget.textStyle ?? DefaultTextStyle.of(context).style;
    final baseColor = baseStyle.color ?? DefaultTextStyle.of(context).style.color;

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final spans = <InlineSpan>[];
        final total = characters.length;

        for (int index = 0; index < total; index++) {
          final opacity = _resolveCharacterOpacity(
            index: index,
            totalCount: total,
            progress: _progressAnimation.value,
          );
          final dy = _resolveCharacterDy(
            index: index,
            totalCount: total,
            progress: _progressAnimation.value,
          );

          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Transform.translate(
                offset: Offset(0, dy),
                child: Opacity(
                  opacity: opacity,
                  child: Text(
                    characters[index],
                    style: baseStyle.copyWith(
                      color: baseColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Text.rich(
          TextSpan(
            style: baseStyle,
            children: spans,
          ),
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        );
      },
    );
  }

  double _resolveCharacterOpacity({
    required int index,
    required int totalCount,
    required double progress,
  }) {
    if (totalCount <= 0) return 1;

    final step = 1 / totalCount;
    final start = index * step;
    final end = (start + (step * widget.fadePortion)).clamp(start + 0.0001, 1.0);

    if (progress <= start) return 0;
    if (progress >= end) return 1;

    return ((progress - start) / (end - start)).clamp(0.0, 1.0);
  }

  double _resolveCharacterDy({
    required int index,
    required int totalCount,
    required double progress,
  }) {
    if (widget.slideDirection == CoconutCharacterFadeSlideDirection.none || totalCount <= 0) {
      return 0;
    }

    final step = 1 / totalCount;
    final start = index * step;
    final end = (start + (step * widget.fadePortion)).clamp(start + 0.0001, 1.0);

    if (progress <= start) {
      return _initialSlideOffset;
    }

    if (progress >= end) {
      return 0;
    }

    final t = ((progress - start) / (end - start)).clamp(0.0, 1.0);
    return _initialSlideOffset * (1 - t);
  }

  double get _initialSlideOffset {
    return switch (widget.slideDirection) {
      CoconutCharacterFadeSlideDirection.none => 0,
      CoconutCharacterFadeSlideDirection.slideUp => widget.slideOffset,
      CoconutCharacterFadeSlideDirection.slideDown => -widget.slideOffset,
    };
  }
}
