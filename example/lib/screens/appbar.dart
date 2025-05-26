import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/main.dart';
import 'package:example/provider/appbar_provider.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppbarScreen extends StatelessWidget {
  const AppbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppbarProvider, ThemeProvider>(
      builder: (context, appbarProvider, themeProvider, child) {
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
        final brightness = isDarkMode ? Brightness.dark : Brightness.light;
        if (appbarProvider.appbarType == AppbarType.frosted) {
          return _buildFrostedAppBar(context, brightness, appbarProvider, themeProvider);
        }
        if (appbarProvider.appbarType == AppbarType.topNavi) {
          return _buildTopNaviAppBar(context, brightness, appbarProvider, themeProvider);
        }
        return Scaffold(
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              CoconutAppBar.buildHomeAppbar(
                context: context,
                leadingSvgAsset: SvgPicture.network(
                  'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/alphachannel.svg',
                  width: 24,
                ),
                isLeadingSvgAssetVisible: appbarProvider.isAppIconVisible,
                automaticallyImplyLeading: appbarProvider.isLeadingVisible,
                appTitle: 'Home',
                subLabel: appbarProvider.isSubLabelVisible ? _buildSubLabel() : null,
                actionButtonList: [
                  IconButton(
                    icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                  if (appbarProvider.isActionButtonVisible)
                    IconButton(
                      onPressed: () {
                        showSnackBar(context, 'Action Button Clicked!', brightness);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: Sizes.size36,
                      ),
                    ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: CoconutLayout.defaultPadding,
                    right: CoconutLayout.defaultPadding,
                    top: Sizes.size20,
                    bottom: Sizes.size40,
                  ),
                  child: Column(
                    children: [
                      _buildRadioOptions(appbarProvider, brightness),
                      CoconutLayout.spacing_600h,
                      SizedBox(
                        width: double.infinity,
                        child: _buildOptionControlBox(
                          isHomeSt: appbarProvider.appbarType == AppbarType.home,
                          isAppIconVisible: appbarProvider.isAppIconVisible,
                          isLeadingVisible: appbarProvider.isLeadingVisible,
                          isClosable: appbarProvider.isClosable,
                          isSubLabelVisible: appbarProvider.isSubLabelVisible,
                          isActionButtonVisible: appbarProvider.isActionButtonVisible,
                          toggleAppIconVisible: appbarProvider.toggleAppIconVisible,
                          toggleLeadingVisible: appbarProvider.toggleLeadingVisible,
                          toggleClosable: appbarProvider.toggleClosable,
                          toggleSubLabelVisible: appbarProvider.toggleSubLabelVisible,
                          toggleActionButtonVisible: appbarProvider.toggleActionButtonVisible,
                          toggleTitlePressable: appbarProvider.toggleTitlePressable,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionControlBox({
    required bool isHomeSt,
    required bool isLeadingVisible,
    required bool isClosable,
    required bool isSubLabelVisible,
    required bool isActionButtonVisible,
    required Function toggleAppIconVisible,
    required Function toggleTitlePressable,
    required Function toggleLeadingVisible,
    required Function toggleClosable,
    required Function toggleSubLabelVisible,
    required Function toggleActionButtonVisible,
    bool isTitlePressable = false,
    bool isAppIconVisible = false,
    bool isNextButtonVisible = false,
    Function? toggleNextButtonVisible,
  }) {
    debugPrint('isNextButtonVisible : $isNextButtonVisible');
    Brightness brightness = CoconutTheme.brightness(); // Get the current brightness
    return Container(
      padding: const EdgeInsets.all(Sizes.size16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          CoconutStyles.radius_200,
        ),
        color: CoconutColors.onPrimary(brightness).withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Appbar Control Box',
            style: CoconutTypography.body1_16_Bold,
          ),
          Column(
            children: [
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                enabled: isHomeSt,
                title: Text(
                  'Show Appbar Icon (Only for home style)',
                  style: CoconutTypography.body2_14.setColor(
                    isHomeSt
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This displays a App Icon on the left side of the app bar.',
                  style: CoconutTypography.body3_12.setColor(
                    isHomeSt
                        ? CoconutColors.onPrimary(brightness).withOpacity(0.5)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                  ),
                ),
                value: isAppIconVisible,
                onChanged: (bool? value) {
                  toggleAppIconVisible();
                },
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                enabled: isHomeSt,
                title: Text(
                  'Show Action Button (Only for home style)',
                  style: CoconutTypography.body2_14.setColor(
                    isHomeSt
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This displays button widgets on the right side of the app bar.',
                  style: CoconutTypography.body3_12.setColor(
                    CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                value: isActionButtonVisible,
                onChanged: (bool? value) {
                  toggleActionButtonVisible();
                },
                checkColor: CoconutColors.black,
              ),
              CheckboxListTile(
                enabled: !isHomeSt,
                title: Text(
                  'Show next button (Only for top navi style)',
                  style: CoconutTypography.body2_14.setColor(
                    !isHomeSt
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This displays a next button on the right side of the app bar.',
                  style: CoconutTypography.body3_12.setColor(
                    !isHomeSt
                        ? CoconutColors.onPrimary(brightness).withOpacity(0.5)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                  ),
                ),
                value: isNextButtonVisible,
                onChanged: (bool? value) {
                  toggleNextButtonVisible!();
                },
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                title: Text(
                  'Use a close icon for the leading icon',
                  style: CoconutTypography.body2_14.setColor(
                    !isHomeSt && isLeadingVisible
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                value: isClosable,
                onChanged: (bool? value) {
                  toggleClosable();
                },
                enabled: !isHomeSt && isLeadingVisible,
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                enabled: !isHomeSt && !isNextButtonVisible,
                title: Text(
                  'Allow the title to be pressed (Only for top navi style)',
                  style: CoconutTypography.body2_14.setColor(
                    !isHomeSt && !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This makes the title clickable to enable interaction.',
                  style: CoconutTypography.body3_12.setColor(
                    !isHomeSt && !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness).withOpacity(0.5)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                  ),
                ),
                value: isTitlePressable,
                onChanged: (bool? value) {
                  toggleTitlePressable();
                },
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                title: Text(
                  'Show Leading Icon',
                  style: CoconutTypography.body2_14.setColor(
                    !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This displays a back button or a close button on the left side of the app bar.',
                  style: CoconutTypography.body3_12.setColor(
                    !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness).withOpacity(0.5)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                  ),
                ),
                enabled: !isNextButtonVisible,
                value: isLeadingVisible,
                onChanged: (bool? value) {
                  toggleLeadingVisible();
                },
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                enabled: !isNextButtonVisible,
                title: Text(
                  'Show SubLabel',
                  style: CoconutTypography.body2_14.setColor(
                    !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  'This displays a sublabel widget to the right of the app bar title.',
                  style: CoconutTypography.body3_12.setColor(
                    !isNextButtonVisible
                        ? CoconutColors.onPrimary(brightness).withOpacity(0.5)
                        : CoconutColors.onPrimary(brightness).withOpacity(0.2),
                  ),
                ),
                value: isSubLabelVisible,
                onChanged: (bool? value) {
                  toggleSubLabelVisible();
                },
                checkColor: CoconutColors.black,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFrostedOptionControlBox({
    required bool isClosable,
    required bool isTitleFadable,
    required Function toggleClosable,
    required Function toggleTitleFadable,
  }) {
    Brightness brightness = CoconutTheme.brightness(); // Get the current brightness
    return Container(
      padding: const EdgeInsets.all(Sizes.size16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          CoconutStyles.radius_200,
        ),
        color: CoconutColors.onPrimary(brightness).withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Frosted Appbar Control Box',
            style: CoconutTypography.body1_16_Bold,
          ),
          Column(
            children: [
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                title: Text(
                  'Use a close icon for the leading icon',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onPrimary(brightness),
                  ),
                ),
                value: isClosable,
                onChanged: (bool? value) {
                  toggleClosable();
                },
                enabled: true,
                checkColor: CoconutColors.black,
              ),
              CoconutLayout.spacing_200h,
              CheckboxListTile(
                title: Text(
                  'The title remains hidden unless the user scrolls at least 15 pixels.',
                  style: CoconutTypography.body2_14.setColor(
                    CoconutColors.onPrimary(brightness),
                  ),
                ),
                value: isTitleFadable,
                onChanged: (bool? value) {
                  toggleTitleFadable();
                },
                enabled: true,
                checkColor: CoconutColors.black,
              ),
            ],
          ),
          CoconutLayout.spacing_2500h,
        ],
      ),
    );
  }

  Widget _buildRadioOptions(AppbarProvider appbarProvider, Brightness brightness) {
    final List<Map<String, AppbarType>> options = [
      {'Home Style': AppbarType.home},
      {'TopNavi Style': AppbarType.topNavi},
      {'Frosted Style': AppbarType.frosted},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: options.map((option) {
        final String title = option.keys.first;
        final AppbarType value = option.values.first;

        return RadioListTile<AppbarType>(
          title: Text(title),
          value: value,
          groupValue: appbarProvider.appbarType,
          onChanged: (newValue) {
            if (newValue != null && newValue != appbarProvider.appbarType) {
              appbarProvider.toggleAppbar(newValue);
            }
          },
          activeColor: CoconutColors.onPrimary(brightness),
        );
      }).toList(),
    );
  }

  Widget _buildSubLabel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: CoconutColors.cyan,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        'SubLabel',
        style: CoconutTypography.body3_12_Bold.setColor(CoconutColors.white),
      ),
    );
  }

  Widget _buildFrostedAppBar(BuildContext context, Brightness brightness,
      AppbarProvider appbarProvider, ThemeProvider themeProvider) {
    ScrollController controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true, // essential
      appBar: CoconutFrostedAppBar(
        title: 'Frosted',
        context: context,
        onBackPressed: () {
          Navigator.pop(context);
        },
        isBottom: appbarProvider.isClosable,
        actionButtonList: [
          IconButton(
            icon: Icon(brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
        hasTitleOpacity: appbarProvider.hasTitleOpacity,
        controller: controller,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller,
        child: Container(
          padding: EdgeInsets.only(
            left: CoconutLayout.defaultPadding,
            right: CoconutLayout.defaultPadding,
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 30,
            bottom: Sizes.size40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildRadioOptions(appbarProvider, brightness),
              CoconutLayout.spacing_600h,
              SizedBox(
                width: double.infinity,
                child: _buildFrostedOptionControlBox(
                  isClosable: appbarProvider.isClosable,
                  isTitleFadable: appbarProvider.hasTitleOpacity,
                  toggleClosable: appbarProvider.toggleClosable,
                  toggleTitleFadable: appbarProvider.toggleTitleOpacity,
                ),
              ),
              CoconutLayout.spacing_2500h,
              CoconutLayout.spacing_2500h,
              CoconutLayout.spacing_2500h,
              CoconutLayout.spacing_2500h,
              CoconutLayout.spacing_2500h,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopNaviAppBar(BuildContext context, Brightness brightness,
      AppbarProvider appbarProvider, ThemeProvider themeProvider) {
    if (appbarProvider.isNextButtonVisible) {
      return Scaffold(
        backgroundColor: CoconutColors.surface(brightness),
        appBar: CoconutAppBar.buildWithNext(
          title: 'Top Navi',
          context: context,
          onBackPressed: () {
            Navigator.pop(context);
          },
          nextButtonTitle: '다음',
          isBottom: appbarProvider.isClosable,
          onNextPressed: () {
            showSnackBar(context, 'Next button clicked', brightness);
          },
          actionButtonList: [
            IconButton(
              icon: Icon(brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
              left: CoconutLayout.defaultPadding,
              right: CoconutLayout.defaultPadding,
              top: Sizes.size20,
              bottom: Sizes.size40,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildRadioOptions(appbarProvider, brightness),
                CoconutLayout.spacing_600h,
                SizedBox(
                  width: double.infinity,
                  child: _buildOptionControlBox(
                    isHomeSt: appbarProvider.appbarType == AppbarType.home,
                    isAppIconVisible: appbarProvider.isAppIconVisible,
                    isTitlePressable: appbarProvider.isTitlePressable,
                    isLeadingVisible: appbarProvider.isLeadingVisible,
                    isClosable: appbarProvider.isClosable,
                    isSubLabelVisible: appbarProvider.isSubLabelVisible,
                    isNextButtonVisible: appbarProvider.isNextButtonVisible,
                    isActionButtonVisible: appbarProvider.isActionButtonVisible,
                    toggleAppIconVisible: appbarProvider.toggleAppIconVisible,
                    toggleTitlePressable: appbarProvider.toggleTitlePressable,
                    toggleLeadingVisible: appbarProvider.toggleLeadingVisible,
                    toggleClosable: appbarProvider.toggleClosable,
                    toggleSubLabelVisible: appbarProvider.toggleSubLabelVisible,
                    toggleActionButtonVisible: appbarProvider.toggleActionButtonVisible,
                    toggleNextButtonVisible: appbarProvider.toggleNextButtonVisible,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: CoconutColors.surface(brightness),
      appBar: CoconutAppBar.build(
        title: 'Top Navi',
        context: context,
        onTitlePressed: appbarProvider.isTitlePressable
            ? () => showSnackBar(context, 'Title clicked', brightness)
            : null,
        onBackPressed: () {
          Navigator.pop(context);
        },
        actionButtonList: [
          IconButton(
            icon: Icon(brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
        showSubLabel: appbarProvider.isSubLabelVisible,
        subLabel: _buildSubLabel(),
        isLeadingVisible: appbarProvider.isLeadingVisible,
        isBottom: appbarProvider.isClosable,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(
            left: CoconutLayout.defaultPadding,
            right: CoconutLayout.defaultPadding,
            top: Sizes.size20,
            bottom: Sizes.size40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildRadioOptions(appbarProvider, brightness),
              CoconutLayout.spacing_600h,
              SizedBox(
                width: double.infinity,
                child: _buildOptionControlBox(
                  isHomeSt: appbarProvider.appbarType == AppbarType.home,
                  isAppIconVisible: appbarProvider.isAppIconVisible,
                  isTitlePressable: appbarProvider.isTitlePressable,
                  isLeadingVisible: appbarProvider.isLeadingVisible,
                  isNextButtonVisible: appbarProvider.isNextButtonVisible,
                  isClosable: appbarProvider.isClosable,
                  isSubLabelVisible: appbarProvider.isSubLabelVisible,
                  isActionButtonVisible: appbarProvider.isActionButtonVisible,
                  toggleAppIconVisible: appbarProvider.toggleAppIconVisible,
                  toggleTitlePressable: appbarProvider.toggleTitlePressable,
                  toggleLeadingVisible: appbarProvider.toggleLeadingVisible,
                  toggleClosable: appbarProvider.toggleClosable,
                  toggleSubLabelVisible: appbarProvider.toggleSubLabelVisible,
                  toggleActionButtonVisible: appbarProvider.toggleActionButtonVisible,
                  toggleNextButtonVisible: appbarProvider.toggleNextButtonVisible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
