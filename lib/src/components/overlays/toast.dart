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

  static const warningYellow = Color.fromRGBO(255, 175, 3, 1.0);
  static const warningYellowBackground = Color.fromRGBO(255, 243, 190, 1.0);

  /// Displays a toast message at the bottom of the screen.
  ///
  /// - [brightness]: Brightness mode used to determine default colors.
  /// - [context]: Context to access the [Overlay] and theme.
  /// - [text]: Text message shown in the toast.
  /// - [backgroundColor]: Optional override for the toast background.
  /// - [borderColor]: Optional override for the toast border.
  /// - [textColor]: Optional override for the toast text color.
  /// - [seconds]: Time in seconds before the toast fades out (max: 3s).
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
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: SafeArea(
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
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                      decoration: TextDecoration.none, // Prevents underlining in debug mode
                      color: textColor ?? CoconutColors.onGray100(brightness),
                    ),
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
  /// - [context]: BuildContext used to insert the overlay.
  /// - [text]: Message text to display.
  /// - [isVisibleIcon]: Whether to show an info icon.
  /// - [seconds]: Toast duration in seconds (max: 5s).
  /// - [iconSize]: Size of the icon displayed (default: 16).
  /// - [iconRightPadding]: Padding between icon and text.
  /// - [textPadding]: Vertical padding around the text.
  /// - [textStyle]: Optional override for text style.
  /// - [backgroundColor]: Background color of the toast.
  /// - [borderColor]: Border color around the toast.
  /// - [textColor]: Text color override.
  /// - [iconPath]: Optional custom icon path.
  static void showToast({
    required BuildContext context,
    required String text,
    isVisibleIcon = false,
    int seconds = 3,
    double iconSize = 16,
    double iconRightPadding = 4,
    double textPadding = 3.5,
    TextStyle textStyle = CoconutTypography.body2_14,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    String? iconPath,
  }) {
    if (_isToastVisible) return;

    _isToastVisible = true;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        Brightness brightness = Theme.of(context).brightness;
        return Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: CoconutToastWidget(
                brightness: brightness,
                text: text,
                isVisibleIcon: isVisibleIcon,
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                textColor: textColor,
                iconColor: borderColor ?? CoconutColors.onGray100(brightness),
                iconPath: iconPath,
                iconSize: iconSize,
                iconRightPadding: iconRightPadding,
                textStyle: textStyle,
                textPadding: textPadding,
                onDismiss: () {
                  overlayEntry.remove();
                },
                duration: seconds <= 5 ? seconds : 5,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);
  }

  /// Displays a warning toast message at the top of the screen.
  ///
  /// - [context]: Context for displaying the overlay.
  /// - [text]: Warning message to display.
  /// - [seconds]: Toast duration in seconds (max: 5s).
  /// - [iconSize]: Icon size in pixels.
  /// - [iconRightPadding]: Space between icon and text.
  /// - [textPadding]: Padding above and below the text.
  /// - [backgroundColor]: Optional background override.
  /// - [borderColor]: Optional border override.
  /// - [textStyle]: Optional override for text style.
  static void showWarningToast({
    required BuildContext context,
    required String text,
    int seconds = 5,
    double iconSize = 16,
    double iconRightPadding = 4,
    double textPadding = 3.5,
    Color? backgroundColor,
    Color? borderColor,
    TextStyle textStyle = CoconutTypography.body2_14,
  }) {
    if (_isToastVisible) return;

    _isToastVisible = true;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        Brightness brightness = Theme.of(context).brightness;
        return Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: CoconutToastWidget(
                brightness: brightness,
                text: text,
                isVisibleIcon: true,
                backgroundColor: backgroundColor ?? warningYellowBackground,
                borderColor: borderColor ?? backgroundColor ?? warningYellowBackground,
                iconColor: warningYellow,
                iconPath: 'packages/coconut_design_system/assets/svg/triangle_warning.svg',
                iconSize: iconSize,
                iconRightPadding: iconRightPadding,
                textStyle: textStyle,
                textPadding: textPadding,
                onDismiss: () {
                  overlayEntry.remove();
                },
                duration: seconds <= 5 ? seconds : 5,
              ),
            ),
          ),
        );
      },
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
  final double iconSize;
  final double iconRightPadding;
  final double textPadding;
  final TextStyle textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color iconColor;
  final String? iconPath;

  /// Creates an instance of `CoconutToastWidget`.
  const CoconutToastWidget({
    super.key,
    required this.text,
    required this.brightness,
    required this.isVisibleIcon,
    required this.duration,
    required this.onDismiss,
    required this.iconColor,
    this.iconSize = 16,
    this.iconRightPadding = 4,
    this.textStyle = CoconutTypography.body2_14,
    this.textPadding = 3.5,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconPath,
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
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? CoconutColors.onGray900(widget.brightness),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.borderColor ??
                      widget.backgroundColor ??
                      CoconutColors.onGray900(widget.brightness),
                  width: 1,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter = TextPainter(
                    text: TextSpan(text: widget.text),
                    maxLines: null,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  final isMultiline = textPainter.computeLineMetrics().length > 1;

                  return Row(
                    crossAxisAlignment:
                        isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    children: [
                      if (widget.isVisibleIcon) ...{
                        Padding(
                          padding: EdgeInsets.only(
                            right: widget.iconRightPadding,
                            top: widget.textPadding,
                            bottom: widget.textPadding,
                          ),
                          child: SvgPicture.asset(
                            widget.iconPath ??
                                'packages/coconut_design_system/assets/svg/circle_info.svg',
                            height: widget.iconSize,
                            colorFilter: ColorFilter.mode(
                              widget.iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      } else ...{
                        SizedBox(
                          height: widget.iconSize,
                        ),
                      },
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: widget.textPadding),
                          child: Text(
                            widget.text,
                            style: widget.textStyle.copyWith(
                              decoration: TextDecoration.none, // Prevents underlining in debug mode
                              color: widget.textColor ?? CoconutColors.onGray100(widget.brightness),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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

    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.0))
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
