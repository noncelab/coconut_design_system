// ignore_for_file: non_constant_identifier_names

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
  static TextTheme get textTheme => TextTheme(
        displayLarge: CoconutTypography.heading1_32_Bold,
        displayMedium: CoconutTypography.heading2_28_Bold,
        displaySmall: CoconutTypography.heading3_21_Bold,
        headlineLarge: CoconutTypography.heading1_32_Bold,
        headlineMedium: CoconutTypography.heading2_28_Bold,
        headlineSmall: CoconutTypography.heading3_21_Bold,
        titleLarge: CoconutTypography.heading1_32_Bold,
        titleMedium: CoconutTypography.heading2_28_Bold,
        titleSmall: CoconutTypography.heading3_21_Bold,
        bodyLarge: CoconutTypography.body1_16,
        bodyMedium: CoconutTypography.body2_14,
        bodySmall: CoconutTypography.body3_12,
        labelLarge: CoconutTypography.body1_16,
        labelMedium: CoconutTypography.body2_14,
        labelSmall: CoconutTypography.body3_12,
      );
}

/// Method for Typography Variation
TextStyle applyVariation(
  TextStyle baseStyle, {
  bool isNumber = false,
  bool isBold = false,
}) {
  double? fontSize = baseStyle.fontSize;

  return baseStyle.copyWith(
      fontFamily: isNumber
          ? CoconutTypography.kNumberFontFamily
          : CoconutTypography.kTextFontFamily,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      height: fontSize != null ? (fontSize >= 24 ? 1.4 : 1.2) : null,
      letterSpacing:
          fontSize != null ? (fontSize >= 18 ? -0.04 : -0.02) : -0.02);
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

  /// **H1 Bold** - 32px, `Pretendard`
  static const TextStyle heading1_32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle heading1_32_Bold =
      applyVariation(heading1_32, isBold: true);
  static final TextStyle heading1_32_Number =
      applyVariation(heading1_32, isNumber: true);
  static final TextStyle heading1_32_NumberBold =
      applyVariation(heading1_32, isNumber: true, isBold: true);

  /// **H2 Bold** - 28px, `Pretendard`
  static const TextStyle heading2_28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle heading2_28_Bold =
      applyVariation(heading2_28, isBold: true);
  static final TextStyle heading2_28_Number =
      applyVariation(heading2_28, isNumber: true);
  static final TextStyle heading2_28_NumberBold =
      applyVariation(heading2_28, isNumber: true, isBold: true);

  /// **H3** - 21px, `Pretendard`
  static const TextStyle heading3_21 = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle heading3_21_Bold =
      applyVariation(heading3_21, isBold: true);
  static final TextStyle heading3_21_Number =
      applyVariation(heading3_21, isNumber: true);
  static final TextStyle heading3_21_NumberBold =
      applyVariation(heading3_21, isNumber: true, isBold: true);

  /// **H4** - 18px, `Pretendard`
  static const TextStyle heading4_18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle heading4_18_Bold =
      applyVariation(heading4_18, isBold: true);
  static final TextStyle heading4_18_Number =
      applyVariation(heading4_18, isNumber: true);
  static final TextStyle heading4_18_NumberBold =
      applyVariation(heading4_18, isNumber: true, isBold: true);

  /// **Body 1** - 16px, `Pretendard`
  static const TextStyle body1_16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle body1_16_Bold = applyVariation(body1_16, isBold: true);
  static final TextStyle body1_16_Number =
      applyVariation(body1_16, isNumber: true);
  static final TextStyle body1_16_NumberBold =
      applyVariation(body1_16, isNumber: true, isBold: true);

  /// **Body 2** - 14px, `Pretendard`
  static const TextStyle body2_14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle body2_14_Bold = applyVariation(body2_14, isBold: true);
  static final TextStyle body2_14_Number =
      applyVariation(body2_14, isNumber: true);
  static final TextStyle body2_14_NumberBold =
      applyVariation(body2_14, isNumber: true, isBold: true);

  /// **Body 3** - 12px, `Pretendard`, Regular
  static const TextStyle body3_12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle body3_12_Bold = applyVariation(body3_12, isBold: true);
  static final TextStyle body3_12_Number =
      applyVariation(body3_12, isNumber: true);
  static final TextStyle body3_12_NumberBold =
      applyVariation(body3_12, isNumber: true, isBold: true);

  /// **Caption Number** - 10px, `SpaceGrotesk`, Regular
  static const TextStyle caption_10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
  );

  static final TextStyle caption_10_Bold =
      applyVariation(caption_10, isBold: true);
  static final TextStyle caption_10_Number =
      applyVariation(caption_10, isNumber: true);
  static final TextStyle caption_10_NumberBold =
      applyVariation(caption_10, isNumber: true, isBold: true);

  /// **Predefined Typography Styles Map**
  ///
  /// Provides easy access to typography styles with meaningful labels.
  static final Map<String, TextStyle> typographyStyles = {
    // Heading Styles
    'Heading 1 (32px)': heading1_32,
    'Heading 1 (32px, Bold)': heading1_32_Bold,
    'Heading 1 (32px, Number)': heading1_32_Number,
    'Heading 1 (32px, Number Bold)': heading1_32_NumberBold,
    'Heading 2 (28px)': heading2_28,
    'Heading 2 (28px, Bold)': heading2_28_Bold,
    'Heading 2 (28px, Number)': heading2_28_Number,
    'Heading 2 (28px, Number Bold)': heading2_28_NumberBold,
    'Heading 3 (21px)': heading3_21,
    'Heading 3 (21px, Bold)': heading3_21_Bold,
    'Heading 3 (21px, Number)': heading3_21_Number,
    'Heading 3 (21px, Number Bold)': heading3_21_NumberBold,

    // Body Styles
    'Body 1 (16px)': body1_16,
    'Body 1 (16px, Bold)': body1_16_Bold,
    'Body 1 (16px, Number)': body1_16_Number,
    'Body 1 (16px, Number Bold)': body1_16_NumberBold,
    'Body 2 (14px)': body2_14,
    'Body 2 (14px, Bold)': body2_14_Bold,
    'Body 2 (14px, Number)': body2_14_Number,
    'Body 2 (14px, Number Bold)': body2_14_NumberBold,
    'Body 3 (12px)': body3_12,
    'Body 3 (12px, Bold)': body3_12_Bold,
    'Body 3 (12px, Number)': body3_12_Number,
    'Body 3 (12px, Number Bold)': body3_12_NumberBold,

    // Caption Styles (Pretendard)
    'Caption (10px)': caption_10,
    'Caption (10px, Bold)': caption_10_Bold,
    'Caption (10px, Number)': caption_10_Number,
    'Caption (10p,x Number Bold)': caption_10_NumberBold,
  };
}
