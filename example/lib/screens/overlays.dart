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
  bool isClosableTooltipVisible = true;
  bool isLeftPlacementTooltipVisible = true;
  bool isRightPlacementTooltipVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
              final brightness =
                  isDarkMode ? Brightness.dark : Brightness.light;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CoconutLayout.defaultPadding,
                  vertical: 30,
                ),
                child: Center(
                  child: Column(
                    children: [
                      _titleBox('BottomSheet', brightness),
                      CoconutUnderlinedButton(
                        brightness: brightness,
                        text: 'Minimum',
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
                      CoconutLayout.spacing_600h,
                      _titleBox('Popup', brightness),
                      CoconutUnderlinedButton(
                        brightness: brightness,
                        text: 'Default',
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
                      CoconutLayout.spacing_600h,
                      _titleBox('Pulldown Menu', brightness),
                      CoconutPulldown(
                        title: pulldownButtons[selectedPulldownIndex],
                        brightness: brightness,
                        isOpen: isPulldownOpen,
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
                            selectedIndex: selectedPulldownIndex2,
                            isVisibleCheck: false,
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
                      CoconutLayout.spacing_600h,
                      _buildTooltipExampleList(brightness),
                    ],
                  ),
                ),
              );
            },
          ),
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

  Widget _buildTooltipExampleList(Brightness brightness) {
    return Column(
      children: [
        _titleBox('Fixed Tooltip', brightness),
        CoconutToolTip(
          richText: RichText(
            text: TextSpan(
              text: 'This is a type of fixed tooltip.',
              style: CoconutTypography.body2_14.setColor(
                CoconutColors.black,
              ),
            ),
          ),
          tooltipType: CoconutTooltipType.fixed,
          brightness: brightness,
        ),
        CoconutLayout.spacing_300h,
        CoconutToolTip(
          richText: RichText(
            text: TextSpan(
              text: 'This is a type of fixed tooltip.(Error state)',
              style: CoconutTypography.body2_14.setColor(
                CoconutColors.black,
              ),
            ),
          ),
          tooltipType: CoconutTooltipType.fixed,
          tooltipState: CoconutTooltipState.error,
          brightness: brightness,
        ),
        CoconutLayout.spacing_300h,
        CoconutToolTip(
          richText: RichText(
            text: TextSpan(
              text: 'This is a type of fixed tooltip.(Warning state)',
              style: CoconutTypography.body2_14.setColor(
                CoconutColors.black,
              ),
            ),
          ),
          tooltipType: CoconutTooltipType.fixed,
          tooltipState: CoconutTooltipState.warning,
          brightness: brightness,
        ),
        CoconutLayout.spacing_300h,
        CoconutToolTip(
          richText: RichText(
            text: TextSpan(
              text: 'This is a type of fixed tooltip.(Normal state)',
              style: CoconutTypography.body2_14.setColor(
                CoconutColors.black,
              ),
            ),
          ),
          tooltipType: CoconutTooltipType.fixed,
          tooltipState: CoconutTooltipState.normal,
          brightness: brightness,
        ),
        CoconutLayout.spacing_300h,
        CoconutToolTip(
          richText: RichText(
            text: TextSpan(
              text: 'This is a type of fixed tooltip.(Success state)',
              style: CoconutTypography.body2_14.setColor(
                CoconutColors.black,
              ),
            ),
          ),
          tooltipType: CoconutTooltipType.fixed,
          tooltipState: CoconutTooltipState.success,
          brightness: brightness,
        ),
        CoconutLayout.spacing_600h,
        _titleBox('Fixed(closable) Tooltip', brightness),
        if (isClosableTooltipVisible) ...{
          CoconutToolTip(
            richText: RichText(
              text: TextSpan(
                text: 'The title is placed here.\n',
                style: CoconutTypography.body2_14_Bold.setColor(
                  CoconutColors.onPrimary(brightness),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'The description is placed here.',
                    style: CoconutTypography.body2_14.setColor(
                      CoconutColors.onPrimary(brightness),
                    ),
                  )
                ],
              ),
            ),
            tooltipType: CoconutTooltipType.fixedClosable,
            brightness: brightness,
            onTapRemove: () {
              setState(() {
                isClosableTooltipVisible = false;
              });
            },
          ),
        } else ...{
          CoconutButton(
            brightness: brightness,
            onPressed: () {
              setState(() {
                isClosableTooltipVisible = true;
              });
            },
            text: 'Show closable tooltip',
          )
        },
        CoconutLayout.spacing_600h,
        _titleBox('Placement Tooltip', brightness),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CoconutButton(
              brightness: brightness,
              onPressed: () async {
                setState(() {
                  if (isRightPlacementTooltipVisible) {
                    isRightPlacementTooltipVisible = false;
                  }
                });

                await Future.delayed(const Duration(milliseconds: 1000));

                if (!mounted) return;
                setState(() {
                  isLeftPlacementTooltipVisible = true;
                });
              },
              text: 'Show left bubble clipper tooltip',
              textStyle: CoconutTypography.body3_12,
              width: 150,
            ),
            CoconutButton(
              brightness: brightness,
              onPressed: () async {
                setState(() {
                  if (isLeftPlacementTooltipVisible) {
                    isLeftPlacementTooltipVisible = false;
                  }
                });

                await Future.delayed(const Duration(milliseconds: 1000));

                if (!mounted) return;
                setState(() {
                  isRightPlacementTooltipVisible = true;
                });
              },
              text: 'Show right bubble clipper tooltip',
              textStyle: CoconutTypography.body3_12,
              width: 150,
            ),
          ],
        ),
        Stack(
          children: [
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a left bubble clipper tooltip.',
                  style: CoconutTypography.body2_14_Bold.setColor(
                    CoconutColors.surface(brightness),
                  ),
                ),
              ),
              isPlacementTooltipVisible: isLeftPlacementTooltipVisible,
              width: MediaQuery.sizeOf(context).width,
              tooltipType: CoconutTooltipType.placement,
              isBubbleClipperSideLeft: true,
              brightness: brightness,
              onTapRemove: () {
                setState(() {
                  isLeftPlacementTooltipVisible = false;
                });
              },
            ),
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a right bubble clipper tooltip.',
                  style: CoconutTypography.body2_14_Bold.setColor(
                    CoconutColors.surface(brightness),
                  ),
                ),
              ),
              isPlacementTooltipVisible: isRightPlacementTooltipVisible,
              width: MediaQuery.sizeOf(context).width,
              tooltipType: CoconutTooltipType.placement,
              isBubbleClipperSideLeft: false,
              brightness: brightness,
              onTapRemove: () {
                setState(() {
                  isRightPlacementTooltipVisible = false;
                });
              },
            ),
          ],
        ),
        CoconutLayout.spacing_1500h,
      ],
    );
  }
}
