import 'package:base_asset/base_asset.dart';
import 'package:flutter/material.dart';

import '../color/color_token.dart';
import '../corner/corner_token.dart';
import '../form/input_text_component.dart';
import '../icon/icon_component.dart';

// No need to treat as StatefulWidget
// Because search bar is a widget that is not ready to use directly in screen
// Search bar needs to be wrapped inside another widget
// The wrapper should handle the input text value of search bar
class SearchBarComponent extends StatelessWidget {
  final String? placeholder;
  final String? text;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onTextSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final bool enabled;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Key keySearchInput;

  static const keyValueSearchInput = "searchbar-input";

  /// * [placeholder] Placeholder text when [text] is null or empty
  /// * [text] Search bar text value
  /// * [onTextChanged] Search bar text value changed listener
  /// * [onTextSubmitted] Keyboard action tap listener
  /// * [onFocusChanged] Search bar focus changed listener
  /// * [enabled] Whether search bar in enabled or disabled state
  /// * [autoFocus] Auto focus the search bar value and show the keyboard
  const SearchBarComponent({
    Key? key,
    this.placeholder,
    this.text,
    this.onTextChanged,
    this.onTextSubmitted,
    this.onFocusChanged,
    this.enabled = true,
    this.autoFocus = false,
    this.focusNode,
    this.keySearchInput = const Key(keyValueSearchInput),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        decoration: BoxDecoration(
            border: Border.all(color: ColorToken.ui01),
            color: ColorToken.ui01,
            borderRadius: CornerToken.radius4),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconComponent.minor(BaseIcon.search,
                  color: ColorToken.iconPrimary),
            ),
            Expanded(
              child: InputTextComponent(
                key: keySearchInput,
                textEditingController: TextEditingController(text: text),
                placeholder: placeholder,
                showClearIcon: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onTextChanged: onTextChanged,
                onTextSubmitted: onTextSubmitted,
                onFocusChanged: onFocusChanged,
                enabled: enabled,
                autoFocus: autoFocus,
                focusNode: focusNode,
                inputAction: TextInputAction.search,
              ),
            )
          ],
        ));
  }
}
