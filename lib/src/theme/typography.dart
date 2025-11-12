// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

/// **Coconut Design System - Typography Theme Generator**
///
/// This class defines typography styles for the **Coconut Design System**.
/// - Supports both **light** and **dark** mode text themes.
/// - Provides predefined typography styles for **headings, body, and captions**.
/// - Includes variations for **number styling** and **bold text**.
class CoconutTextTheme {
  /// Returns the text theme for **dark mode**.
  ///
  /// - Default text color: **white**
  /// - Display text color: **white70**
  static TextTheme get darkTextTheme => textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white70,
      );

  /// Returns the text theme for **light mode**.
  ///
  /// - Default text color: **black**
  /// - Display text color: **black87**
  static TextTheme get lightTextTheme => textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black87,
      );

  /// **Base text theme** with Coconut Typography styles.
  ///
  /// This is used as the foundation for both **light** and **dark** themes.
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

/// **Applies variations** to the base typography styles.
///
/// Allows **bold** and **number-specific fonts** to be applied dynamically.
/// - **isNumber** → Uses `SpaceGrotesk` instead of `Pretendard`.
/// - **isBold** → Uses `FontWeight.w700` instead of regular weight.
TextStyle applyVariation(
  TextStyle baseStyle, {
  bool isNumber = false,
  bool isBold = false,
}) {
  double? fontSize = baseStyle.fontSize;

  return baseStyle.copyWith(
      fontFamily: isNumber ? CoconutTypography.kNumberFontFamily : CoconutTypography.kTextFontFamily,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      height: fontSize != null ? (fontSize >= 24 ? 1.2 : 1.4) : null,
      letterSpacing: fontSize != null ? (fontSize >= 18 ? -0.04 : -0.02) : -0.02);
}

/// **Coconut Design System - Typography Styles**
///
/// Defines **font families, sizes, and weights** used throughout the system.
/// - Supports **dynamic variations** using `applyVariation()`.
/// - Includes predefined styles for **headings, body, captions**.
/// - Uses `Pretendard` for general text and `SpaceGrotesk` for numbers.
class CoconutTypography {
  /// **Primary font** used in the system (`Pretendard`).
  static const String kTextFontFamily = 'Pretendard';

  /// **Font for numbers** to enhance numerical clarity (`SpaceGrotesk`).
  static const String kNumberFontFamily = 'SpaceGrotesk';

  // ====== Heading Styles ======

  /// **H1 - 32px, Regular**
  static const TextStyle heading1_32 =
      TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: kTextFontFamily, height: 1.2);

  static final TextStyle heading1_32_Bold = applyVariation(heading1_32, isBold: true);
  static final TextStyle heading1_32_Number = applyVariation(heading1_32, isNumber: true);
  static final TextStyle heading1_32_NumberBold = applyVariation(heading1_32, isNumber: true, isBold: true);

  /// **H2 - 28px, Regular**
  static const TextStyle heading2_28 =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: kTextFontFamily, height: 1.2);

  static final TextStyle heading2_28_Bold = applyVariation(heading2_28, isBold: true);
  static final TextStyle heading2_28_Number = applyVariation(heading2_28, isNumber: true);
  static final TextStyle heading2_28_NumberBold = applyVariation(heading2_28, isNumber: true, isBold: true);

  /// **H3 - 21px, Regular**
  static const TextStyle heading3_21 =
      TextStyle(fontSize: 21, fontWeight: FontWeight.w400, fontFamily: kTextFontFamily, height: 1.4);

  static final TextStyle heading3_21_Bold = applyVariation(heading3_21, isBold: true);
  static final TextStyle heading3_21_Number = applyVariation(heading3_21, isNumber: true);
  static final TextStyle heading3_21_NumberBold = applyVariation(heading3_21, isNumber: true, isBold: true);

  /// **H4 - 18px, Regular**
  static const TextStyle heading4_18 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: kTextFontFamily, height: 1.4);

  static final TextStyle heading4_18_Bold = applyVariation(heading4_18, isBold: true);
  static final TextStyle heading4_18_Number = applyVariation(heading4_18, isNumber: true);
  static final TextStyle heading4_18_NumberBold = applyVariation(heading4_18, isNumber: true, isBold: true);

  /// **Body 1 - 16px, Regular**
  static const TextStyle body1_16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: kTextFontFamily, height: 1.4);

  static final TextStyle body1_16_Bold = applyVariation(body1_16, isBold: true);
  static final TextStyle body1_16_Number = applyVariation(body1_16, isNumber: true);
  static final TextStyle body1_16_NumberBold = applyVariation(body1_16, isNumber: true, isBold: true);

  /// **Body 2 - 14px, Regular**
  static const TextStyle body2_14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    height: 1.4,
  );

  static final TextStyle body2_14_Bold = applyVariation(body2_14, isBold: true);
  static final TextStyle body2_14_Number = applyVariation(body2_14, isNumber: true);
  static final TextStyle body2_14_NumberBold = applyVariation(body2_14, isNumber: true, isBold: true);

  /// **Body 3 - 12px, Regular**
  static const TextStyle body3_12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    height: 1.4,
  );

  static final TextStyle body3_12_Bold = applyVariation(body3_12, isBold: true);
  static final TextStyle body3_12_Number = applyVariation(body3_12, isNumber: true);
  static final TextStyle body3_12_NumberBold = applyVariation(body3_12, isNumber: true, isBold: true);

  /// **Caption Number - 10px, Regular**
  static const TextStyle caption_10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kTextFontFamily,
    height: 1.4,
  );

  static final TextStyle caption_10_Bold = applyVariation(caption_10, isBold: true);
  static final TextStyle caption_10_Number = applyVariation(caption_10, isNumber: true);
  static final TextStyle caption_10_NumberBold = applyVariation(caption_10, isNumber: true, isBold: true);

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

extension TextColorExtension on TextStyle {
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }
}
