import 'package:coconut_design_system/src/animation/character_fade_in_animation.dart';
import 'package:flutter/material.dart';

/// A text animation widget that fades out each character sequentially
/// while keeping the final text layout fixed from the start.
///
/// You can also combine the fade effect with an optional vertical slide so that
/// each character fades out while moving up or down.
class CoconutCharacterFadeOutAnimation extends StatefulWidget {
  const CoconutCharacterFadeOutAnimation({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.curve = Curves.easeIn,
    this.autoStart = true,
    this.fadePortion = 0.45,
    this.slideDirection = CoconutCharacterFadeSlideDirection.none,
    this.slideOffset = 8,
    this.onCompleted,
  });

  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoStart;
  final double fadePortion;
  final CoconutCharacterFadeSlideDirection slideDirection;
  final double slideOffset;
  final VoidCallback? onCompleted;

  @override
  State<CoconutCharacterFadeOutAnimation> createState() => _CoconutCharacterFadeOutAnimationState();
}

class _CoconutCharacterFadeOutAnimationState extends State<CoconutCharacterFadeOutAnimation>
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
  void didUpdateWidget(covariant CoconutCharacterFadeOutAnimation oldWidget) {
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
                    style: baseStyle.copyWith(color: baseColor),
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
    if (totalCount <= 0) return 0;

    final step = 1 / totalCount;
    final start = index * step;
    final end = (start + (step * widget.fadePortion)).clamp(start + 0.0001, 1.0);

    if (progress <= start) return 1;
    if (progress >= end) return 0;

    return (1 - ((progress - start) / (end - start))).clamp(0.0, 1.0);
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
      return 0;
    }

    if (progress >= end) {
      return _finalSlideOffset;
    }

    final t = ((progress - start) / (end - start)).clamp(0.0, 1.0);
    return _finalSlideOffset * t;
  }

  double get _finalSlideOffset {
    return switch (widget.slideDirection) {
      CoconutCharacterFadeSlideDirection.none => 0,
      CoconutCharacterFadeSlideDirection.slideUp => -widget.slideOffset,
      CoconutCharacterFadeSlideDirection.slideDown => widget.slideOffset,
    };
  }
}
