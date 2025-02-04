import 'package:flutter/material.dart';

/// **Coconut Design System `TextTheme` Generator**
///
/// This class provides a consistent typography theme for the Coconut Design System.
/// It includes both **light** and **dark** mode text themes.
class CoconutTextTheme {
  /// Returns the text theme for **dark mode**.
  ///
  /// - Applies **white** as the default text color.
  /// - Uses **white70** for display text.
  static TextTheme get darkTextTheme => textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white70,
      );

  /// Returns the text theme for **light mode**.
  ///
  /// - Applies **black** as the default text color.
  /// - Uses **black87** for display text.
  static TextTheme get lightTextTheme => textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black87,
      );

  /// Defines the **base text theme** with custom styles.
  static TextTheme get textTheme => const TextTheme(
        displayLarge: CoconutTypography.heading1Bold,
        displayMedium: CoconutTypography.heading2Bold,
        displaySmall: CoconutTypography.heading3Bold,
        headlineLarge: CoconutTypography.heading1Bold,
        headlineMedium: CoconutTypography.heading2Bold,
        headlineSmall: CoconutTypography.heading3Bold,
        titleLarge: CoconutTypography.heading1Bold,
        titleMedium: CoconutTypography.heading2Bold,
        titleSmall: CoconutTypography.heading3Bold,
        bodyLarge: CoconutTypography.body1,
        bodyMedium: CoconutTypography.body2,
        bodySmall: CoconutTypography.body3,
        labelLarge: CoconutTypography.body1,
        labelMedium: CoconutTypography.body2,
        labelSmall: CoconutTypography.body3,
      );
}

/// **Coconut Design System Typography**
///
/// Defines the default typography styles used in the Coconut Design System.
/// It includes multiple font weights, sizes, and spacing for a unified design.
class CoconutTypography {
  /// Default text font family used throughout the system.
  static const String kTextFontFamily = 'Pretendard';

  /// Number-specific font family for enhanced numerical clarity.
  static const String kNumberFontFamily = 'SpaceGrotesk';

  // ====== Heading Styles ======

