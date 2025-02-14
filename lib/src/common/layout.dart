import 'package:coconut_design_system/src/common/sizes.dart';
import 'package:flutter/material.dart';

/// **Coconut Design System - Layout & Spacing Utility**
///
/// This class provides a standardized **spacing system** using `SizedBox`.
/// It defines **vertical (`h`) and horizontal (`w`) spacing** for consistent UI layouts.
///
/// ### Naming Convention:
/// - **`h` (height)** → Used for vertical spacing.
/// - **`w` (width)** → Used for horizontal spacing.
/// - The numeric value represents the logical pixel size.
///
/// ### Default Spacing Constants:
/// - **`defaultPadding`** → The default padding applied to layouts.
/// - **`defaultGutter`** → The default gutter space between UI components.
///
/// Example usage:
/// ```dart
/// Column(
///   children: [
///     Text('Title'),
///     CoconutLayout.spacing_200h, // Adds vertical spacing
///     Text('Subtitle'),
///   ],
/// );
///
/// Padding(
///   padding: CoconutLayout.defaultPadding, // Applies default padding
///   child: Text('Content'),
/// );
///
/// Row(
///   children: [
///     Text('Left'),
///     CoconutLayout.defaultGutter,
///     Text('Right'),
///   ],
/// );
/// ```
///
/// This ensures **consistent spacing across the entire design system**.
///
/// ---
class CoconutLayout {
  /// Vertical Spacing
  static const spacing_50h = SizedBox(height: Sizes.size2);
  static const spacing_100h = SizedBox(height: Sizes.size4);
  static const spacing_200h = SizedBox(height: Sizes.size8);
  static const spacing_300h = SizedBox(height: Sizes.size12);
  static const spacing_400h = SizedBox(height: Sizes.size16);
  static const spacing_500h = SizedBox(height: Sizes.size20);
  static const spacing_600h = SizedBox(height: Sizes.size24);
  static const spacing_700h = SizedBox(height: Sizes.size28);
  static const spacing_800h = SizedBox(height: Sizes.size32);
  static const spacing_900h = SizedBox(height: Sizes.size36);
  static const spacing_1000h = SizedBox(height: Sizes.size40);
  static const spacing_1100h = SizedBox(height: Sizes.size44);
  static const spacing_1200h = SizedBox(height: Sizes.size48);
  static const spacing_1300h = SizedBox(height: Sizes.size52);
  static const spacing_1400h = SizedBox(height: Sizes.size56);
  static const spacing_1500h = SizedBox(height: Sizes.size60);
  static const spacing_1600h = SizedBox(height: Sizes.size64);
  static const spacing_1700h = SizedBox(height: Sizes.size68);
  static const spacing_1800h = SizedBox(height: Sizes.size72);
  static const spacing_1900h = SizedBox(height: Sizes.size76);
  static const spacing_2000h = SizedBox(height: Sizes.size80);
  static const spacing_2100h = SizedBox(height: Sizes.size84);
  static const spacing_2200h = SizedBox(height: Sizes.size88);
  static const spacing_2300h = SizedBox(height: Sizes.size92);
  static const spacing_2400h = SizedBox(height: Sizes.size96);
  static const spacing_2500h = SizedBox(height: Sizes.size100);

  /// Horizontal Spacing
  static const spacing_50w = SizedBox(width: Sizes.size2);
  static const spacing_100w = SizedBox(width: Sizes.size4);
  static const spacing_200w = SizedBox(width: Sizes.size8);
  static const spacing_300w = SizedBox(width: Sizes.size12);
  static const spacing_400w = SizedBox(width: Sizes.size16);
  static const spacing_500w = SizedBox(width: Sizes.size20);
  static const spacing_600w = SizedBox(width: Sizes.size24);
  static const spacing_700w = SizedBox(width: Sizes.size28);
  static const spacing_800w = SizedBox(width: Sizes.size32);
  static const spacing_900w = SizedBox(width: Sizes.size36);
  static const spacing_1000w = SizedBox(width: Sizes.size40);
  static const spacing_1100w = SizedBox(width: Sizes.size44);
  static const spacing_1200w = SizedBox(width: Sizes.size48);
  static const spacing_1300w = SizedBox(width: Sizes.size52);
  static const spacing_1400w = SizedBox(width: Sizes.size56);
  static const spacing_1500w = SizedBox(width: Sizes.size60);
  static const spacing_1600w = SizedBox(width: Sizes.size64);
  static const spacing_1700w = SizedBox(width: Sizes.size68);
  static const spacing_1800w = SizedBox(width: Sizes.size72);
  static const spacing_1900w = SizedBox(width: Sizes.size76);
  static const spacing_2000w = SizedBox(width: Sizes.size80);
  static const spacing_2100w = SizedBox(width: Sizes.size84);
  static const spacing_2200w = SizedBox(width: Sizes.size88);
  static const spacing_2300w = SizedBox(width: Sizes.size92);
  static const spacing_2400w = SizedBox(width: Sizes.size96);
  static const spacing_2500w = SizedBox(width: Sizes.size100);

  /// For layout default padding
  static const defaultPadding = Sizes.size16;

  /// For layout default gutter
  static const defaultGutter = Sizes.size12;
}
