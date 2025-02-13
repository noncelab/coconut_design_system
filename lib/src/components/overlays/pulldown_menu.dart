import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoconutPulldownMenu extends StatelessWidget {
  final Brightness brightness;
  final List<String> buttons;
  final int selectedIndex;
  final Function(int) onTap;
  final EdgeInsets margin;
  final double iconSize;
  final bool isVisibleCheck;
  final int? dividerIndex;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? dividerColor;
  final Color? dividerPointColor;
  final Color? iconColor;
  final Color? splashColor;
  final Color? shadowColor;
  const CoconutPulldownMenu({
    super.key,
    required this.brightness,
    required this.buttons,
    required this.selectedIndex,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.iconSize = 24,
    this.isVisibleCheck = true,
    this.dividerIndex,
    this.textColor,
    this.backgroundColor,
    this.dividerColor,
    this.dividerPointColor,
    this.iconColor,
    this.splashColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: const BoxConstraints(minWidth: 124),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? CoconutColors.onGray300(brightness),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(buttons.length, (index) {
            return _button(buttons[index], index);
          }),
        ),
      ),
    );
  }

  BorderRadius? _getBorderRadius(int index, int length) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    } else if (index == length - 1) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return null; // 중간 요소는 borderRadius 없음
  }

  Widget _button(String title, int index) {
    return Column(
      children: [
        Material(
          color: backgroundColor ?? CoconutColors.onGray100(brightness),
          shape: RoundedRectangleBorder(
            borderRadius:
                _getBorderRadius(index, buttons.length) ?? BorderRadius.zero,
          ),
          child: InkWell(
            onTap: () {
              onTap.call(index);
            },
            borderRadius: _getBorderRadius(index, buttons.length),
            splashColor: splashColor ?? CoconutColors.onGray200(brightness),
            highlightColor: Colors.transparent,
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    title,
                    style: CoconutTypography.body2_14.copyWith(
                      color: textColor ?? CoconutColors.onBlack(brightness),
                    ),
                  ),
                  const Spacer(),
                  if (isVisibleCheck && selectedIndex == index) ...{
                    SvgPicture.asset(
                      'packages/coconut_design_system/assets/svg/pulldown_check.svg',
                      width: iconSize,
                      height: iconSize,
                      colorFilter: ColorFilter.mode(
                        iconColor ?? CoconutColors.onBlack(brightness),
                        BlendMode.srcIn,
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        ),
        if (index < buttons.length - 1) ...{
          Container(
            height: index + 1 == dividerIndex ? 3 : 2,
            color: index + 1 == dividerIndex
                ? dividerPointColor ?? CoconutColors.onGray350(brightness)
                : dividerColor ?? CoconutColors.onGray200(brightness),
          ),
        }
      ],
    );
  }
}
