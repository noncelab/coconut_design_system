import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoconutCheckbox extends StatelessWidget {
  final bool isSelected;
  final Brightness brightness;
  final Function(bool) onChanged;
  final double width;
  final Color? color;
  const CoconutCheckbox({
    super.key,
    required this.isSelected,
    required this.brightness,
    required this.onChanged,
    this.width = 20.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isSelected);
      },
      child: SvgPicture.asset(
        'packages/coconut_design_system/assets/svg/checkbox${isSelected ? '_selected' : ''}.svg',
        width: width,
        height: width,
        colorFilter: ColorFilter.mode(
          color ?? CoconutColors.onBlack(brightness),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
