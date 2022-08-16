import 'package:base_asset/base_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color/color_token.dart';
import '../container/focusable_container.dart';
import '../container/tappable_container.dart';
import '../icon/icon_component.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';

enum InputType { text, password, number, phone }

class InputTextComponent extends StatefulWidget {
  final String? placeholder;
  final String? initialValue;
  final InputType inputType;
  final int minLines;
  final int? maxLength;
  final bool enabled;
  final bool showClearIcon;
  final TextInputAction inputAction;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final ValueChanged<String>? onTextSubmitted;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<bool>? onFocusChanged;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextInputFormatter? textInputFormatter;
  final TextEditingController? textEditingController;
  final Key? keyClearIcon;
  final Key? keyPasswordIcon;

  static const keyValueTextFormField = "InputText_TextFormField";
  static const keyValueClearIcon = "InputText_ClearIcon";
  static const keyValuePasswordIcon = "InputText_PasswordIcon";

  /// * [placeholder] Placeholder text when [initialValue] is null or empty
  /// * [initialValue] Input text value
  /// * [inputType] Input text input type
  ///   See [InputType] for more info
  /// * [inputAction] Keyboard action icon
  ///   See [TextInputAction] for more info
  /// * [minLines] Input text value minimum lines
  /// * [maxLength] Input text value max length
  ///   Set to null to remove max length restriction
  /// * [enabled] Whether input text in enabled or disabled state
  /// * [showClearIcon] Whether should show clear icon or not
  ///   Clear icon will be shown only when the input text has a value
  ///   [initialValue] is not empty
  ///   Clear icon will be hidden when input type is [InputType.password]
  /// * [padding] Padding around the input text
  ///   Set padding for better touch area, but be aware that
  ///   input text height also will be changed based on [textStyle]
  /// * [onTextSubmitted] Keyboard action key tap listener
  ///   Keyboard action is [inputType]
  /// * [onTextChanged] Input text value changed listener
  /// * [onFocusChanged] Input text focus changed listener
  /// * [focusNode] Used as identifier to request focus manually
  /// * [autoFocus] Auto focus the input text and show the keyboard
  ///   Immediately show the keyboard when the screen opened
  /// * [autoFormat] Input Text Auto format
  const InputTextComponent({
    Key? key,
    this.placeholder,
    this.initialValue,
    this.inputType = InputType.text,
    this.inputAction = TextInputAction.newline,
    this.minLines = 1,
    this.maxLength,
    this.enabled = true,
    this.showClearIcon = false,
    this.padding = EdgeInsets.zero,
    this.textStyle,
    this.onTextSubmitted,
    this.onTextChanged,
    this.onFocusChanged,
    this.focusNode,
    this.autoFocus = false,
    this.textInputFormatter,
    this.textEditingController,
    this.keyClearIcon = const Key(keyValueClearIcon),
    this.keyPasswordIcon = const Key(keyValuePasswordIcon),
  }) :
    // minLines > 1 only works for InputType.text
    // Other than InputType.text, minLines must be 1
    assert(
      (minLines == 1 && inputType != InputType.text)
        || (minLines > 1 && inputType == InputType.text)
        || (minLines == 1 && inputType == InputType.text)
    ), super(key: key);

  @override
  State<InputTextComponent> createState() => _InputTextComponentState();
}

class _InputTextComponentState extends State<InputTextComponent> {
  bool focused = false;
  bool _isShowPassword = true;
  String internalText = "";

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController =
      widget.textEditingController ?? TextEditingController();
    final value = _textEditingController.text;
    if (value.isEmpty) {
      _textEditingController.text = widget.initialValue ?? "";
    }
    internalText = _textEditingController.text;

