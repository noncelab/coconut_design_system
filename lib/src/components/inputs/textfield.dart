import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field widget with a Cupertino-style appearance.
///
/// `CoconutTextField` supports various customization options, including:
/// - Active, placeholder, and error colors.
/// - Maximum length and multiple lines.
/// - Prefix and suffix widgets.
/// - Secure text entry (for passwords).
/// - Focus and text change listeners.
class CoconutTextField extends StatefulWidget {
  /// The text controller for managing the input text.
  final TextEditingController controller;

  /// The focus node for handling focus events.
  final FocusNode focusNode;

  /// - Deprecated: This parameter will be removed in version `0.9.0`.
  /// - Now automatically inferred from `CoconutTheme.brightness()`.
  @Deprecated(
      'This parameter will be removed in version 0.8. It is now inferred from CoconutTheme.brightness.')
  final Brightness? brightness;

  /// Callback function triggered when the text changes.
  ///
  /// The function receives the new text value as an argument.
  final Function(String) onChanged;

  /// The padding inside the text field.
  ///
  /// If `null`, it defaults to `EdgeInsets.fromLTRB(16, 20, 16, 20)`,
  /// or `EdgeInsets.fromLTRB(0, 20, 16, 20)` if a `prefix` widget is provided.
  final EdgeInsets? padding;

  /// The color of the text when the field is active.
  ///
  /// If `null`, it defaults to `CoconutColors.onBlack(brightness)`.
  final Color? activeColor;

  /// The color of the text curosr.
  ///
  /// If `null`, it defaults to `CoconutColors.onBlack(brightness)`.
  final Color? cursorColor;

  /// The color of the placeholder text.
  ///
  /// If `null`, it defaults to `CoconutColors.onGray300(brightness)`.
  final Color? placeholderColor;

  /// The color of the text field border when an error occurs.
  ///
  /// If `null`, it defaults to `CoconutColors.red`.
  final Color? errorColor;

  /// The color of the text field background
  ///
  /// If `null`, it defaults to `Colors.transparent`.
  final Color? backgroundColor;

  /// The maximum length of the text input.
  ///
  /// If `null`, there is no limit.
  final int? maxLength;

  /// The maximum number of lines the text field can have.
  ///
  /// If `null`, it defaults to a single-line input unless `obscureText` is `false`.
  final int? maxLines;

  /// A widget displayed before the text input (e.g., an icon).
  final Widget? prefix;

  /// A widget displayed after the text input (e.g., a clear button).
  final Widget? suffix;

  /// The placeholder text displayed when the field is empty.
  final String? placeholderText;

  /// The error text displayed when an error occurs.
  ///
  /// If `null`, no error message is shown.
  final String? errorText;

  /// Additional description text displayed below the text field.
  final String? descriptionText;

  /// Whether to display the error text and error border when an error occurs.
  ///
  /// Defaults to `false`.
  final bool isError;

  final TextInputType? textInputType;

  final TextInputAction? textInputAction;

  /// The text input formatter to control the input format.
  final List<TextInputFormatter>? textInputFormatter;

  /// Whether the text field should obscure input (e.g., for passwords).
  ///
  /// Defaults to `false`.
  final bool obscureText;

  /// Whether the text field should have a visible border.
  final bool isVisibleBorder;

  /// The border radius of the text field
  final double borderRadius;

  /// The height of the text field.
  ///
  /// If `null`, the height is determined by the text content and padding.
  /// When set, it forces the text field to have a fixed height.
  final double? height;

  /// The font size of the text inside the text field.
  final double fontSize;

  /// The font family of the text inside the text field.
  final String fontFamily;

  /// The font weight of the text inside the text field.
  final FontWeight fontWeight;

  /// The alignment of the text inside the text field.
  ///
  /// If `null`, it defaults to `TextAlign.start`.
  final TextAlign? textAlign;

  /// Whether to display the character length counter.
  ///
  /// If `true`, the length indicator (e.g., "10/50") is shown.
  /// Defaults to `true`.
  final bool isLengthVisible;

