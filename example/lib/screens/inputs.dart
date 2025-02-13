import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/main.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  CoconutChipStatus chipStatus = CoconutChipStatus.unselected;

  bool isCheckbox1Selected = false;
  bool isCheckbox2Selected = false;
  bool isSwitch1On = false;
  bool isSwitch2On = false;
  bool isPulldownOpen = false;

  final focusNode1 = FocusNode();
  final controller1 = TextEditingController();
  String controller1Text = '';
  bool isVisibleErrorText = false;
  int maxLength = 10;
  final focusNode2 = FocusNode();
  final controller2 = TextEditingController();
  final focusNode3 = FocusNode();
  final controller3 = TextEditingController();
  String controller3Text = '';
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final brightness = isDarkMode ? Brightness.dark : Brightness.light;

            return Padding(
              padding: const EdgeInsets.all(CoconutLayout.defaultPadding),
              child: Center(
                child: Column(
                  children: [
                    _titleBox('Chip', brightness),
                    Wrap(
                      spacing: 10,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CoconutChip(
                          color: CoconutColors.primary,
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.black,
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onGray150(brightness),
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onBlack(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: Colors.transparent,
                          borderColor: CoconutColors.onBlack(brightness),
                          child: Text(
                            'TEXT3',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onBlack(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          isRectangle: true,
                          child: Text(
                            'TESTNET',
                            style: CoconutTypography.caption_10.copyWith(
                              color: CoconutColors.white,
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onGray150(brightness),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '2024.11.08',
                                style:
                                    CoconutTypography.body2_14_Number.copyWith(
                                  color: CoconutColors.onBlack(brightness),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 12,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: CoconutColors.onGray600(brightness),
                              ),
                              Text(
                                '18:50',
                                style:
                                    CoconutTypography.body2_14_Number.copyWith(
                                  color: CoconutColors.onBlack(brightness),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            showSnackBar(
                                context, '2024.11.08 | 18:50', brightness);
                          },
                        ),
                      ],
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Tag Chip', brightness),
                    Wrap(
                      spacing: 10,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const CoconutTagChip(
                          tag: 'TEXT',
                          color: CoconutColors.red,
                          isRectangle: true,
                        ),
                        CoconutTagChip(
                          tag: 'TEXT',
                          color: CoconutColors.red,
                          status: chipStatus,
                          onTap: (value) {
                            if (chipStatus == CoconutChipStatus.unselected) {
                              chipStatus = CoconutChipStatus.selected;
                            } else {
                              chipStatus = CoconutChipStatus.unselected;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Checkbox', brightness),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CoconutCheckbox(
                          isSelected: isCheckbox1Selected,
                          brightness: brightness,
                          onChanged: (value) {
                            isCheckbox1Selected = value;
                            setState(() {});
                          },
                        ),
                        const SizedBox(width: 10),
                        CoconutCheckbox(
                          isSelected: isCheckbox2Selected,
                          brightness: brightness,
                          color: CoconutColors.primary,
                          onChanged: (value) {
                            isCheckbox2Selected = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Switch', brightness),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CoconutSwitch(
                          isOn: isSwitch1On,
                          brightness: brightness,
                          onChanged: (value) {
                            isSwitch1On = value;
                            setState(() {});
                          },
                        ),
                        const SizedBox(width: 10),
                        CoconutSwitch(
                          isOn: isSwitch2On,
                          brightness: brightness,
                          activeColor: CoconutColors.primary,
                          thumbColor: CoconutColors.white,
                          onChanged: (value) {
                            isSwitch2On = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Stepper', brightness),
                    CoconutStepper(
                      maxCount: 3,
                      brightness: brightness,
                      onCount: (count) {},
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Pulldown', brightness),
                    CoconutPulldown(
                      title: 'TEXT',
                      brightness: brightness,
                      isOpen: isPulldownOpen,
                      onChanged: (value) {
                        isPulldownOpen = value;
                        setState(() {});
                      },
                    ),
                    CoconutLayout.spacing_600h,
                    _titleBox('Textfield', brightness),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CoconutTextField(
                          controller: controller1,
                          focusNode: focusNode1,
                          brightness: brightness,
                          descriptionText: 'Description text',
                          placeholderText: 'Placeholder text',
                          errorText: 'Error text',
                          isVisibleErrorText: isVisibleErrorText,
                          maxLength: maxLength,
                          prefix: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              '#',
                              style: CoconutTypography.body2_14.copyWith(
                                color: controller1Text.isEmpty
                                    ? CoconutColors.onGray300(brightness)
                                    : CoconutColors.onBlack(brightness),
                              ),
                            ),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              controller1.text = '';
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 13),
                              child: SvgPicture.asset(
                                'assets/svg/textfield_clear.svg',
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  controller1Text.isEmpty
                                      ? CoconutColors.onGray300(brightness)
                                      : controller1Text.runes.length == 10
                                          ? CoconutColors.red
                                          : CoconutColors.onBlack(brightness),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            controller1Text = text;
                            isVisibleErrorText = text.runes.length == maxLength;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 10),
                        CoconutTextField(
                          controller: controller2,
                          focusNode: focusNode2,
                          brightness: brightness,
                          maxLines: 5,
                          descriptionText: 'Description text',
                          placeholderText: 'Placeholder text',
                          onChanged: (text) {},
                        ),
                        const SizedBox(height: 10),
                        CoconutTextField(
                          controller: controller3,
                          focusNode: focusNode3,
                          brightness: brightness,
                          placeholderText: 'Placeholder text',
                          maxLength: 16,
                          obscureText: obscureText,
                          suffix: GestureDetector(
                            onTap: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 13),
                              child: SvgPicture.asset(
                                'assets/svg/textfield_view.svg',
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  controller3Text.isEmpty
                                      ? CoconutColors.onGray300(brightness)
                                      : CoconutColors.onBlack(brightness),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            controller3Text = text;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _titleBox(String title, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: CoconutTypography.body1_16_Bold.setColor(
            CoconutColors.onPrimary(brightness),
          ),
        ),
        CoconutLayout.spacing_300h,
      ],
    );
  }
}