  /// **H1 Bold** - 32px, `Pretendard`, Bold
  static const TextStyle heading1Bold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 38.4 / 32,
  );

  /// **H1 Number Bold** - 32px, `SpaceGrotesk`, Bold
  static const TextStyle heading1NumberBold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 38.4 / 32,
  );

  /// **H2 Bold** - 28px, `Pretendard`, Bold
  static const TextStyle heading2Bold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 33.6 / 28,
  );

  /// **H2 Number Bold** - 28px, `SpaceGrotesk`, Bold
  static const TextStyle heading2NumberBold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 33.6 / 28,
  );

  /// **H3** - 21px, `Pretendard`, Regular
  static const TextStyle heading3 = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 29.4 / 21,
  );

  /// **H3 Number** - 21px, `Pretendard`, Regular
  static const TextStyle heading3Number = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 29.4 / 21,
  );

  /// **H3 Bold** - 21px, `Pretendard`, Bold
  static const TextStyle heading3Bold = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 29.4 / 21,
  );

  /// **H3 Number Bold** - 21px, `SpaceGrotesk`, Bold
  static const TextStyle heading3NumberBold = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 29.4 / 21,
  );

  /// **H4** - 18px, `Pretendard`, Regular
  static const TextStyle heading4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 27 / 18,
  );

  /// **H4 Number** - 18px, `SpaceGrotesk`, Regular
  static const TextStyle heading4Number = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 27 / 18,
  );

  /// **H4 Bold** - 18px, `Pretendard`, Bold
  static const TextStyle heading4Bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.04,
    height: 27 / 18,
  );

  /// **H4 Number Bold** - 18px, `SpaceGrotesk`, Bold
  static const TextStyle heading4NumberBold = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.04,
    height: 27 / 18,
  );

  /// **Body 1** - 16px, `Pretendard`, Regular
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 22.4 / 16,
  );

  /// **Body 1 Number** - 16px, `SpaceGrotesk`, Regular
  static const TextStyle body1Number = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 22.4 / 16,
  );

  /// **Body 1 Bold** - 16px, `Pretendard`, Bold
  static const TextStyle body1Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 22.4 / 16,
  );

  /// **Body 1 Number Bold** - 16px, `SpaceGrotesk`, Bold
  static const TextStyle body1NumberBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 22.4 / 16,
  );

  /// **Body 2** - 14px, `Pretendard`, Regular
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 19.6 / 14,
  );

  /// **Body 2 Number** - 14px, `SpaceGrotesk`, Regular
  static const TextStyle body2Number = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 19.6 / 14,
  );

  /// **Body 2 Bold** - 14px, `Pretendard`, Bold
  static const TextStyle body2Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 19.6 / 14,
  );

  /// **Body 2 Number Bold** - 14px, `SpaceGrotesk`, Bold
  static const TextStyle body2NumberBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 19.6 / 14,
  );

  /// **Body 3** - 12px, `Pretendard`, Regular
  static const TextStyle body3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 16.8 / 14,
  );

  /// **Body 3 Number** - 12px, `SpaceGrotesk`, Regular
  static const TextStyle body3Number = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 16.8 / 14,
  );

  /// **Body 3 Bold** - 12px, `Pretendard`, Bold
  static const TextStyle body3Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 16.8 / 14,
  );

  /// **Body 3 Number Bold** - 12px, `SpaceGrotesk`, Bold
  static const TextStyle body3NumberBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 16.8 / 14,
  );

  /// **Caption** - 10px, `Pretendard`, Regular
  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 14 / 10,
  );

  /// **Caption Number** - 10px, `SpaceGrotesk`, Regular
  static const TextStyle captionNumber = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 14 / 10,
  );

  /// **Caption Bold** - 10px, `Pretendard`, Bold
  static const TextStyle captionBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    fontFamily: kTextFontFamily,
    letterSpacing: -0.02,
    height: 14 / 10,
  );

  /// **Caption Number Bold** - 10px, `SpaceGrotesk`, Bold
  static const TextStyle caotionNumberBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    fontFamily: kNumberFontFamily,
    letterSpacing: -0.02,
    height: 14 / 10,
  );

  /// **Predefined Typography Styles Map**
  ///
  /// Provides easy access to typography styles with meaningful labels.
  static final Map<String, TextStyle> typographyStyles = {
    // Heading Styles (Pretendard)
    'Heading 1 (Bold)': heading1Bold,
    'Heading 1 (Number Bold)': heading1NumberBold,
    'Heading 2 (Bold)': heading2Bold,
    'Heading 2 (Number Bold)': heading2NumberBold,
    'Heading 3': heading3,
    'Heading 3 (Bold)': heading3Bold,
    'Heading 3 (Number)': heading3Number,
    'Heading 3 (Number Bold)': heading3NumberBold,
    'Heading 4': heading4,
    'Heading 4 (Bold)': heading4Bold,
    'Heading 4 (Number)': heading4Number,
    'Heading 4 (Number Bold)': heading4NumberBold,

    // Body Styles (Pretendard)
    'Body 1': body1,
    'Body 1 (Bold)': body1Bold,
    'Body 1 (Number)': body1Number,
    'Body 1 (Number Bold)': body1NumberBold,
    'Body 2': body2,
    'Body 2 (Bold)': body2Bold,
    'Body 2 (Number)': body2Number,
    'Body 2 (Number Bold)': body2NumberBold,
    'Body 3': body3,
    'Body 3 (Bold)': body3Bold,
    'Body 3 (Number)': body3Number,
    'Body 3 (Number Bold)': body3NumberBold,

    // Caption Styles (Pretendard)
    'Caption': caption,
    'Caption (Bold)': captionBold,
    'Caption (Number)': captionNumber,
    'Caption (Number Bold)': caotionNumberBold,
  };
}
