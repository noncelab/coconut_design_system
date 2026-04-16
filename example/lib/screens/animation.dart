import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final Map<String, int> _playCounts = <String, int>{};

  void _replay(String key) {
    setState(() {
      _playCounts[key] = (_playCounts[key] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
          final brightness = isDarkMode ? Brightness.dark : Brightness.light;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: CoconutLayout.defaultPadding,
              right: CoconutLayout.defaultPadding,
              top: Sizes.size30,
              bottom: Sizes.size60,
            ),
            child: Column(
              children: [
                _buildAnimationExample(
                  title: 'Slide Up',
                  replayKey: 'slide_up',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutSlideUpAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Slide Down',
                  replayKey: 'slide_down',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutSlideDownAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Slide Left',
                  replayKey: 'slide_left',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutSlideLeftAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Slide Right',
                  replayKey: 'slide_right',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutSlideRightAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Fade In',
                  replayKey: 'fade_in',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutFadeInAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Fade Out',
                  replayKey: 'fade_out',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutFadeOutAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Scale In',
                  replayKey: 'scale_in',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutScaleInAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Scale Out',
                  replayKey: 'scale_out',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutScaleOutAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Zoom In',
                  replayKey: 'zoom_in',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutZoomInAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Zoom Out',
                  replayKey: 'zoom_out',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutZoomOutAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Bounce In',
                  replayKey: 'bounce_in',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutBounceInAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Bounce Out',
                  replayKey: 'bounce_out',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutBounceOutAnimation(
                    key: key,
                    child: sample,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Typewriter',
                  replayKey: 'typewriter',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutTypewriterAnimation(
                    key: key,
                    text: 'Coconut typewriter animation example',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1800),
                  ),
                  sampleBuilder: () => _buildTypewriterSample(brightness),
                ),
                _buildAnimationExample(
                  title: 'Character Fade In',
                  replayKey: 'character_fade_in',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeInAnimation(
                    key: key,
                    text: 'Characters fade in without shifting layout',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                  ),
                ),
                _buildAnimationExample(
                  title: 'Character Fade In Slide Down',
                  replayKey: 'character_fade_in_slide_down',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeInAnimation(
                    key: key,
                    text: 'Characters fade in with slide down',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                    slideDirection: CoconutCharacterFadeSlideDirection.slideDown,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Character Fade In Slide Up',
                  replayKey: 'character_fade_in_slide_up',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeInAnimation(
                    key: key,
                    text: 'Characters fade in with slide up',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                    slideDirection: CoconutCharacterFadeSlideDirection.slideUp,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Character Fade Out',
                  replayKey: 'character_fade_out',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeOutAnimation(
                    key: key,
                    text: 'Characters fade out without shifting layout',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                  ),
                ),
                _buildAnimationExample(
                  title: 'Character Fade Out Slide Down',
                  replayKey: 'character_fade_out_slide_down',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeOutAnimation(
                    key: key,
                    text: 'Characters fade out with slide down',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                    slideDirection: CoconutCharacterFadeSlideDirection.slideDown,
                  ),
                ),
                _buildAnimationExample(
                  title: 'Character Fade Out Slide Up',
                  replayKey: 'character_fade_out_slide_up',
                  brightness: brightness,
                  childBuilder: (key, sample) => CoconutCharacterFadeOutAnimation(
                    key: key,
                    text: 'Characters fade out with slide up',
                    textStyle: CoconutTypography.body2_14_Bold.setColor(
                      CoconutColors.onBlack(brightness),
                    ),
                    duration: const Duration(milliseconds: 1600),
                    slideDirection: CoconutCharacterFadeSlideDirection.slideUp,
                  ),
                ),
                _buildCharacterFadeSequenceExample(brightness),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimationExample({
    required String title,
    required String replayKey,
    required Brightness brightness,
    required Widget Function(ValueKey<int> key, Widget sample) childBuilder,
    Widget Function()? sampleBuilder,
  }) {
    final sample = sampleBuilder?.call() ?? _buildSampleCard(brightness, title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CoconutTypography.body1_16_Bold.setColor(
            CoconutColors.onPrimary(brightness),
          ),
        ),
        CoconutLayout.spacing_300h,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CoconutColors.onGray100(brightness),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CoconutColors.onGray800(brightness),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 88,
                child: Center(
                  child: childBuilder(
                    ValueKey(_playCounts[replayKey] ?? 0),
                    sample,
                  ),
                ),
              ),
              CoconutLayout.spacing_300h,
              CoconutButton(
                text: 'Replay',
                onPressed: () => _replay(replayKey),
                isExpand: true,
              ),
            ],
          ),
        ),
        CoconutLayout.spacing_600h,
      ],
    );
  }

  Widget _buildSampleCard(Brightness brightness, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: CoconutColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: CoconutTypography.body2_14_Bold.setColor(
          CoconutColors.black,
        ),
      ),
    );
  }

  Widget _buildTypewriterSample(Brightness brightness) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CoconutColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '',
        style: CoconutTypography.body2_14_Bold.setColor(
          CoconutColors.onBlack(brightness),
        ),
      ),
    );
  }

  Widget _buildCharacterFadeSequenceExample(Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Character Fade Sequence',
          style: CoconutTypography.body1_16_Bold.setColor(
            CoconutColors.onPrimary(brightness),
          ),
        ),
        CoconutLayout.spacing_300h,
        _CharacterFadeSequenceDemo(brightness: brightness),
        CoconutLayout.spacing_600h,
      ],
    );
  }
}

