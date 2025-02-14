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
///     brightness: Brightness.light,
///     appBar: AppBar(title: Text("Bottom Sheet")),
///     body: Column(
///       children: [Text("This is a bottom sheet content.")],
///     ),
///   ),
/// );
/// ```
class CoconutBottomSheet extends StatelessWidget {
  /// Defines the brightness mode (light or dark) to adjust colors accordingly.
  final Brightness brightness;

  /// The app bar displayed at the top of the bottom sheet.
  final PreferredSizeWidget appBar;

  /// The main body content of the bottom sheet.
  final Widget body;

  /// The margin at the bottom of the bottom sheet,
  final double bottomMargin;

  /// An optional fixed height for the body content.
  ///
  /// If `bodyHeight` is provided, the body is wrapped inside a `SizedBox`
  /// with the given height; otherwise, it expands dynamically.
  final double? bodyHeight;

  /// The background color of the bottom sheet.
  final Color? backgroundColor;

  /// Creates an instance of `CoconutBottomSheet`.
  const CoconutBottomSheet({
    super.key,
    required this.brightness,
    required this.appBar,
    required this.body,
    this.bottomMargin = 54,
    this.bodyHeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Define the maximum and minimum height of the bottom sheet based on screen size.
      double maxHeight = constraints.maxHeight * 0.9;
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
        child: IntrinsicHeight(
          child: Column(
            children: [
              /// App bar section
              appBar,

              /// Body section with dynamic height adjustment
              if (bodyHeight != null) ...{
                SizedBox(
                  height: bodyHeight,
                  child: SingleChildScrollView(child: body),
                )
              } else ...{
                Expanded(child: SingleChildScrollView(child: body)),
              },

              /// Bottom spacing to prevent UI from touching the screen edge
              SizedBox(height: bottomMargin),
            ],
          ),
        ),
      );
    });
  }
}
