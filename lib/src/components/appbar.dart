import 'dart:io';
import 'dart:ui';

import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A customizable AppBar component for the Coconut Design System.
///
/// Provides different styles of AppBars, including standard, home-style,
/// and AppBars with a "Next" button.
///
/// ### Example usage:
/// ```dart
/// Scaffold(
///   appBar: CoconutAppBar.build(
///     title: 'Example',
///     context: context,
///     hasRightIcon: false,
///     brightness: Brightness.light,
///   ),
///   body: Container(),
/// )
/// ```
class CoconutAppBar {
  /// Builds a standard `CoconutAppBar`.
  ///
  /// #### Parameters:
  /// - `title` (String): The title displayed in the center of the AppBar.
  /// - `context` (BuildContext): The current build context.
  /// - `hasRightIcon` (bool): Whether the AppBar has a right-side icon.
  /// - `brightness` (Brightness): Determines the theme (light or dark) for color adjustments.
  /// - `entireWidgetKey` (Key, optional): Key for the AppBar.
  /// - `faucetIconKey` (Key, optional): Key for the leading icon.
  /// - `backgroundColor` (Color, optional): Background color of the AppBar.
  /// - `isBottom` (bool, optional): Whether the AppBar is placed at the bottom. Default is `false`.
  /// - `isLeadingVisible` (bool, optional): Determines if the leading (back/close) icon should be shown. Default is `true`.
  /// - `showSubLabel` (bool, optional): Whether to display a sub-label below the title.
  /// - `onTitlePressed` (VoidCallback?, optional): Function triggered when the title is pressed.
  /// - `onBackPressed` (VoidCallback?, optional): Function triggered when the back button is pressed.
  /// - `subLabel` (Widget?, optional): A widget displayed below the title.
  /// - `actionButtonList` (List<Widget>?, optional): List of action buttons displayed on the right side of the AppBar.
  static AppBar build({
    required String title,
    required BuildContext context,
    required bool hasRightIcon,
    required Brightness brightness,
    Key? entireWidgetKey,
    Key? faucetIconKey,
    Color? backgroundColor,
    bool isBottom = false,
    bool isLeadingVisible = true,
    bool showSubLabel = false,
    VoidCallback? onTitlePressed,
    VoidCallback? onBackPressed,
    Widget? subLabel,
    List<Widget>? actionButtonList,
  }) {
    Widget? widget = Column(
      children: [
        if (onTitlePressed == null) ...{
          Text(
            title,
            style: CoconutTypography.heading4_18.setColor(
              CoconutColors.onPrimary(brightness),
            ),
          )
        } else ...{
          CoconutUnderlinedButton(
            text: title,
            onTap: onTitlePressed,
            padding: const EdgeInsets.all(0),
            textStyle: CoconutTypography.heading4_18,
            brightness: brightness,
          )
        },
        showSubLabel
            ? Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  subLabel ?? Container(),
                ],
              )
            : Container(
                width: 1,
              ),
      ],
    );
    return AppBar(
      key: entireWidgetKey,
      toolbarHeight: isBottom
          ? 50
          : Platform.isIOS
              ? 44
              : 56,
      title: widget,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: isLeadingVisible
          ? Navigator.canPop(context)
              ? Row(
                  children: [
                    CoconutLayout.spacing_200w,
                    IconButton(
                      icon: SvgPicture.asset(
                        isBottom
                            ? 'packages/coconut_design_system/assets/svg/close.svg'
                            : 'packages/coconut_design_system/assets/svg/arrow-back.svg',
                        colorFilter: ColorFilter.mode(
                            CoconutColors.onPrimary(brightness),
                            BlendMode.srcIn),
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        if (onBackPressed != null) {
                          onBackPressed();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                )
              : null
          : null,
      actions: [
        if (actionButtonList != null)
          for (Widget action in actionButtonList) ...[action],
        CoconutLayout.spacing_300w
      ],
      flexibleSpace: !isBottom && backgroundColor == null
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          : null,
    );
  }

  /// Builds a home-style `CoconutAppBar` for the main screen.
  ///
  /// Displays a leading icon, a title, and action buttons.
  ///
  /// #### Parameters:
  /// - `leadingSvgAsset` (SvgPicture): SVG asset displayed on the left.
  /// - `appTitle` (String): The title of the AppBar.
  /// - `actionButtonList` (List<Widget>): List of widgets displayed on the right.
  /// - `isLeadingSvgAssetVisible` (bool, optional): Whether to show the leading asset.
  /// - `automaticallyImplyLeading` (bool, optional): Whether the leading button is automatically shown.
  /// - `subLabel` (Widget?, optional): A sub-label displayed next to the title.
  static SliverAppBar buildHomeAppbar({
    required SvgPicture leadingSvgAsset,
    required String appTitle,
    required List<Widget> actionButtonList,
    bool isLeadingSvgAssetVisible = true,
    bool automaticallyImplyLeading = false,
    Widget? subLabel,
  }) {
    return SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      pinned: true,
      floating: false,
      expandedHeight: 84,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: CoconutLayout.defaultPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: Sizes.size30),
                child: Row(
                  children: [
                    if (isLeadingSvgAssetVisible)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: leadingSvgAsset,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          children: [
                            Text(
                              appTitle,
                              style: CoconutTypography.heading3_21_NumberBold,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            subLabel ?? Container(),
                          ],
                        ),
                      ),
                    ),
                    for (Widget action in actionButtonList) ...[action]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an AppBar with a "Next" button.
  ///
  /// Typically used for navigation-based flows where the user moves to the next step.
  ///
  /// #### Parameters:
  /// - `title` (String): Title displayed in the AppBar.
  /// - `context` (BuildContext): The current build context.
  /// - `onNextPressed` (VoidCallback): Function triggered when the next button is pressed.
  /// - `brightness` (Brightness): Defines light or dark mode.
  /// - `isActive` (bool, optional): Determines whether the next button is enabled.
  /// - `isBottom` (bool, optional): Whether the AppBar is at the bottom.
  /// - `usePrimaryActiveColor` (bool, optional): Whether to use the primary color when active.
  /// - `nextButtonTitle` (String, optional): Text of the next button.
  /// - `backgroundColor` (Color?, optional): Background color of the AppBar.
  /// - `onBackPressed` (VoidCallback?, optional): Callback for the back button.
  /// - `actionButtonList` (List<Widget>?, optional): Additional action buttons.
  static AppBar buildWithNext({
    required String title,
    required BuildContext context,
    required VoidCallback onNextPressed,
    required Brightness brightness,
    bool isActive = true,
    bool isBottom = false,
    bool usePrimaryActiveColor = false,
    String nextButtonTitle = '다음',
    Color? backgroundColor,
    VoidCallback? onBackPressed,
    List<Widget>? actionButtonList,
  }) {
    return AppBar(
      title: Text(
        title,
        style: CoconutTypography.heading4_18.setColor(
          CoconutColors.onPrimary(brightness),
        ),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      toolbarHeight: isBottom
          ? 50
          : Platform.isIOS
              ? 44
              : 56,
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: Navigator.canPop(context)
          ? Row(
              children: [
                CoconutLayout.spacing_200w,
                IconButton(
                  icon: SvgPicture.asset(
                    isBottom
                        ? 'packages/coconut_design_system/assets/svg/close.svg'
                        : 'packages/coconut_design_system/assets/svg/arrow-back.svg',
                    colorFilter: ColorFilter.mode(
                        CoconutColors.onPrimary(brightness), BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    if (onBackPressed != null) {
                      onBackPressed();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          : null,
      actions: [
        if (actionButtonList != null)
          for (Widget action in actionButtonList) ...[action],
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CoconutAppbarButton(
            isActive: isActive,
            usePrimaryActiveColor: usePrimaryActiveColor,
            isUseInClosableAppbar: isBottom,
            text: nextButtonTitle,
            onPressed: onNextPressed,
            brightness: brightness,
          ),
        ),
      ],
      flexibleSpace: !isBottom
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          : null,
    );
  }
}
