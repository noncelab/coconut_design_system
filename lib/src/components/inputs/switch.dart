import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';

class CoconutSwitch extends StatelessWidget {
  final bool isOn;
  final Brightness brightness;
  final Function(bool) onChanged;
  final Color? activeColor;
  final Color? thumbColor;
  const CoconutSwitch({
    super.key,
    required this.isOn,
    required this.brightness,
    required this.onChanged,
    this.activeColor,
    this.thumbColor,
  });

  @override
  Widget build(BuildContext context) {
    final active = activeColor == null
        ? isOn
            ? CoconutColors.onBlack(brightness)
            : CoconutColors.onGray300(brightness)
        : activeColor!;
    final thumb = thumbColor == null
        ? isOn
            ? CoconutColors.onWhite(brightness)
            : CoconutColors.onGray200(brightness)
        : thumbColor!;

    return CupertinoSwitch(
      value: isOn,
      activeColor: active,
      thumbColor: thumb,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
