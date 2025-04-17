import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

/// A customizable bottom sheet with a structured layout.
///
/// The `CoconutBottomSheet` provides a modal bottom sheet with the following features:
/// - A **customizable app bar** at the top.
/// - A **scrollable body section** with optional height constraints.
/// - Automatic height adjustments based on screen size.
/// - A rounded **top border radius** for a smooth UI experience.
///
/// Example Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (context) => CoconutBottomSheet(
///     appBar: AppBar(title: Text("Bottom Sheet")),
///     body: Column(
///       children: [Text("This is a bottom sheet content.")],
///     ),
///   ),
/// );
/// ```
class CoconutBottomSheet extends StatelessWidget {
  /// The main body content of the bottom sheet.
  final Widget body;

  /// The height ratio relative to the screen height.
  final double heightRatio;

  /// The margin at the bottom of the bottom sheet,
  final double bottomMargin;

  /// Whether to use IntrinsicHeight for measuring the height of the widget.
  /// If `true`, the widget will wrap its content and measure the exact height required.
  /// If `false`, the widget will use the default layout behavior without intrinsic height calculations.
  final bool useIntrinsicHeight;

  /// The app bar displayed at the top of the bottom sheet.
  final PreferredSizeWidget? appBar;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// Creates an instance of `CoconutBottomSheet`.
  const CoconutBottomSheet({
    super.key,
    required this.body,
    this.heightRatio = 0.95,
    this.bottomMargin = 54,
    this.useIntrinsicHeight = false,
    this.appBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Brightness brightness = CoconutTheme.brightness();

    return LayoutBuilder(builder: (context, constraints) {
      // Define the maximum and minimum height of the bottom sheet based on screen size.
      double maxHeight = constraints.maxHeight * heightRatio;
      double minHeight = constraints.maxHeight * 0.1;

      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? CoconutColors.onWhite(brightness),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minHeight: minHeight,
        ),
        child: useIntrinsicHeight
            ? IntrinsicHeight(
                child: Column(
                  children: [
                    /// App bar section
                    if (appBar != null) ...{appBar!},

                    /// Body section with dynamic height adjustment
                    Expanded(child: SingleChildScrollView(child: body)),

                    /// Bottom spacing to prevent UI from touching the screen edge
                    SizedBox(height: bottomMargin),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Colors.transparent,
                appBar: appBar,
                body: Padding(
                  padding: EdgeInsets.only(bottom: bottomMargin),
                  child: body,
                ),
              ),
      );
    });
  }
}
