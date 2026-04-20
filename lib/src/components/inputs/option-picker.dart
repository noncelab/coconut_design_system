import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Defines the visual state of [CoconutOptionPicker].
///
/// - [normal] uses the default neutral styling.
/// - [warning] highlights supporting elements with a warning color.
/// - [error] highlights supporting elements with an error color.
enum CoconutOptionStateEnum {
  normal,
  warning,
  error,
}

/// A tappable option field that displays a selected value with an optional label,
/// inline widgets, and a trailing chevron icon.
///
/// This widget is useful when you want a compact "selection trigger" UI that
/// opens a custom action such as a bottom sheet, dialog, or route when tapped.
///
/// The picker supports:
/// - An optional [label] above the main row
/// - A primary [text] value
/// - Optional [inlineWidgets] placed to the right of the text
/// - A divider below the tappable row
/// - Semantic visual states via [coconutOptionStateEnum]
/// - An optional [guideText] shown for warning and error states
/// - An optional [subWidget] shown below the divider on the right side
///
/// The main content row scrolls horizontally so that long text and inline widgets
/// remain accessible without wrapping.
class CoconutOptionPicker extends StatelessWidget {
  /// Creates a `CoconutOptionPicker` widget.
  ///
  /// - [text] is the primary value displayed inside the picker row.
  /// - [onTap] is called when the tappable row is pressed.
  /// - [enabled] controls whether the row is interactive.
  /// - [label] displays a caption above the picker row.
  /// - [guideText] displays a helper message below the divider when the state is
  ///   [CoconutOptionStateEnum.warning] or [CoconutOptionStateEnum.error].
  /// - [padding] customizes the inner spacing of the tappable row.
  /// - [textStyle], [labelStyle], and [guideStyle] override the default text styles.
  /// - [textColor], [labelColor], [iconColor], [dividerColor], and [guideTextColor]
  ///   customize colors when not overridden by the semantic state styling.
  /// - [iconSize] sets the size of the trailing chevron icon.
  /// - [showUnderline] toggles the divider below the row.
  /// - [borderRadius] applies the top-left and top-right ripple radius.
  /// - [coconutOptionStateEnum] controls semantic styling for warning and error states.
  /// - [inlineWidgets] are rendered to the right of [text] inside the same
  ///   horizontal scroll area.
  /// - [inlineSpacing] sets the horizontal gap between [text] and [inlineWidgets].
  /// - [enableTextWrap] allows the main content to wrap onto multiple lines
  ///   instead of scrolling horizontally.
  /// - [subWidget] displays an additional widget below the divider on the trailing side.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutOptionPicker(
  ///   label: 'Selected UTXO',
  ///   text: '0.1 BTC',
  ///   inlineWidgets: const [
  ///     CoconutChip(
  ///       label: '#non-kyc',
  ///       color: CoconutColors.yellow,
  ///     ),
  ///   ],
  ///   onTap: () {
  ///     print('Open option picker action');
  ///   },
  /// )
  /// ```
  const CoconutOptionPicker({
    super.key,
    required this.onTap,
    this.text,
    this.enabled = true,
    this.label,
    this.guideText,
    this.subWidget,
    this.padding,
    this.textStyle,
    this.labelStyle,
    this.guideStyle,
    this.textColor,
    this.labelColor,
    this.iconColor,
    this.iconSize = 24,
    this.showUnderline = true,
    this.dividerColor,
    this.guideTextColor,
    this.borderRadius,
    this.coconutOptionStateEnum = CoconutOptionStateEnum.normal,
    this.inlineWidgets = const [],
    this.inlineSpacing = 8,
    this.enableTextWrap = false,
  });

  /// The primary text displayed in the picker row.
  ///
  /// This usually represents the currently selected value.
  final String? text;

  /// An optional label displayed above the picker row.
  ///
  /// This is commonly used as a field title or caption.
  final String? label;

  /// An optional helper message displayed below the divider.
  ///
  /// This text is shown only when [coconutOptionStateEnum] is not
  /// [CoconutOptionStateEnum.normal].
  final String? guideText;

  /// The supplementary widget displayed below the divider on the trailing side.
  ///
  /// This widget is commonly used for secondary actions or contextual content
  /// that should be visually separated from the main picker row.
  final Widget? subWidget;

  /// Callback function triggered when the picker row is tapped.
  final VoidCallback? onTap;

  /// Whether the picker is interactive.
  ///
  /// If `false`, the widget uses disabled text and icon colors and disables tap handling.
  final bool enabled;

  /// Padding applied inside the tappable picker row.
  final EdgeInsetsGeometry? padding;

  /// Custom text style for the main [text].
  final TextStyle? textStyle;

  /// Custom text style for the [label].
  final TextStyle? labelStyle;

  /// Custom text style for the [guideText].
  final TextStyle? guideStyle;

  /// Custom color for the main [text].
  final Color? textColor;

  /// Custom color for the [label].
  final Color? labelColor;

  /// Custom color for the trailing chevron icon.
  final Color? iconColor;

