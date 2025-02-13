import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

class CoconutPopup extends StatelessWidget {
  final Brightness brightness;
  final String title;
  final Function onTapRight;
  final String description;
  final Function? onTapLeft;
  final String leftButtonText;
  final String rightButtonText;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? leftButtonColor;
  final Color? rightButtonColor;
  final EdgeInsets? padding;
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
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title,
                  style: CoconutTypography.body1_16_Bold.setColor(
                    titleColor ?? CoconutColors.onGray900(brightness),
                  ),
                ),
              ),
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
