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
    bool hasBackDropFilter = false,
    double? height,
    VoidCallback? onTitlePressed,
    VoidCallback? onBackPressed,
    Widget? subLabel,
    List<Widget>? actionButtonList,
  }) {
    Brightness brightness = CoconutTheme.brightness();
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
      systemOverlayStyle: Platform.isIOS
          ? (brightness == Brightness.light
              ? const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark, // iOS → 검정 텍스트
                )
              : const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // iOS → 흰색 텍스트
                ))
          : (brightness == Brightness.light
              ? const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark, // Android → 검정 텍스트
                )
              : const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // Android → 흰색 텍스트
                )),
      key: entireWidgetKey,
      toolbarHeight: height ?? (isBottom ? 60 : 56),
      title: widget,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: isLeadingVisible
          ? Navigator.canPop(context)
              ? Column(
                  children: [
                    CoconutLayout.spacing_100h,
                    Row(
                      children: [
                        CoconutLayout.spacing_100w,
                        IconButton(
                          icon: SvgPicture.asset(
                            isBottom && !isBackButton
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
          : Container(),
    );
  }

  /// Builds a `CoconutAppBar` designed for the home screen.
  ///
  /// This SliverAppBar includes:
  /// - A leading SVG icon (optional)
  /// - A title with optional sub-label
  /// - A customizable list of action buttons (with default icon size of 40)
  /// - An optional bottom widget (e.g., for alerts or tabs)
  ///
  /// The `bottomWidget` is attached at the bottom of the AppBar and supports
  /// animations when its visibility toggles. When visible, it appears with a
  /// vertical margin (`kMarginHeight`) above it to separate it visually from
  /// the main content.
  ///
  /// The AppBar uses a transparent background with a blur effect, making it
  /// suitable for modern UIs with a floating feel.
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
  ///   subLabel: Text("Beta"),
  ///   bottomWidget: PreferredSize(
  ///     preferredSize: Size.fromHeight(30),
  ///     child: Container(
  ///       color: Colors.red,
  ///       height: 30,
  ///       child: Center(child: Text("Network Alert")),
  ///     ),
  ///   ),
  ///   isBottomWidgetVisible: true,
  /// );
  /// ```
  ///
  /// #### Parameters:
  /// - `context` (BuildContext): Build context.
  /// - `leadingSvgAsset` (Widget): SVG asset displayed on the left side.(e.g., app icon)
  /// - `appTitle` (String): The title string
  /// - `actionButtonList` (List<Widget>): A list of action buttons displayed on the right.
  /// - `isLeadingSvgAssetVisible` (bool, optional): Whether to display the leading icon. Default is `true`.
  /// - `automaticallyImplyLeading` (bool, optional): If `true`, Flutter determines whether to show a back button automatically. Default is `false`.
  /// - `subLabel` (Widget?, optional): An optional widget displayed next to the title.
  /// - `appBarHeight` (double, optional): The height of the AppBar. widget is visible and animated. Default is `false`.
  /// - `iconSize` (double, optional): The size of the icons in the app bar, applied to both the leading icon and action buttons (if they are `IconButton`s).
  ///   Defaults to `40.0`. This ensures visual consistency in icon sizing and is passed to the `IconButton.iconSize` parameter rather than the `Icon` widget itself.
  ///
  /// This widget is intended for use in `CustomScrollView`'s sliver list.
  static SliverAppBar buildHomeAppbar({
    required BuildContext context,
    required Widget leadingSvgAsset,
    required String appTitle,
    required List<Widget> actionButtonList,
    bool isLeadingSvgAssetVisible = true,
    bool automaticallyImplyLeading = false,
    Widget? subLabel,
    double appBarHeight = 56.0,
    double iconSize = 40,
  }) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      floating: false,
      pinned: true,
      expandedHeight: appBarHeight,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: appBarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isLeadingSvgAssetVisible) ...{
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: leadingSvgAsset,
                          )
                        },
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: iconSize,
                                  child: Center(
                                    child: Text(
                                      appTitle,
                                      style: CoconutTypography.heading3_21_NumberBold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                subLabel ?? Container(),
                              ],
                            ),
                          ),
                        ),
                        for (Widget action in actionButtonList) ...[
                          if (action is IconButton)
                            IconButton(
                              icon: action.icon,
                              onPressed: action.onPressed,
                              iconSize: iconSize,
                              padding: action.padding,
                              constraints: action.constraints,
                              tooltip: action.tooltip,
                              alignment: action.alignment,
                              splashRadius: action.splashRadius,
                              color: action.color,
                              focusColor: action.focusColor,
                              hoverColor: action.hoverColor,
                              highlightColor: action.highlightColor,
                              disabledColor: action.disabledColor,
                            )
                          else
                            action,
                        ]
                      ],
                    ),
                  ),
                ],
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
    Brightness brightness = CoconutTheme.brightness();
    return AppBar(
      systemOverlayStyle: Platform.isIOS
          ? (brightness == Brightness.light
              ? const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark, // iOS → 검정 텍스트
                )
              : const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // iOS → 흰색 텍스트
                ))
          : (brightness == Brightness.light
              ? const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark, // Android → 검정 텍스트
                )
              : const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // Android → 흰색 텍스트
                )),
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
      toolbarHeight: height ?? (isBottom ? 60 : 56),
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: Navigator.canPop(context)
          ? Column(
              children: [
                CoconutLayout.spacing_100h,
                Row(
                  children: [
                    CoconutLayout.spacing_100w,
                    IconButton(
                      icon: SvgPicture.asset(
                        isBottom
                            ? 'packages/coconut_design_system/assets/svg/close.svg'
                            : 'packages/coconut_design_system/assets/svg/arrow-back.svg',
                        colorFilter:
                            ColorFilter.mode(CoconutColors.onPrimary(brightness), BlendMode.srcIn),
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
      flexibleSpace: !isBottom && backgroundColor == null
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          : Container(),
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
class CoconutFrostedAppBar extends StatefulWidget implements PreferredSizeWidget {
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
        _isTitleVisible = widget.hasTitleOpacity ? newTitleVisible : _isTitleVisible;
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
    Brightness brightness = CoconutTheme.brightness();
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
                    colorFilter:
                        ColorFilter.mode(CoconutColors.onPrimary(brightness), BlendMode.srcIn),
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
