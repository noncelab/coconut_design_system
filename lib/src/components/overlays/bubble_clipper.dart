import 'package:flutter/material.dart';

/// A custom clipper that creates a speech bubble shape with a left triangle pointer.
///
/// This is typically used for tooltips or chat bubbles where the pointer is
/// on the left side of the bubble.
class LeftTriangleBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from the top-left corner with an inner margin of 15px
    path.moveTo(15, 15);
    path.lineTo(30, 15);
    path.lineTo(39, 5); // Left bubble triangle peak
    path.lineTo(48, 15);
    path.lineTo(size.width - 15, 15);

    // Top-right rounded corner
    path.quadraticBezierTo(size.width, 15, size.width, 30);
    path.lineTo(size.width, size.height - 15);

    // Bottom-right rounded corner
    path.quadraticBezierTo(size.width, size.height, size.width - 15, size.height);
    path.lineTo(15, size.height);

    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 15);
    path.lineTo(0, 30);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 15, 15, 15);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

/// A custom clipper that creates a speech bubble shape with a right triangle pointer.
///
/// This is used for tooltips or chat bubbles where the pointer is
/// positioned on the right side of the bubble.
class RightTriangleBubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from the top-right corner with an inner margin of 15px
    path.moveTo(size.width - 15, 15);
    path.lineTo(size.width - 10, 15);
    path.lineTo(size.width - 19, 5); // Right bubble triangle peak
    path.lineTo(size.width - 28, 15);
    path.lineTo(15, 15);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 15, 0, 30);
    path.lineTo(0, size.height - 15);

    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 15, size.height);
    path.lineTo(size.width - 15, size.height);

    // Bottom-right rounded corner
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 15);
    path.lineTo(size.width, 30);

    // Top-right rounded corner
    path.quadraticBezierTo(size.width, 15, size.width - 15, 14.5);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
