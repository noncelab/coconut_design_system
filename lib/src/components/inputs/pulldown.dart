import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoconutPulldown extends StatelessWidget {
  final String title;
  final Brightness brightness;
  final bool isOpen;
  final Function(bool) onChanged;
  final double iconSize;
  final Color? iconColor;
  final Color? fontColor;
  const CoconutPulldown({
    super.key,
    required this.title,
    required this.brightness,
    required this.isOpen,
    required this.onChanged,
    this.iconSize = 24,
    this.iconColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isOpen);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8),
            alignment: Alignment.center,
            child: Text(
              title,
              style: CoconutTypography.caption_10.copyWith(
                color: fontColor ?? CoconutColors.onBlack(brightness),
              ),
            ),
          ),
          SvgPicture.asset(
            'packages/coconut_design_system/assets/svg/pulldown_${isOpen ? 'open' : 'close'}.svg',
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              iconColor ?? CoconutColors.onBlack(brightness),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
