import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable popup dialog with title, description, and action buttons.
///
/// The `CoconutPopup` provides a modal dialog with a structured layout:
/// - A **title section** for the main heading.
/// - A **description section** for additional details.
/// - Two **action buttons** for user interaction.
///
/// Example Usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => CoconutPopup(
///     title: "Alert",
///     description: "Are you sure you want to proceed?",
///     onTapRight: () {
///       print("Confirmed!");
///     },
///     onTapLeft: () {
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
class CoconutPopup extends StatefulWidget {
  /// The title of the popup dialog.
  final String title;

  /// The callback function when the right button is tapped (usually "Confirm").
  final Function onTapRight;

  /// The description text displayed below the title.
  final String description;

  /// The callback function when the left button is tapped (optional, usually "Cancel").
  final Function? onTapLeft;

  /// The text for the left button (default: "취소" / "Cancel").
  final String leftButtonText;

  /// The text for the right button (default: "확인" / "Confirm").
  final String rightButtonText;

  /// Whether the title text should be centered (default: true).
  final bool centerTitle;

  /// Whether the description text should be centered (default: true).
  final bool centerDescription;

  /// The background color of the popup.
  final Color? backgroundColor;

  /// The color of the title text.
  final Color? titleColor;

  /// The color of the description text.
  final Color? descriptionColor;

  /// The color of the left button text.
  final Color? leftButtonColor;

  /// The color of the right button text.
  final Color? rightButtonColor;

  /// The TextStyle of the title text.
  final TextStyle? titleTextStyle;

  /// The TextStyle of the description text.
  final TextStyle? descriptionTextStyle;

  /// The TextStyle of the left button text.
  final TextStyle? leftButtonTextStyle;

  /// The TextStyle of the right button text.
  final TextStyle? rightButtonTextStyle;

  /// The padding around the title content.
  final EdgeInsets? titlePadding;

  /// The padding around the description content.
  final EdgeInsets? descriptionPadding;

  /// The padding around the whole dialog.
  final EdgeInsets? insetPadding;

  /// Creates an instance of `CoconutPopup`.
  const CoconutPopup({
    super.key,
    required this.title,
    required this.description,
    required this.onTapRight,
    this.leftButtonText = '취소',
    this.rightButtonText = '확인',
    this.centerTitle = true,
    this.centerDescription = true,
    this.onTapLeft,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
    this.leftButtonColor,
    this.rightButtonColor,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.leftButtonTextStyle,
    this.rightButtonTextStyle,
    this.titlePadding,
    this.descriptionPadding,
    this.insetPadding,
  });

  @override
  State<CoconutPopup> createState() => _CoconutPopupState();
}

class _CoconutPopupState extends State<CoconutPopup> {
  bool _isLeftButtonPressing = false;
  bool _isRightButtonPressing = false;
  @override
  Widget build(BuildContext context) {
    Brightness brightness = CoconutTheme.brightness();

    return Dialog(
      insetPadding: widget.insetPadding,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? CoconutColors.onWhite(brightness),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Title Section
                Container(
                  padding: widget.titlePadding ?? const EdgeInsets.only(top: 24, bottom: 12),
                  child: Text(
                    widget.title,
                    style: widget.titleTextStyle?.setColor(widget.titleColor ?? CoconutColors.onGray900(brightness)) ??
                        CoconutTypography.body1_16_Bold.setColor(
                          widget.titleColor ?? CoconutColors.onGray900(brightness),
                        ),
                    textAlign: widget.centerTitle ? TextAlign.center : null,
                  ),
                ),

                /// Description Section
                Container(
                  alignment: Alignment.topCenter,
                  padding: widget.descriptionPadding ?? const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                  constraints: const BoxConstraints(minHeight: 66),
                  child: Text(
                    widget.description,
                    textAlign: widget.centerDescription ? TextAlign.center : null,
                    style: widget.descriptionTextStyle
                            ?.setColor(widget.descriptionColor ?? CoconutColors.onGray800(brightness)) ??
                        CoconutTypography.body1_16.setColor(
                          widget.descriptionColor ?? CoconutColors.onGray800(brightness),
                        ),
                  ),
                ),

                /// Action Buttons (Left & Right)
                Row(
                  children: [
                    if (widget.onTapLeft != null) ...{
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLeftButtonPressing = false;
                            });
                            widget.onTapLeft?.call();
                          },
                          onTapCancel: () {
                            setState(() {
                              _isLeftButtonPressing = false;
                            });
                          },
                          onTapDown: (details) {
                            setState(() {
                              _isLeftButtonPressing = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            color: _isLeftButtonPressing
                                ? CoconutColors.onPrimary(brightness).withOpacity(0.2)
                                : Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(
                              widget.leftButtonText,
                              style: widget.leftButtonTextStyle
                                      ?.setColor(widget.leftButtonColor ?? CoconutColors.onGray900(brightness)) ??
                                  CoconutTypography.body2_14_Bold.setColor(
                                    widget.leftButtonColor ?? CoconutColors.onGray900(brightness),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    },
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRightButtonPressing = false;
                          });
                          widget.onTapRight.call();
                        },
                        onTapCancel: () {
                          setState(() {
                            _isRightButtonPressing = false;
                          });
                        },
                        onTapDown: (details) {
                          setState(() {
                            _isRightButtonPressing = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          color: _isRightButtonPressing
                              ? CoconutColors.onPrimary(brightness).withOpacity(0.2)
                              : Colors.transparent,
                          alignment: Alignment.center,
                          child: Text(
                            widget.rightButtonText,
                            style: widget.rightButtonTextStyle
                                    ?.setColor(widget.rightButtonColor ?? CoconutColors.onGray900(brightness)) ??
                                CoconutTypography.body2_14_Bold.setColor(
                                  widget.rightButtonColor ?? CoconutColors.onGray900(brightness),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