    // focused state should follow autoFocus value
    // this will prevent widget rebuild
    // and causing search to lose its focus
    focused = widget.autoFocus;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  void didUpdateWidget(InputTextComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    final initialValue = widget.initialValue;
    final value = widget.textEditingController?.text;

    // only update the value when current value is different with existing value
    // to prevent weird interaction when showing or hiding clear icon
    if (value == null
        && initialValue != null
        && _textEditingController.text != initialValue
    ) {
      _textEditingController.text = initialValue;
      internalText = _textEditingController.text;
    } else if (value != null && value != _textEditingController.text) {
      _textEditingController.text = value;
      internalText = _textEditingController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle?.apply(color: ColorToken.textSecondary);
    final textInputFormatter = widget.textInputFormatter;
    // Todo: Fix text style with input type password
    // input type password should have monospace font
    final textStyle = style ?? TypographyToken.body14();

    final suffixIcon = _getSuffixIcon();

    final form = TextFormField(
      key: const Key(InputTextComponent.keyValueTextFormField),
      focusNode: widget.focusNode,
      keyboardType: _getTextInputType(),
      obscureText: _isObscureTextEnabled(),
      controller: _textEditingController,
      style: textStyle,
      cursorWidth: 2,
      cursorColor: ColorToken.focus,
      onChanged: (text) {
        _onTextChanged(text);
      },
      inputFormatters: [
        if (textInputFormatter != null) ...[
          textInputFormatter
        ]
      ],
      textAlignVertical: TextAlignVertical.center,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.minLines,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onTextSubmitted,
      textInputAction: widget.inputAction,
      autofocus: widget.autoFocus,

      // disable smart punctuation in ios
      // https://api.flutter.dev/flutter/material/TextField/smartQuotesType.html
      smartQuotesType: SmartQuotesType.disabled,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: widget.padding.top,
          bottom: widget.padding.bottom
        ),
        hintText: widget.placeholder,
        // placeholder text style
        hintStyle: textStyle.apply(color: ColorToken.textSubdued),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        // clear all padding around the text field form
        isDense: true
      ),
    );

    final textField = Focusable(
      child: form,
      onFocusChange: (hasFocus) {
        if (hasFocus != focused) {
          focused = hasFocus;
          setState(() { });
        }
        widget.onFocusChanged?.call(hasFocus);
      },
    );

    if (widget.minLines > 1) {
      return Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.padding.top,
                    // +1 to prevent suffix icon being cropped
                    // on the bottom side
                    bottom: widget.padding.bottom + 1
                  ),
                  // dummy text to align the input text icon with input text
                  // (clear icon or password icon) when minLines > 1
                  child: TextComponent("", style: textStyle),
                )
              ),
              if (suffixIcon != null) ...[
                suffixIcon
              ]
            ],
          ),
          Padding(
            padding: _getContentPadding(suffixIcon != null),
            child: textField,
          )
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: _getContentPadding(suffixIcon != null),
            child: textField,
          )
        ),
        if (suffixIcon != null) ...[
          suffixIcon
        ]
      ],
    );
  }

  EdgeInsets _getContentPadding(bool showSuffixIcon) {
    if (showSuffixIcon && widget.minLines > 1) {
      return EdgeInsets.only(
        left: widget.padding.left,
        right: widget.padding.right + IconComponent.sizeMinor + 4,
        // prevent suffix icon being cropped on the bottom side
        bottom: 1
      );
    }
    return EdgeInsets.only(
      left: widget.padding.left,
      right: widget.padding.right
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.inputType == InputType.password && widget.enabled) {
      // eye icon for password only shown in enabled state
      final icon = _isShowPassword ?
        BaseIcon.eyeShowMinor : BaseIcon.eyeHideMinor;
      return _getIcon(
        key: widget.keyPasswordIcon,
        icon: icon,
        onTap: () => _updateShowPasswordIconState(),
      );
    } else if (
      widget.showClearIcon && _textEditingController.text.isNotEmpty && focused
    ) {
      return _getIcon(
        key: widget.keyClearIcon,
        icon: BaseIcon.crossCircle,
        onTap: () => _resetText(),
      );
    } else {
      return null;
    }
  }

  Widget _getIcon({
    required Key? key,
    required String icon,
    required VoidCallback? onTap,
  }) {
    return Tappable(
      key: key,
      onTap: widget.enabled ? onTap : null,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: widget.padding.right, bottom: 1),
        child: IconComponent.minor(icon, color: ColorToken.iconSecondary),
      )
    );
  }

  void _updateShowPasswordIconState() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  void _resetText() {
    setState(() {
      _textEditingController.text = "";
    });
    internalText = "";
    widget.onTextChanged?.call("");
  }

  void _onTextChanged(String text) {
    // re-build the widget only to show or hide clear icon
    // once the clear icon already shown or already hidden no need to re-build
    if (internalText.isEmpty && text.isNotEmpty ||
      internalText.isNotEmpty && text.isEmpty
    ) {
      setState(() { });
    }
    internalText = text;
    widget.onTextChanged?.call(text);
  }

  bool _isObscureTextEnabled() {
    return widget.inputType == InputType.password && _isShowPassword;
  }

  TextInputType? _getTextInputType() {
    if (widget.inputType == InputType.number) {
      return TextInputType.number;
    } else if (widget.inputType == InputType.phone) {
      return TextInputType.phone;
    } else if (widget.inputType == InputType.text && widget.minLines > 1) {
      return TextInputType.multiline;
    } else {
      return TextInputType.text;
    }
  }
}