enum _CharacterSequencePhase {
  hidden,
  entering,
  visible,
  exiting,
}

class _CharacterFadeSequenceDemo extends StatefulWidget {
  const _CharacterFadeSequenceDemo({
    required this.brightness,
  });

  final Brightness brightness;

  @override
  State<_CharacterFadeSequenceDemo> createState() => _CharacterFadeSequenceDemoState();
}

class _CharacterFadeSequenceDemoState extends State<_CharacterFadeSequenceDemo> {
  static const _animationDuration = Duration(milliseconds: 600);
  static const _sequenceText = 'Slide down fade in, then fade out slide up';

  _CharacterSequencePhase _phase = _CharacterSequencePhase.hidden;
  int _playCount = 0;

  void _playSequence() {
    setState(() {
      if (_phase == _CharacterSequencePhase.hidden || _phase == _CharacterSequencePhase.exiting) {
        _playCount += 1;
        _phase = _CharacterSequencePhase.entering;
      } else {
        _playCount += 1;
        _phase = _CharacterSequencePhase.exiting;
      }
    });
  }

  TextStyle get _sequenceTextStyle {
    return CoconutTypography.body2_14_Bold.setColor(
      CoconutColors.onBlack(widget.brightness),
    );
  }

  Widget _buildEnteringAnimation() {
    return CoconutCharacterFadeInAnimation(
      key: ValueKey('enter_$_playCount'),
      text: _sequenceText,
      textStyle: _sequenceTextStyle,
      duration: _animationDuration,
      slideDirection: CoconutCharacterFadeSlideDirection.slideDown,
      onCompleted: () {
        if (!mounted || _phase != _CharacterSequencePhase.entering) return;

        setState(() {
          _phase = _CharacterSequencePhase.visible;
        });
      },
    );
  }

  Widget _buildExitingAnimation() {
    return CoconutCharacterFadeOutAnimation(
      key: ValueKey('exit_$_playCount'),
      text: _sequenceText,
      textStyle: _sequenceTextStyle,
      duration: _animationDuration,
      slideDirection: CoconutCharacterFadeSlideDirection.slideUp,
      onCompleted: () {
        if (!mounted || _phase != _CharacterSequencePhase.exiting) return;

        setState(() {
          _phase = _CharacterSequencePhase.hidden;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CoconutColors.onGray100(widget.brightness),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CoconutColors.onGray800(widget.brightness),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 88,
            child: Center(
              child: switch (_phase) {
                _CharacterSequencePhase.hidden => const SizedBox.shrink(),
                _CharacterSequencePhase.entering ||
                _CharacterSequencePhase.visible =>
                  _buildEnteringAnimation(),
                _CharacterSequencePhase.exiting => _buildExitingAnimation(),
              },
            ),
          ),
          CoconutLayout.spacing_300h,
          CoconutButton(
            text: _phase == _CharacterSequencePhase.hidden ||
                    _phase == _CharacterSequencePhase.exiting
                ? 'Show'
                : 'Hide',
            onPressed: _playSequence,
            isExpand: true,
          ),
        ],
      ),
    );
  }
}
