import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OverlaysScreen extends StatefulWidget {
  const OverlaysScreen({super.key});

  @override
  State<OverlaysScreen> createState() => _OverlaysScreenState();
}

class _OverlaysScreenState extends State<OverlaysScreen> {
  List<String> pulldownButtons = ['Pulldown1', 'Pulldown2', 'Pulldown3', 'Pulldown4', 'Pulldown5'];
  int selectedPulldownIndex = 0;
  bool isPulldownOpen = false;

  List<String> pulldownButtons2 = ['Pulldown1', 'Pulldown2', 'Pulldown3', 'Pulldown4', 'Pulldown5'];
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
              final brightness = isDarkMode ? Brightness.dark : Brightness.light;

              return Padding(
                padding: const EdgeInsets.only(
                  left: CoconutLayout.defaultPadding,
                  right: CoconutLayout.defaultPadding,
                  top: Sizes.size30,
                  bottom: Sizes.size60,
                ),
                child: Center(
                  child: Column(
                    children: [
                      _buildTooltipExampleList(brightness),
                      _buildBottomSheetExampleList(brightness, context),
                      _buildPopupExampleList(brightness, context),
                      _buildPulldownMenuExampleList(brightness),
                      _buildToastExampleList(brightness, context),
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

  Widget _buildBottomSheetExampleList(Brightness brightness, BuildContext context) {
    return _box(
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
                useIntrinsicHeight: true,
                appBar: CoconutAppBar.build(
                  title: 'Minimum',
                  context: context,
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
                useIntrinsicHeight: true,
                appBar: CoconutAppBar.buildWithNext(
                  title: 'Maximum',
                  context: context,
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
                heightRatio: 0.5,
                appBar: CoconutAppBar.buildWithNext(
                  title: 'Fixed',
                  context: context,
                  nextButtonTitle: '완료',
                  onNextPressed: () {
                    Navigator.pop(context);
                  },
                  isBottom: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
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
              ),
            );
          },
        ),
        CoconutUnderlinedButton(
          brightness: brightness,
          text: 'Full',
          textStyle: CoconutTypography.caption_10,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => CoconutBottomSheet(
                useIntrinsicHeight: true,
                appBar: CoconutAppBar.build(
                  title: 'Full',
                  context: context,
                  isBottom: true,
                ),
                heightRatio: 1,
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
    );
  }

  Widget _buildPopupExampleList(Brightness brightness, BuildContext context) {
    return _box(
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
                  title: 'Title',
                  description: 'description',
                  rightButtonColor: CoconutColors.onAccent(brightness),
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
    );
  }

  Widget _buildPulldownMenuExampleList(Brightness brightness) {
    return _box(
      'Pulldown Menu',
      brightness,
      [
        CoconutPulldown(
          title: pulldownButtons[selectedPulldownIndex],
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
              buttons: pulldownButtons2,
              dividerHeight: 3,
              dividerColor: CoconutColors.white,
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
    );
  }

  Widget _buildToastExampleList(Brightness brightness, BuildContext context) {
    return _box(
      'Toast',
      brightness,
      [
        CoconutUnderlinedButton(
          brightness: brightness,
          text: 'Default',
          textStyle: CoconutTypography.caption_10,
          onTap: () {
            CoconutToast.showToast(
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
              context: context,
              text: 'Long text text text text text text text text text text text text text',
            );
          },
        ),
        CoconutUnderlinedButton(
          brightness: brightness,
          text: 'Icon',
          textStyle: CoconutTypography.caption_10,
          onTap: () {
            CoconutToast.showToast(
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
              context: context,
              isVisibleIcon: true,
              text: 'Long text text text text text text text text text text text text text',
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
              text: 'Long text text text text text text text text text text text text text',
            );
          },
        ),
      ],
    );
  }

  Widget _buildTooltipExampleList(Brightness brightness) {
    return Column(
      children: [
        _box(
          'Fixed Tooltip',
          brightness,
          [
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip.',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onBlack(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
            ),
            CoconutLayout.spacing_300h,
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip.(Error state)',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onBlack(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
              tooltipState: CoconutTooltipState.error,
            ),
            CoconutLayout.spacing_300h,
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip.(Warning state)',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onBlack(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
              tooltipState: CoconutTooltipState.warning,
            ),
            CoconutLayout.spacing_300h,
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip.(Normal state)',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onBlack(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
              tooltipState: CoconutTooltipState.normal,
            ),
            CoconutLayout.spacing_300h,
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip.(Success state)',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onBlack(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
              tooltipState: CoconutTooltipState.success,
            ),
            CoconutLayout.spacing_300h,
            CoconutToolTip(
              richText: RichText(
                text: TextSpan(
                  text: 'This is a type of fixed tooltip with custom icon and color.',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onWhite(brightness),
                  ),
                ),
              ),
              tooltipType: CoconutTooltipType.fixed,
              backgroundColor: CoconutColors.gray900,
              borderColor: CoconutColors.gray900,
              icon: SvgPicture.asset(
                'packages/coconut_design_system/assets/svg/info_circle.svg',
                colorFilter: const ColorFilter.mode(
                  CoconutColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            CoconutLayout.spacing_600h,
          ],
        ),
        _box(
          'Fixed(closable) Tooltip',
          brightness,
          [
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
          ],
        ),
        _box(
          'Placement Tooltip',
          brightness,
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CoconutButton(
                  buttonType: CoconutButtonType.outlined,
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
                  buttonType: CoconutButtonType.outlined,
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
              backgroundColor: CoconutColors.cyan,
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
              backgroundColor: CoconutColors.cyan,
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
