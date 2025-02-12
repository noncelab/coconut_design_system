import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoconutChip extends StatelessWidget {
  final Color color;
  final Widget child;
  final bool isRectangle;
  final EdgeInsets padding;
  final double borderWidth;
  final Color? borderColor;
  final Function? onTap;

  const CoconutChip({
    super.key,
    required this.color,
    required this.child,
    this.isRectangle = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderWidth = 1.0,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              isRectangle ? CoconutStyles.radius_50 : CoconutStyles.radius_500,
            ),
            border: Border.all(color: borderColor ?? color, width: borderWidth),
          ),
          child: child),
    );
  }
}
