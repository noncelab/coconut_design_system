import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverlaysScreen extends StatefulWidget {
  const OverlaysScreen({super.key});

  @override
  State<OverlaysScreen> createState() => _OverlaysScreenState();
}

class _OverlaysScreenState extends State<OverlaysScreen> {
  List<String> pulldownButtons = [
    'Pulldown1',
    'Pulldown2',
    'Pulldown3',
    'Pulldown4',
    'Pulldown5'
  ];
  int selectedPulldownIndex = 0;
  bool isPulldownOpen = false;

  List<String> pulldownButtons2 = [
    'Pulldown1',
    'Pulldown2',
    'Pulldown3',
    'Pulldown4',
    'Pulldown5'
  ];
  int selectedPulldownIndex2 = 0;
  bool isPulldownOpen2 = false;

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
                    _box(
                      'BottomSheet',
                      brightness,
                      [
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Minimum',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => CoconutBottomSheet(
                                brightness: brightness,
                                appBar: CoconutAppBar.build(
                                  title: 'Minimum',
                                  context: context,
                                  brightness: brightness,
                                  hasRightIcon: false,
                                  isBottom: true,
                                ),
                                body: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      color: CoconutColors.red,
                                    ),
                                    Container(
                                      height: 20,
                                      color: CoconutColors.yellow,
                                    ),
                                    Container(
                                      height: 20,
                                      color: CoconutColors.green,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Maximum',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => CoconutBottomSheet(
                                brightness: brightness,
                                appBar: CoconutAppBar.buildWithNext(
                                  title: 'Maximum',
                                  context: context,
                                  brightness: brightness,
                                  nextButtonTitle: '완료',
                                  usePrimaryActiveColor: true,
                                  onNextPressed: () {
                                    Navigator.pop(context);
                                  },
                                  isBottom: true,
                                ),
                                body: Column(
                                  children: [
                                    Container(
                                      height: 500,
                                      color: CoconutColors.red,
                                    ),
                                    Container(
                                      height: 500,
                                      color: CoconutColors.yellow,
                                    ),
                                    Container(
                                      height: 500,
                                      color: CoconutColors.green,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Fixed',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => CoconutBottomSheet(
                                brightness: brightness,
                                appBar: CoconutAppBar.buildWithNext(
                                  title: 'Fixed',
                                  context: context,
                                  brightness: brightness,
                                  nextButtonTitle: '완료',
                                  onNextPressed: () {
                                    Navigator.pop(context);
                                  },
                                  isBottom: true,
                                ),
                                bodyHeight: 300,
                                body: Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      color: CoconutColors.red,
                                    ),
                                    Container(
                                      height: 300,
                                      color: CoconutColors.yellow,
                                    ),
                                    Container(
                                      height: 300,
                                      color: CoconutColors.green,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    _box(
                      'Popup',
                      brightness,
                      [
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Default',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CoconutPopup(
                                  brightness: brightness,
                                  title: 'Title',
                                  description: 'description',
                                  onTapRight: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Primary',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CoconutPopup(
                                  brightness: brightness,
                                  title: 'Title',
                                  description: 'description',
                                  rightButtonColor:
                                      CoconutColors.onAccent(brightness),
                                  rightButtonText: '완료',
                                  leftButtonText: '닫기',
                                  onTapLeft: () {
                                    Navigator.pop(context);
                                  },
                                  onTapRight: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Long description',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CoconutPopup(
                                  brightness: brightness,
                                  title: 'Title',
                                  description:
                                      'Long description description description description description description description description description description description description description description description description description description',
                                  onTapLeft: () {
                                    Navigator.pop(context);
                                  },
                                  onTapRight: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    _box(
                      'Pulldown Menu',
                      brightness,
                      [
                        CoconutPulldown(
                          title: pulldownButtons[selectedPulldownIndex],
                          brightness: brightness,
                          isOpen: isPulldownOpen,
                          fontSize: 12,
                          onChanged: (value) {
                            isPulldownOpen = value;
                            isPulldownOpen2 = false;
                            setState(() {});
                          },
                        ),
                        Visibility(
                          visible: isPulldownOpen,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: CoconutPulldownMenu(
                              brightness: brightness,
                              buttons: pulldownButtons,
                              selectedIndex: selectedPulldownIndex,
                              onTap: (index) {
                                selectedPulldownIndex = index;
                                isPulldownOpen = false;
                                isPulldownOpen2 = false;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        CoconutPulldown(
                          title: pulldownButtons2[selectedPulldownIndex2],
                          brightness: brightness,
                          isOpen: isPulldownOpen2,
                          onChanged: (value) {
                            isPulldownOpen = false;
                            isPulldownOpen2 = value;
                            setState(() {});
                          },
                        ),
                        Visibility(
                          visible: isPulldownOpen2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: CoconutPulldownMenu(
                              brightness: brightness,
                              buttons: pulldownButtons2,
                              dividerIndex: 3,
                              onTap: (index) {
                                selectedPulldownIndex2 = index;
                                isPulldownOpen = false;
                                isPulldownOpen2 = false;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    _box(
                      'Toast',
                      brightness,
                      [
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Default',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showToast(
                              brightness: brightness,
                              context: context,
                              text: 'Default toast',
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Default Long Text',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showToast(
                              brightness: brightness,
                              context: context,
                              text:
                                  'Long text text text text text text text text text text text text text',
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Icon',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showToast(
                              brightness: brightness,
                              context: context,
                              isVisibleIcon: true,
                              text: 'Icon toast',
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Icon Long Text',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showToast(
                              brightness: brightness,
                              context: context,
                              isVisibleIcon: true,
                              text:
                                  'Long text text text text text text text text text text text text text',
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Bottom',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showBottomToast(
                              brightness: brightness,
                              context: context,
                              text: 'Bottom toast',
                            );
                          },
                        ),
                        CoconutUnderlinedButton(
                          brightness: brightness,
                          text: 'Bottom Long Text',
                          textStyle: CoconutTypography.caption_10,
                          onTap: () {
                            CoconutToast.showBottomToast(
                              brightness: brightness,
                              context: context,
                              seconds: 3,
                              text:
                                  'Long text text text text text text text text text text text text text',
                            );
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

  Widget _box(String title, Brightness brightness, List<Widget> widgets) {
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
        for (Widget widget in widgets) ...{widget},
        CoconutLayout.spacing_600h,
      ],
    );
  }
}
