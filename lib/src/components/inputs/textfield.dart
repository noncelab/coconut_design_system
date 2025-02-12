import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoconutTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Brightness brightness;
  final Function(String) onChanged;
  final Color? activeColor;
  final Color? placeholderColor;
  final Color? errorColor;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final String? placeholderText;
  final String? errorText;
  final String? descriptionText;
  final bool? isVisibleErrorText;
  final bool obscureText;
  const CoconutTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.brightness,
    required this.onChanged,
    this.activeColor,
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

  String _text = '';
  bool _isFocus = false;
  void _textControllerListener() {
    String text = widget.controller.text;
    if (widget.maxLength != null && text.runes.length > widget.maxLength!) {
      text = String.fromCharCodes(text.runes.take(widget.maxLength!));
    }
    _text = text;
    setState(() {});
    widget.onChanged(_text);
  }

  void _focusNodeListener() {
    _isFocus = widget.focusNode.hasFocus;
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_textControllerListener);
    widget.focusNode.addListener(_focusNodeListener);
    _activeColor =
        widget.activeColor ?? CoconutColors.onBlack(widget.brightness);
    _placeholderColor =
        widget.placeholderColor ?? CoconutColors.onGray300(widget.brightness);
    _errorColor = widget.errorColor ?? CoconutColors.red;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CoconutTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _activeColor =
        widget.activeColor ?? CoconutColors.onBlack(widget.brightness);
    _placeholderColor =
        widget.placeholderColor ?? CoconutColors.onGray300(widget.brightness);
    _errorColor = widget.errorColor ?? CoconutColors.red;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textControllerListener);
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
            cursorColor: CoconutColors.onBlack(widget.brightness),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            maxLength: widget.maxLength,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            prefix: widget.prefix,
            suffix: widget.suffix,
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