  /// The size of the trailing chevron icon.
  ///
  /// Defaults to `24.0` pixels.
  final double iconSize;

  /// Whether to show the divider below the picker row.
  final bool showUnderline;

  /// Custom color for the divider.
  final Color? dividerColor;

  /// Custom color for the [guideText].
  final Color? guideTextColor;

  /// The top-left and top-right border radius used by the ripple effect.
  final double? borderRadius;

  /// The semantic visual state of the picker.
  final CoconutOptionStateEnum coconutOptionStateEnum;

  /// Additional widgets displayed to the right of [text].
  ///
  /// These widgets are included in the same horizontal scroll area as the main text.
  final List<Widget> inlineWidgets;

  /// The horizontal spacing between [text] and each item in [inlineWidgets].
  ///
  /// Defaults to `8.0` pixels.
  final double inlineSpacing;

  /// Whether the main content should wrap onto multiple lines.
  ///
  /// If `false`, the content scrolls horizontally.
  /// If `true`, the content wraps instead of scrolling.
  final bool enableTextWrap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    // Applies semantic state colors for warning and error presentations.
    Color getColorByState(Color defaultColor) {
      return coconutOptionStateEnum == CoconutOptionStateEnum.normal
          ? defaultColor
          : coconutOptionStateEnum == CoconutOptionStateEnum.warning
              ? CoconutColors.yellow
              : CoconutColors.hotPink;
    }

    final resolvedTextColor = enabled
        ? (textColor ?? CoconutColors.onBlack(brightness))
        : CoconutColors.onGray500(brightness);
    final resolvedIconColor = getColorByState(enabled
        ? (iconColor ?? CoconutColors.onGray500(brightness))
        : CoconutColors.onGray500(brightness));
    final resolvedDividerColor =
        getColorByState(dividerColor ?? CoconutColors.onGray800(brightness));
    final resolvedTextStyle =
        textStyle ?? CoconutTypography.heading4_18.setColor(resolvedTextColor);
    final resolvedGuideTextColor =
        getColorByState(guideTextColor ?? CoconutColors.onGray800(brightness));
    final resolveGuideStyle =
        guideStyle ?? CoconutTypography.caption_10.setColor(resolvedGuideTextColor);
    final resolvedLabelColor = labelColor ?? CoconutColors.gray500;
    final resolvedLabelStyle =
        labelStyle ?? CoconutTypography.body3_12.setColor(resolvedLabelColor);
    final List<InlineSpan> wrappedContentSpans = [
      if (text != null)
        TextSpan(
          text: text,
          style: resolvedTextStyle,
        ),
      for (int index = 0; index < inlineWidgets.length; index++) ...[
        if (text != null || index > 0)
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SizedBox(width: inlineSpacing),
          ),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: inlineWidgets[index],
        ),
      ],
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label!,
              textAlign: TextAlign.start,
              style: resolvedLabelStyle,
            ),
          )
        ],
        _ShrinkOnTap(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: padding ?? EdgeInsets.fromLTRB(2, label != null ? 6 : 0, 4, 8),
            child: Row(
              children: [
                Expanded(
                  child: enableTextWrap
                      ? Text.rich(
                          TextSpan(children: wrappedContentSpans),
                          softWrap: true,
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Scroll the full inline content, including the leading text.
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (text != null) ...[
                                Text(
                                  text!,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: resolvedTextStyle,
                                ),
                              ],
                              for (final widget in inlineWidgets) ...[
                                SizedBox(width: inlineSpacing),
                                widget,
                              ],
                            ],
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'packages/coconut_design_system/assets/svg/pulldown_close.svg',
                  width: iconSize,
                  height: iconSize,
                  colorFilter: ColorFilter.mode(
                    resolvedIconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showUnderline)
          Divider(
            height: 1,
            thickness: 1,
            color: resolvedDividerColor,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (coconutOptionStateEnum != CoconutOptionStateEnum.normal && guideText != null) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      guideText!,
                      style: resolveGuideStyle,
                    ),
                  ),
                ),
              )
            ],
            if (coconutOptionStateEnum == CoconutOptionStateEnum.normal) ...[
              // for using left side area
              Container(),
            ],
            if (subWidget != null) ...[
              Padding(padding: const EdgeInsets.only(top: 4, left: 2), child: subWidget!),
            ],
          ],
        )
      ],
    );
  }
}

/// Internal helper that shrinks its [child] slightly while it is being pressed.
///
/// Used instead of [InkWell] to provide a scale-based press feedback without
/// any ripple or background color change.
class _ShrinkOnTap extends StatefulWidget {
  const _ShrinkOnTap({
    required this.child,
    this.onTap,
  });

  static const double _pressedScale = 0.97;
  static const Duration _duration = Duration(milliseconds: 100);

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_ShrinkOnTap> createState() => _ShrinkOnTapState();
}

class _ShrinkOnTapState extends State<_ShrinkOnTap> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? _ShrinkOnTap._pressedScale : 1.0,
        duration: _ShrinkOnTap._duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
