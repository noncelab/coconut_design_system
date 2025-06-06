import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';

class CoconutStyles {
  /// **radius-500 (32px)**
  /// - Used for **Bottom Sheet's left/right top border radius**.
  static const radius_500 = 32.0;

  /// **radius-400 (24px)**
  /// - Used for **primary elements occupying the entire screen width**.
  /// - **Examples:** Home screen elements, wallet/vault cards, transaction history, UTXO cards.
  static const radius_400 = 24.0;

  /// **radius-300 (20px)**
  /// - Used for **secondary elements occupying the entire screen width**.
  /// - **Examples:** Menu cards, custom toasts, tooltips.
  static const radius_300 = 20.0;

  /// **radius-250 (16px)**
  /// - Used for **Tooltip**.
  /// - **Examples:** Tooltip Containers.
  static const radius_250 = 16.0;

  /// **radius-200 (12px)**
  /// - Used for **CTA (Call-To-Action) buttons**.
  /// - **Examples:** Receive, Send, Full-width bottom navigation buttons.
  static const radius_200 = 12.0;

  /// **radius-150 (10px)**
  /// - Used for **small buttons, badges, tags, and compact UI elements**.
  /// - **Examples:** Small action buttons, Category tags, Notification badges
  static const radius_150 = 10.0;

  /// **radius-100 (8px)**
  /// - Used for **the smallest UI elements with rounded corners**.
  /// - **Examples:** Tiny buttons, Chip components, Small indicators
  static const radius_100 = 8.0;

  /// **radius-50 (4px)**
  /// - Used for **chip UI elements and very small rounded components**.
  /// - **Examples:** Filter chips, Tag labels, Small progress indicators
  static const radius_50 = 4.0;
}

abstract class CoconutBorder {
  static final BorderRadius defaultRadius = BorderRadius.circular(CoconutStyles.radius_400);
  static final BorderRadius boxDecorationRadius = BorderRadius.circular(CoconutStyles.radius_100);
}

class CoconutPadding {
  static const EdgeInsets container = EdgeInsets.symmetric(horizontal: 16, vertical: 20);
  static const EdgeInsets widgetContainer = EdgeInsets.symmetric(horizontal: 24, vertical: 20);
}

class CoconutBoxDecoration {
  static BoxDecoration shadowBoxDecoration = BoxDecoration(
    borderRadius: CoconutBorder.boxDecorationRadius,
    color: CoconutColors.white,
    boxShadow: [
      BoxShadow(
        color: CoconutColors.black.withOpacity(0.06),
        spreadRadius: 4,
        blurRadius: 20,
      ),
    ],
  );
}
