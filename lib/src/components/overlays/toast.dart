import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable toast notification utility for displaying temporary messages.
///
/// The `CoconutToast` class provides two types of toast messages:
/// - **showBottomToast()**: Displays a toast message at the bottom of the screen.
/// - **showToast()**: Displays a toast message at the top of the screen.
///
/// Example Usage:
/// ```dart
/// CoconutToast.showBottomToast(
///   brightness: Brightness.light,
///   context: context,
///   text: "This is a bottom toast message.",
/// );
/// ```
class CoconutToast {
  static bool _isToastVisible = false;

  /// Displays a toast message at the bottom of the screen.
  ///
  /// - [brightness]: Determines whether the theme is light or dark.
  /// - [context]: The build context.
  /// - [text]: The message to display in the toast.
  /// - [backgroundColor]: The background color of the toast.
  /// - [borderColor]: The border color of the toast.
  /// - [textColor]: The color of the text inside the toast.
  /// - [seconds]: Duration in seconds before the toast disappears (default: `2`).
  static void showBottomToast({
    required Brightness brightness,
    required BuildContext context,
    required String text,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    int seconds = 2,
  }) {
    if (_isToastVisible) return;
    _isToastVisible = true;

    final fadeController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    late OverlayEntry overlayEntry;

    dismiss({bool isDelay = false}) async {
      try {
        final limitSeconds = seconds <= 3 ? seconds : 3;
        if (isDelay) await Future.delayed(Duration(seconds: limitSeconds));
        await fadeController.forward();
        overlayEntry.remove();
        fadeController.dispose();
        _isToastVisible = false;
      } catch (_) {}
    }

    overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! > 5) {
                  dismiss();
                }
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: backgroundColor ?? CoconutColors.onGray900(brightness),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor ?? CoconutColors.onGray300(brightness),
                    width: 1,
                  ),
                ),
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: CoconutTypography.body2_14.copyWith(
                    decoration: TextDecoration
                        .none, // Prevents underlining in debug mode
                    color: textColor ?? CoconutColors.onGray100(brightness),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    dismiss(isDelay: true);
  }

  /// Displays a toast message at the top of the screen.
  ///
  /// - [brightness]: Determines whether the theme is light or dark.
  /// - [context]: The build context.
  /// - [text]: The message to display in the toast.
  /// - [isVisibleIcon]: Whether to show an icon next to the message.
  /// - [seconds]: Duration in seconds before the toast disappears (default: `3`).
  /// - [backgroundColor]: The background color of the toast.
  /// - [borderColor]: The border color of the toast.
  /// - [textColor]: The color of the text inside the toast.
  static void showToast({
    required Brightness brightness,
    required BuildContext context,
    required String text,
    isVisibleIcon = false,
    int seconds = 3,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
  }) {
    if (_isToastVisible) return;

    _isToastVisible = true;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: CoconutToastWidget(
            text: text,
            brightness: brightness,
            isVisibleIcon: isVisibleIcon,
            onDismiss: () {
              overlayEntry.remove();
            },
            duration: seconds <= 5 ? seconds : 5,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

/// A widget representing a toast message.
class CoconutToastWidget extends StatefulWidget {
  final String text;
  final Brightness brightness;
  final bool isVisibleIcon;
  final int duration;
  final VoidCallback onDismiss;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  /// Creates an instance of `CoconutToastWidget`.
  const CoconutToastWidget({
    super.key,
    required this.text,
    required this.brightness,
    required this.isVisibleIcon,
    required this.duration,
    required this.onDismiss,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  State<CoconutToastWidget> createState() => _CoconutToastWidgetState();
}

class _CoconutToastWidgetState extends State<CoconutToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! < -5) {
              _startFadeOut();
            }
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  CoconutColors.onGray900(widget.brightness),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.borderColor ??
                    CoconutColors.onGray300(widget.brightness),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isVisibleIcon) ...{
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      'packages/coconut_design_system/assets/svg/toast_info.svg',
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        widget.textColor ??
                            CoconutColors.onGray100(widget.brightness),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                } else ...{
                  const SizedBox(
                    height: 24,
                  ),
                },
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.5),
                    child: Text(
                      widget.text,
                      style: CoconutTypography.body2_14.copyWith(
                        decoration: TextDecoration
                            .none, // Prevents underlining in debug mode
                        color: widget.textColor ??
                            CoconutColors.onGray100(widget.brightness),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _offsetAnimation = Tween<Offset>(
            begin: Offset.zero, end: const Offset(0.0, -1.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(seconds: widget.duration), () {
      if (mounted) {
        _startFadeOut();
      }
    });
  }

  void _startFadeOut() {
    _controller.forward().then((_) {
      if (mounted) {
        widget.onDismiss();
        CoconutToast._isToastVisible = false;
      }
    });
  }
}