  /// If false, disables the ability to:
  /// - long-press and show the selection toolbar (cut/copy/paste),
  /// - tap and drag to select text.
  /// Useful when you want to prevent the user from modifying cursor position or interacting with text selection features.
  final bool? enableInteractiveSelection;

  /// Creates a `CoconutTextField` widget.
  ///
  /// - [controller] manages the text input.
  /// - [focusNode] handles focus-related behaviors.
  /// - [onChanged] is triggered when the text input changes.
  /// - [activeColor], [cursorColor], [placeholderColor], and [errorColor] customize text and border colors.
  /// - [backgroundColor] sets the background color of the text field.
  /// - [maxLength] sets a character limit.
  /// - [maxLines] allows multi-line input.
  /// - [prefix] and [suffix] add leading/trailing widgets.
  /// - [placeholderText] displays a hint inside the text field.
  /// - [errorText] and [isError] handle error messages and status.
  /// - [descriptionText] provides additional information below the text field.
  /// - [obscureText] enables secure text entry.
  /// - [isVisibleBorder] determines whether the text field has a border.
  /// - [borderRadius] sets the border radius of the text field.
  /// - [height] sets a fixed height for the text field (optional).
  /// - [fontSize] sets the font size of the input text.
  /// - [fontFamily] specifies the font family for the input text.
  /// - [fontWeight] specifies the font weight for the input text.
  /// - [textAlign] controls the alignment of the text inside the field.
  /// - [isLengthVisible] determines whether to display the character length counter.
  /// - [enableInteractiveSelection] disables text selection and long-press actions.
  /// Example usage:
  /// ```dart
  /// CoconutTextField(
  ///   controller: TextEditingController(),
  ///   focusNode: FocusNode(),
  ///   onChanged: (text) {
  ///     print("Text input: $text");
  ///   },
  ///   placeholderText: "Enter your email",
  ///   maxLength: 50,
  ///   textAlign: TextAlign.center,
  ///   isLengthVisible: false,
  ///   prefix: Icon(Icons.email),
  ///   suffix: IconButton(
  ///     icon: Icon(Icons.clear),
  ///     onPressed: () => print("Clear tapped"),
  ///   ),
  /// )
  /// ```
  const CoconutTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.brightness,
    this.padding,
    this.activeColor,
    this.cursorColor,
    this.placeholderColor,
    this.errorColor,
    this.backgroundColor,
    this.maxLength,
    this.maxLines,
    this.prefix,
    this.suffix,
    this.placeholderText,
    this.errorText,
    this.descriptionText,
    this.isError = false,
    this.textInputType,
    this.textInputAction,
    this.textInputFormatter,
    this.obscureText = false,
    this.isVisibleBorder = true,
    this.borderRadius = 12,
    this.height,
    this.fontSize = 14,
    this.fontFamily = 'Pretendard',
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.isLengthVisible = true,
    this.enableInteractiveSelection,
  });

  @override
  State<CoconutTextField> createState() => _CoconutTextFieldState();
}

class _CoconutTextFieldState extends State<CoconutTextField> {
  late Color _activeColor;
  late Color _placeholderColor;
  late Color _errorColor;
  late Color _cursorColor;
  late Color _backgroundColor;
  Brightness brightness = CoconutTheme.brightness();

  final GlobalKey _prefixGlobalKey = GlobalKey();
  Size _prefixSize = const Size(0, 0);

  String _text = '';
  String _placeholderText = '';
  bool _isFocus = false;

  void _controllerListener() {
    String text = widget.controller.text;
      if (widget.maxLength != null) {
        if (text.runes.length > widget.maxLength!) {
          text = String.fromCharCodes(text.runes.take(widget.maxLength!));
          widget.controller.text = text;
          return;
        }
      }

      if(text == _text) return;

      _text = text;
      setState(() {});
      widget.onChanged(_text);
  }

