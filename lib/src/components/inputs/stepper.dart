import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoconutStepper extends StatefulWidget {
  final int maxCount;
  final Brightness brightness;
  final double fontSize;
  final double iconSize;
  final double buttonSize;
  final double countWidth;
  final Function(int) onCount;

  const CoconutStepper({
    super.key,
    required this.maxCount,
    required this.brightness,
    required this.onCount,
    this.fontSize = 24.0,
    this.iconSize = 20.0,
    this.buttonSize = 32.0,
    this.countWidth = 80.0,
  });

  @override
  State<CoconutStepper> createState() => _CoconutStepperState();
}

class _CoconutStepperState extends State<CoconutStepper> {
  int _currentCount = 1;

  void _updateCount(int change) {
    int newCount = _currentCount + change;
    if (newCount >= 1 && newCount <= widget.maxCount) {
      setState(() {
        _currentCount = newCount;
      });
      widget.onCount(_currentCount);
    }
  }

  Widget _buildStepperButton(
      {required String asset,
      required bool isDisabled,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: widget.buttonSize,
        height: widget.buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: CoconutColors.onGray300(widget.brightness),
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'packages/coconut_design_system/assets/svg/$asset.svg',
            width: widget.iconSize,
            height: widget.iconSize,
            colorFilter: ColorFilter.mode(
              isDisabled
                  ? CoconutColors.onGray300(widget.brightness)
                  : CoconutColors.onBlack(widget.brightness),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStepperButton(
          asset: 'stepper_minus',
          isDisabled: _currentCount == 1,
          onTap: () => _updateCount(-1),
        ),
        Container(
          width: widget.countWidth,
          alignment: Alignment.center,
          child: Text(
            '$_currentCount',
            style: CoconutTypography.heading3_21_Number.copyWith(
              color: CoconutColors.onBlack(widget.brightness),
              fontSize: widget.fontSize,
            ),
          ),
        ),
        _buildStepperButton(
          asset: 'stepper_plus',
          isDisabled: _currentCount == widget.maxCount,
          onTap: () => _updateCount(1),
        ),
      ],
    );
  }
}
