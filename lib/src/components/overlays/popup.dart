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
///     brightness: Brightness.light,
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
class CoconutPopup extends StatelessWidget {
  /// The brightness mode (light or dark theme).
  final Brightness brightness;

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

  /// The padding around the popup content.
  final EdgeInsets? padding;

  /// Creates an instance of `CoconutPopup`.
  const CoconutPopup(
      {super.key,
      required this.brightness,
      required this.title,
      required this.description,
      required this.onTapRight,
      this.leftButtonText = '취소',
      this.rightButtonText = '확인',
      this.onTapLeft,
      this.backgroundColor,
      this.titleColor,
      this.descriptionColor,
      this.leftButtonColor,
      this.rightButtonColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: padding ??
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 20),
        decoration: BoxDecoration(
          color: backgroundColor ?? CoconutColors.onWhite(brightness),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Title Section
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title,
                  style: CoconutTypography.body1_16_Bold.setColor(
                    titleColor ?? CoconutColors.onGray900(brightness),
                  ),
                ),
              ),

              /// Description Section
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(bottom: 12),
                constraints: const BoxConstraints(minHeight: 66),
                child: Text(
                  description,
                  style: CoconutTypography.body1_16.setColor(
                    descriptionColor ?? CoconutColors.onGray900(brightness),
                  ),
                ),
              ),

              /// Action Buttons (Left & Right)
              Row(
                children: [
                  if (onTapLeft != null) ...{
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onTapLeft?.call();
                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Text(
                            leftButtonText,
                            style: CoconutTypography.body1_16.setColor(
                              leftButtonColor ??
                                  CoconutColors.onGray900(brightness),
                            ),
                          ),
                        ),
                      ),
                    ),
                  },
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onTapRight.call();
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          rightButtonText,
                          style: CoconutTypography.body1_16_Bold.setColor(
                            rightButtonColor ??
                                CoconutColors.onGray900(brightness),
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
    );
  }
}