  /// Listens to focus changes and updates the UI accordingly.
  void _focusNodeListener() {
    _isFocus = widget.focusNode.hasFocus;
    setState(() {});
  }

  void _updateData() {
    _activeColor = widget.activeColor ?? CoconutColors.onBlack(brightness);
    _cursorColor = widget.cursorColor ?? CoconutColors.onBlack(brightness);
    _placeholderColor = widget.placeholderColor ?? CoconutColors.onGray300(brightness);
    _errorColor = widget.errorColor ?? CoconutColors.red;
    _backgroundColor = widget.backgroundColor ?? Colors.transparent;
    _text = widget.controller.text;
  }

  @override
  void initState() {
    super.initState();
    _placeholderText = widget.placeholderText ?? '';
    widget.controller.addListener(_controllerListener);
    widget.focusNode.addListener(_focusNodeListener);
    _updateData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_prefixGlobalKey.currentContext != null) {
        final prefixRenderBox = _prefixGlobalKey.currentContext?.findRenderObject() as RenderBox;
        _prefixSize = prefixRenderBox.size;
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant CoconutTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateData();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    widget.focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            border: widget.isVisibleBorder
                ? Border.all(
                    color: widget.isError
                        ? _errorColor
                        : _isFocus
                            ? widget.maxLength != null && _text.runes.length > widget.maxLength!
                                ? _errorColor
                                : _activeColor
                            : _placeholderColor,
                  )
                : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: _backgroundColor,
          ),
          child: Stack(
            children: [
              CupertinoTextField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                inputFormatters: widget.textInputFormatter,
                obscureText: widget.obscureText,
                textAlign: widget.textAlign ?? TextAlign.start,
                padding: widget.padding ??
                    EdgeInsets.fromLTRB(widget.prefix != null ? 0 : 16, 20, 16, 20),
                style: CoconutTypography.body2_14.copyWith(
                  color: _activeColor,
                  fontSize: widget.fontSize,
                  fontFamily: widget.fontFamily,
                  fontWeight: widget.fontWeight,
                ),
                cursorColor: _cursorColor,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                maxLength: widget.maxLength,
                maxLines: widget.obscureText ? 1 : widget.maxLines,
                prefix: Container(
                  key: _prefixGlobalKey,
                  child: widget.prefix,
                ),
                suffix: widget.suffix,
                keyboardType: widget.textInputType,
                textInputAction: widget.textInputAction,
                textAlignVertical: TextAlignVertical.bottom,
                enableInteractiveSelection: widget.enableInteractiveSelection,
              ),
              IgnorePointer(
                child: Container(
                  height: widget.prefix != null ? _prefixSize.height : null,
                  margin: widget.prefix == null
                      ? widget.padding ?? const EdgeInsets.fromLTRB(16, 20, 16, 20)
                      : EdgeInsets.only(left: _prefixSize.width, top: widget.padding?.top ?? 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _isFocus || _text.isNotEmpty ? '' : _placeholderText,
                    style: CoconutTypography.body2_14.copyWith(
                      color: _placeholderColor,
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.errorText != null && widget.isError == true) ...{
                Expanded(
                  child: Text(
                    widget.errorText ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: CoconutTypography.body3_12.copyWith(
                      color: _errorColor,
                    ),
                  ),
                )
              } else if (widget.descriptionText != null) ...{
                Expanded(
                  child: Text(
                    widget.descriptionText ?? '',
                    style: CoconutTypography.body3_12.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: _isFocus ? _activeColor : _placeholderColor,
                    ),
                  ),
                ),
              },
              if (widget.maxLength != null && widget.isLengthVisible) ...{
                Container(),
                Text(
                  '${_text.runes.length}/${widget.maxLength}',
                  style: CoconutTypography.body3_12_Number.copyWith(
                    color: _isFocus ? _activeColor : _placeholderColor,
                  ),
                ),
              }
            ],
          ),
        ),
      ],
    );
  }
}
