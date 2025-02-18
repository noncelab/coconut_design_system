import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  /// Determines the brightness mode (light or dark) to adjust colors.
  final Brightness brightness;

  /// Callback function triggered when the text changes.
  ///
  /// The function receives the new text value as an argument.
  final Function(String) onChanged;

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

  /// Whether to display the error text when an error occurs.
  ///
  /// Defaults to `false`.
  final bool? isVisibleErrorText;

  /// Whether the text field should obscure input (e.g., for passwords).
  ///
  /// Defaults to `false`.
  final bool obscureText;

  /// Creates a `CoconutTextField` widget.
  ///
  /// - [controller] manages the text input.
  /// - [focusNode] handles focus-related behaviors.
  /// - [brightness] adjusts the colors based on light or dark mode.
  /// - [onChanged] is triggered when the text input changes.
  /// - [activeColor], [placeholderColor], and [errorColor] customize text and border colors.
  /// - [maxLength] sets a character limit.
  /// - [maxLines] allows multi-line input.
  /// - [prefix] and [suffix] add leading/trailing widgets.
  /// - [placeholderText] displays a hint inside the text field.
  /// - [errorText] and [isVisibleErrorText] handle error messages.
  /// - [obscureText] enables secure text entry.
  ///
  /// Example usage:
  /// ```dart
  /// CoconutTextField(
  ///   controller: TextEditingController(),
  ///   focusNode: FocusNode(),
  ///   brightness: Theme.of(context).brightness,
  ///   onChanged: (text) {
  ///     print("Text input: $text");
  ///   },
  ///   placeholderText: "Enter your email",
  ///   maxLength: 50,
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
    required this.brightness,
    required this.onChanged,
    this.activeColor,
    this.cursorColor,
    this.placeholderColor,
    this.errorColor,
    this.maxLength,
    this.maxLines,
    this.prefix,
    this.suffix,
    this.placeholderText,
    this.errorText,
    this.descriptionText,
    this.isVisibleErrorText,
    this.obscureText = false,
  });

  @override
  State<CoconutTextField> createState() => _CoconutTextFieldState();
}

class _CoconutTextFieldState extends State<CoconutTextField> {
  late Color _activeColor;
  late Color _placeholderColor;
  late Color _errorColor;
  late Color _cursorColor;

  String _text = '';
  bool _isFocus = false;

  /// Listens to text changes and updates the internal state.
  // void _textControllerListener() {
  //   String text = widget.controller.text;
  //   if (widget.maxLength != null && text.runes.length > widget.maxLength!) {
  //     text = String.fromCharCodes(text.runes.take(widget.maxLength!));
  //   }
  //   _text = text;
  //   setState(() {});
  //   widget.onChanged(_text);
  // }

  /// Listens to focus changes and updates the UI accordingly.
  void _focusNodeListener() {
    _isFocus = widget.focusNode.hasFocus;
    setState(() {});
  }

  @override
  void initState() {
    // widget.controller.addListener(_textControllerListener);
    widget.focusNode.addListener(_focusNodeListener);
    _activeColor =
        widget.activeColor ?? CoconutColors.onBlack(widget.brightness);
    _cursorColor =
        widget.cursorColor ?? CoconutColors.onBlack(widget.brightness);
    _placeholderColor =
        widget.placeholderColor ?? CoconutColors.onGray300(widget.brightness);
    _errorColor = widget.errorColor ?? CoconutColors.red;
    _text = widget.controller.text;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CoconutTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _activeColor =
        widget.activeColor ?? CoconutColors.onBlack(widget.brightness);
    _cursorColor =
        widget.cursorColor ?? CoconutColors.onBlack(widget.brightness);
    _placeholderColor =
        widget.placeholderColor ?? CoconutColors.onGray300(widget.brightness);
    _errorColor = widget.errorColor ?? CoconutColors.red;
    _text = widget.controller.text;
  }

  @override
  void dispose() {
    // widget.controller.removeListener(_textControllerListener);
    widget.controller.dispose();
    widget.focusNode.removeListener(_focusNodeListener);
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 컨텐츠 크기에 맞추기
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _text.isEmpty
                  ? _placeholderColor
                  : _text.runes.length == widget.maxLength
                      ? _errorColor
                      : _activeColor,
            ),
            borderRadius: BorderRadius.circular(12),
            // color: MyColors.transparentWhite_15,
          ),
          child: CupertinoTextField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText,
            padding:
                EdgeInsets.fromLTRB(widget.prefix != null ? 0 : 16, 20, 16, 20),
            style: CoconutTypography.body2_14.copyWith(
              color: _activeColor,
            ),
            placeholder: widget.placeholderText,
            placeholderStyle: CoconutTypography.body2_14
                .copyWith(color: _placeholderColor, height: 1),
            cursorColor: _cursorColor,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            maxLength: widget.maxLength,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            prefix: widget.prefix,
            suffix: widget.suffix,
            onChanged: (text) {
              if (widget.maxLength != null) {
                if (text.runes.length > widget.maxLength!) {
                  text =
                      String.fromCharCodes(text.runes.take(widget.maxLength!));
                  widget.controller.text = text;
                }
              }

              _text = text;
              setState(() {});
              widget.onChanged(_text);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.errorText != null &&
                  widget.isVisibleErrorText == true) ...{
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
              if (widget.maxLength != null) ...{
                Container(),
                Text(
                  '${_text.runes.length}/${widget.maxLength}',
                  style: CoconutTypography.body3_12_Number.copyWith(
                    color: _text.isEmpty
                        ? _placeholderColor
                        : _text.runes.length == widget.maxLength
                            ? _errorColor
                            : _activeColor,
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
