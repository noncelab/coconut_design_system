import 'dart:io';
import 'dart:ui';

import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
///     brightness: Brightness.light,
///   ),
///   body: Container(),
/// )
/// ```
class CoconutAppBar {
  /// Builds a standard `CoconutAppBar` for navigation and actions.
  ///
  /// This AppBar displays a title, optional sub-label, leading (back/close) button,
  /// and action buttons. It supports both top and bottom placements and provides a
  /// blurred background effect when no explicit background color is set.
  ///
  /// ### Example Usage:
  /// ```dart
  /// AppBar customAppBar = CoconutAppBar.build(
  ///   context: context,
  ///   title: "Settings",
  ///   isLeadingVisible: true,
  ///   onBackPressed: () => Navigator.pop(context),
  ///   actionButtonList: [
  ///     IconButton(
  ///       icon: Icon(Icons.settings),
  ///       onPressed: () => print("Settings clicked"),
  ///     ),
  ///   ],
  ///   showSubLabel: true,
  ///   subLabel: Text("Beta"),
  ///   backgroundColor: Colors.transparent,
  /// );
  /// ```
  ///
  /// #### Parameters:
  /// - `title` (String): The main title displayed in the center of the AppBar.
  /// - `context` (BuildContext): The current build context.
  /// - `titlePadding` (EdgeInsets): The Padding of the main title.
  /// - `entireWidgetKey` (Key?, optional): A unique key for the AppBar.
  /// - `faucetIconKey` (Key?, optional): A key for the leading icon.
  /// - `backgroundColor` (Color?, optional): The background color of the AppBar.
  /// - `isBottom` (bool, optional): Whether the AppBar is positioned at the bottom. Default is `false`.
  /// - `isLeadingVisible` (bool, optional): Whether the back/close button should be displayed. Default is `true`.
  /// - `showSubLabel` (bool, optional): Whether to display a sub-label below the title. Default is `false`.
  /// - `isBackButton` (bool, optional): Whether to force a back button instead of a close icon in `isBottom` mode.
  /// - `height` (double?, optional): Custom toolbar height. Defaults to `50` for bottom AppBars, `44` for iOS, and `56` for Android.
  /// - `onTitlePressed` (VoidCallback?, optional): Function triggered when the title is tapped.
  /// - `onBackPressed` (VoidCallback?, optional): Function triggered when the back button is tapped.
  /// - `subLabel` (Widget?, optional): A widget displayed below the title, such as a version indicator.
  /// - `actionButtonList` (List<Widget>?, optional): A list of action buttons displayed on the right side.
  static AppBar build({
    required String title,
    required BuildContext context,
    EdgeInsets titlePadding = const EdgeInsets.all(0),
    Key? entireWidgetKey,
    Key? faucetIconKey,
    Color? backgroundColor,
    bool isBottom = false,
    bool isLeadingVisible = true,
    bool showSubLabel = false,
    bool isBackButton = false,
    double? height,
    VoidCallback? onTitlePressed,
    VoidCallback? onBackPressed,
    Widget? subLabel,
    List<Widget>? actionButtonList,
  }) {
    Brightness brightness = Theme.of(context).brightness;
    Widget? widget = Column(
      children: [
        if (onTitlePressed == null) ...{
          Padding(
            padding: titlePadding,
            child: Text(
              title,
              style: CoconutTypography.heading4_18.setColor(
                CoconutColors.onPrimary(brightness),
              ),
            ),
          )
        } else ...{
          CoconutUnderlinedButton(
            text: title,
            onTap: onTitlePressed,
            padding: titlePadding,
            textStyle: CoconutTypography.heading4_18,
            brightness: brightness,
          ),
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
      systemOverlayStyle: Theme.of(context).brightness == Brightness.light
          ? const SystemUiOverlayStyle(
              statusBarColor: CoconutColors.white, // 상태바 배경
              statusBarBrightness: Brightness.light, // 상태바 아이콘 (iOS)
              statusBarIconBrightness: Brightness.dark, // 상태바 아이콘 (Android)
              systemNavigationBarColor: CoconutColors.white, // 하단 네비게이션바 배경
              systemNavigationBarIconBrightness:
                  Brightness.dark, // 하단 네비게이션바 아이콘
            )
          : SystemUiOverlayStyle.light,
      key: entireWidgetKey,
      toolbarHeight: height ??
          (isBottom
              ? 50
              : Platform.isIOS
                  ? 44
                  : 56),
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
                        isBottom && !isBackButton
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

  /// Builds a `CoconutAppBar` designed for the home screen.
  ///
  /// This AppBar features a leading icon, a title, optional sub-labels,
  /// customizable action buttons, and an optional bottom widget.
  /// It provides a transparent background with a blur effect,
  /// making it suitable for a modern home screen layout.
  ///
  /// The `bottomWidget` is attached at the bottom of the AppBar and supports
  /// animations when its height changes dynamically.
  ///
  /// ### Example Usage:
  /// ```dart
  /// SliverAppBar homeAppBar = CoconutAppBar.buildHomeAppbar(
  ///   context: context,
  ///   leadingSvgAsset: SvgPicture.asset('assets/svg/home_icon.svg'),
  ///   appTitle: "Home",
  ///   actionButtonList: [
  ///     IconButton(
  ///       icon: Icon(Icons.settings),
  ///       onPressed: () => print("Settings clicked"),
  ///     ),
  ///   ],
  ///   isLeadingSvgAssetVisible: true,
  ///   expandedHeight: 100,
  ///   subLabel: Text("Beta"),
  ///   bottomWidget: PreferredSize(
  ///     preferredSize: Size.fromHeight(30),
  ///     child: Container(
  ///       color: Colors.red,
  ///       height: 30,
  ///       child: Center(child: Text("Network Alert")),
  ///     ),
  ///   ),
  ///   appBarInnerMargin: EdgeInsets.only(top: 30), // Adjust top margin
  /// );
  /// ```
  ///
  /// #### Parameters:
  /// - `context` (BuildContext): The current build context.
  /// - `leadingSvgAsset` (SvgPicture): The SVG asset displayed on the left side.
  /// - `appTitle` (String): The main title displayed in the AppBar.
  /// - `actionButtonList` (List<Widget>): A list of action buttons displayed on the right.
  /// - `isLeadingSvgAssetVisible` (bool, optional): Whether to display the leading icon. Default is `true`.
  /// - `automaticallyImplyLeading` (bool, optional): If `true`, Flutter determines whether to show a back button automatically. Default is `false`.
  /// - `expandedHeight` (double?, optional): The height of the expanded AppBar, excluding the `bottomWidget`. Default is `84`.
  /// - `subLabel` (Widget?, optional): An optional widget displayed next to the title.
  /// - `bottomWidget` (PreferredSize?, optional): A widget displayed below the AppBar, typically used for alerts or additional navigation.
  ///   - If this widget has an `AnimatedContainer`, its height changes will animate correctly.
  /// - `appBarInnerMargin` (EdgeInsets?, optional): Adjusts the margin inside the AppBar.
  static SliverAppBar buildHomeAppbar({
    required BuildContext context,
    required SvgPicture leadingSvgAsset,
    required String appTitle,
    required List<Widget> actionButtonList,
    bool isLeadingSvgAssetVisible = true,
    bool automaticallyImplyLeading = false,
    double? expandedHeight,
    Widget? subLabel,
    PreferredSize? bottomWidget,
    EdgeInsets? appBarInnerMargin,
  }) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      pinned: true,
      floating: false,
      expandedHeight: 84 + (bottomWidget?.preferredSize.height ?? 0),
      backgroundColor: Colors.transparent,
      bottom: bottomWidget,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: CoconutLayout.defaultPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: appBarInnerMargin,
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

  /// Builds an AppBar with a "Next" button for navigation-based workflows.
  ///
  /// This AppBar is typically used in multi-step flows where the user moves to the next screen.
  /// It supports customization options such as title, background color, back button handling,
  /// and additional action buttons.
  ///
  /// ### Example Usage:
  /// ```dart
  /// AppBar appBar = CoconutAppBar.buildWithNext(
  ///   title: "Setup Profile",
  ///   context: context,
  ///   onNextPressed: () {
  ///     print("Next button clicked!");
  ///   },
  ///   isActive: true,
  ///   usePrimaryActiveColor: true,
  ///   nextButtonTitle: "Continue",
  ///   onBackPressed: () {
  ///     Navigator.pop(context);
  ///   },
  /// );
  /// ```
  ///
  /// #### Parameters:
  /// - `title` (String): The title displayed in the AppBar.
  /// - `context` (BuildContext): The current build context.
  /// - `onNextPressed` (VoidCallback): Callback function triggered when the "Next" button is pressed.
  /// - `isActive` (bool, optional): Determines whether the "Next" button is enabled. Default is `true`.
  /// - `isBottom` (bool, optional): Indicates whether the AppBar is positioned at the bottom. Default is `false`.
  /// - `usePrimaryActiveColor` (bool, optional): If `true`, the "Next" button uses the primary color when active. Default is `false`.
  /// - `nextButtonTitle` (String, optional): The text displayed on the "Next" button. Default is `'다음'`.
  /// - `height` (double?, optional): Custom height for the AppBar.
  /// - `backgroundColor` (Color?, optional): Background color of the AppBar. Default is `transparent`.
  /// - `onBackPressed` (VoidCallback?, optional): Callback function for the back button. Defaults to `Navigator.pop()`.
  /// - `actionButtonList` (List<Widget>?, optional): Additional action buttons displayed in the AppBar.
  /// - `padding` (EdgeInsets?, optional): Custom padding for the AppBar.
  static AppBar buildWithNext({
    required String title,
    required BuildContext context,
    required VoidCallback onNextPressed,
    bool isActive = true,
    bool isBottom = false,
    bool usePrimaryActiveColor = false,
    String nextButtonTitle = '다음',
    double? height,
    Color? backgroundColor,
    VoidCallback? onBackPressed,
    List<Widget>? actionButtonList,
    EdgeInsets? padding,
  }) {
    Brightness brightness = Theme.of(context).brightness;
    return AppBar(
      systemOverlayStyle: Theme.of(context).brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          title,
          style: CoconutTypography.heading4_18.setColor(
            CoconutColors.onPrimary(brightness),
          ),
        ),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      toolbarHeight: height ??
          (isBottom
              ? 50
              : Platform.isIOS
                  ? 44
                  : 56),
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

/// A custom AppBar with a frosted glass effect and dynamic title visibility.
///
/// This AppBar dynamically changes its background color and title opacity
/// based on the scroll position.
///
/// It supports:
/// - A blurred background effect when scrolled.
/// - Dynamic title opacity based on scroll position.
/// - Custom action buttons.
/// - An optional back button with a custom callback.
class CoconutFrostedAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  /// The title of the AppBar.
  final String title;

  /// The style of the title text. Defaults to CoconutTypography.heading4_18.
  final TextStyle? titleTextStyle;

  /// The context in which the AppBar is used.
  final BuildContext context;

  /// Whether the AppBar is used at the bottom of a screen.
  final bool isBottom;

  /// Determines if the title has opacity effects when scrolling.
  final bool hasTitleOpacity;

  /// The background color of the AppBar. Defaults to transparent.
  final Color? backgroundColor;

  /// Callback function triggered when the back button is pressed.
  final VoidCallback? onBackPressed;

  /// A list of action buttons displayed in the AppBar.
  final List<Widget>? actionButtonList;

  /// The ScrollController used to track scroll position.
  final ScrollController? controller;

  const CoconutFrostedAppBar({
    super.key,
    required this.title,
    required this.context,
    this.isBottom = false,
    this.hasTitleOpacity = true,
    this.titleTextStyle,
    this.backgroundColor,
    this.onBackPressed,
    this.actionButtonList,
    this.controller,
  });
  @override
  Size get preferredSize => Size.fromHeight(isBottom ? 50 : kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _CoconutFrostedAppBarState();
}

class _CoconutFrostedAppBarState extends State<CoconutFrostedAppBar> {
  ScrollController? controller;
  bool _isScrollOverTitleHeight = false;
  late bool _isTitleVisible;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();
    _isTitleVisible = widget.hasTitleOpacity ? false : true;
    _attachScrollListener();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachScrollListener();
  }

  @override
  void didUpdateWidget(covariant CoconutFrostedAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_scrollListener);
      controller = widget.controller ?? ScrollController();
      _attachScrollListener();
    }

    if (widget.hasTitleOpacity != oldWidget.hasTitleOpacity) {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            _isTitleVisible = !widget.hasTitleOpacity;
          });
        }
      });
    }
  }

  /// Attaches the scroll listener to track the scroll position.
  void _attachScrollListener() {
    if (controller != null) {
      controller!.removeListener(_scrollListener);
      controller!.addListener(_scrollListener);
    }
  }

  /// Handles scroll position updates and adjusts title visibility.
  void _scrollListener() {
    if (!mounted || controller == null) return;

    final scrollPosition = controller!.position.pixels;

    bool newScrollOverTitleHeight = scrollPosition >= 30;
    bool newTitleVisible = widget.hasTitleOpacity ? scrollPosition >= 15 : true;

    if (newScrollOverTitleHeight != _isScrollOverTitleHeight ||
        newTitleVisible != _isTitleVisible) {
      setState(() {
        _isScrollOverTitleHeight = newScrollOverTitleHeight;
        _isTitleVisible =
            widget.hasTitleOpacity ? newTitleVisible : _isTitleVisible;
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller?.dispose();
    } else {
      controller?.removeListener(_scrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color backgroundColor = _getBackgroundColor(brightness);

    return AppBar(
      systemOverlayStyle: Theme.of(context).brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isTitleVisible ? 1 : 0,
        child: Text(
          widget.title,
          style: widget.titleTextStyle ??
              CoconutTypography.heading4_18.setColor(
                CoconutColors.onPrimary(brightness),
              ),
        ),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      leading: Navigator.canPop(context)
          ? Row(
              children: [
                CoconutLayout.spacing_200w,
                IconButton(
                  icon: SvgPicture.asset(
                    widget.isBottom
                        ? 'packages/coconut_design_system/assets/svg/close.svg'
                        : 'packages/coconut_design_system/assets/svg/arrow-back.svg',
                    colorFilter: ColorFilter.mode(
                        CoconutColors.onPrimary(brightness), BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    if (widget.onBackPressed != null) {
                      widget.onBackPressed!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          : null,
      actions: [
        if (widget.actionButtonList != null) ...widget.actionButtonList!,
        const SizedBox(width: 16),
      ],
      flexibleSpace: _isScrollOverTitleHeight
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: backgroundColor,
                ),
              ),
            )
          : null,
    );
  }

  /// Determines the background color based on scroll position and theme brightness.
  Color _getBackgroundColor(Brightness brightness) {
    if (widget.backgroundColor == null) {
      return _isScrollOverTitleHeight
          ? CoconutColors.surface(brightness).withOpacity(0.06)
          : Colors.transparent;
    }
    return _isScrollOverTitleHeight
        ? widget.backgroundColor!.withOpacity(0.06)
        : Colors.transparent;
  }
}
