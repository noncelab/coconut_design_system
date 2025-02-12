import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoconutTagChip extends StatelessWidget {
  final String tag;
  final Color color;
  final TextStyle textStyle;
  final CoconutChipStatus status;
  final bool isRectangle;
  final EdgeInsets padding;
  final double borderWidth;
  final Function(String)? onTap;

  const CoconutTagChip({
    super.key,
    required this.tag,
    required this.color,
    this.textStyle = CoconutTypography.caption_10,
    this.status = CoconutChipStatus.none,
    this.isRectangle = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderWidth = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call(tag);
            }
          : null,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color
              .withOpacity(status == CoconutChipStatus.selected ? 0.3 : 0.18),
          borderRadius: BorderRadius.circular(
            isRectangle ? CoconutStyles.radius_50 : CoconutStyles.radius_500,
          ),
          border: Border.all(
              color: color.withOpacity(
                  status == CoconutChipStatus.unselected ? 0.15 : 1),
              width: borderWidth),
        ),
        child: Text(
          '#$tag',
          style: textStyle.copyWith(
            color: color
                .withOpacity(status == CoconutChipStatus.unselected ? 0.18 : 1),
            //fontWeight: status == CoconutChipStatus.selected ? FontWeight.w700 : null,
          ),
        ),
      ),
    );
  }
}

enum CoconutChipStatus {
  none,
  selected,
  unselected,
}
