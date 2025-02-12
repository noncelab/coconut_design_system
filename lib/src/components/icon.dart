import 'package:flutter/cupertino.dart';

/// **CoconutIcon**
///
/// `CoconutIcon` is a Flutter widget that wraps an icon or image inside a rounded container,
/// allowing customization of background color and size.
///
/// ---
///
/// **Usage Example**
/// ```dart
/// CoconutIcon(
///   child: Icon(Icons.star, color: Colors.white),
///   size: 50,
///   backgroundColor: Colors.blue,
/// )
/// ```
///
/// ---
///
/// **Properties**
/// - **`child`** → A widget (icon or image) inside the container (**required**)
/// - **`size`** → The width and height of the container (**required**)
/// - **`backgroundColor`** → The background color of the container (**required**)
///
/// ---
class CoconutIcon extends StatelessWidget {
  /// Creates a `CoconutIcon` widget.
  ///
  /// - `child`: The widget (icon or image) inside the container.
  /// - `size`: The size (both width and height) of the container.
  /// - `backgroundColor`: The background color of the container.
  const CoconutIcon({
    super.key,
    required this.child,
    required this.size,
    required this.backgroundColor,
  });

  /// The icon or image widget inside the container.
  final Widget child;

  /// The size of the container (both width and height).
  final double size;

  /// The background color of the container.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size / 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 3),
      ),
      child: child,
    );
  }
}
