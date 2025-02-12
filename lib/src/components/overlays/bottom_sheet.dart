import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

class CoconutBottomSheet extends StatelessWidget {
  final Brightness brightness;
  final PreferredSizeWidget appBar;
  final Widget body;
  final double? bodyHeight;
  final Color? backgroundColor;
  const CoconutBottomSheet({
    super.key,
    required this.brightness,
    required this.appBar,
    required this.body,
    this.bodyHeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight * 0.9;
      double minHeight = constraints.maxHeight * 0.3;

      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? CoconutColors.onWhite(brightness),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minHeight: minHeight,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              appBar,
              if (bodyHeight != null) ...{
                SizedBox(
                  height: bodyHeight,
                  child: SingleChildScrollView(child: body),
                )
              } else ...{
                Expanded(child: SingleChildScrollView(child: body)),
              },
              const SizedBox(height: 54),
            ],
          ),
        ),
      );
    });
  }
}
