

import 'package:base_asset/base_asset.dart';
import 'package:base_component/src/navbar/menubar_component.dart';
import 'package:flutter/material.dart';

import '../button/button_link_component.dart';
import '../container/tappable_container.dart';
import '../image/image_holder.dart';
import 'navbar_component.dart';
import 'search_bar_component.dart';

class NavBarSearchComponent extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onIconTap;
  final VoidCallback? onSearchBarTap;
  final List<MenuBarItem> menus;
  final void Function(MenuBarItem)? onMenuTap;
  final bool showSeparatorLine;
  final bool searchEnabled;
  final BoxShadow? elevation;
  final String? action;
  final VoidCallback? onActionTap;
  final bool searchAutoFocus;
  final String? searchText;
  final String? searchPlaceholder;
  final ValueChanged<String>? onSearchTextChanged;
  final ValueChanged<String>? onSearchTextSubmitted;
  final String cancelSearchText;
  final VoidCallback? onSearchCancelled;
  final Key keyNavigationIcon;
  final Key keyAction;
  final String keyMoreMenu;
  final Key keySearchBar;
  final Key keySearchInput;
  final Key keySearchCancel;

  static const keyValueNavBarSearch = "Base_NavBarSearch";
  static const keyValueSearchBar = "NavBarSearch_Searchbar";
  static const keyValueSearchCancel = "NavBarSearch_Cancel";
  static const keyValueMoreMenu = "NavBarSearch_MoreMenu";
  static const keyValueAction = "NavBarSearch_Action";
  static const keyValueNavigationIcon = "NavBarSearch_NavigationIcon";
  static const keyTappable = "NavBarSearch_Tappable";

  /// * [onNavigationTap] Navigation icon on tap listener
  ///   Navigation icon always [BaseIcon.backAndroid]
  ///   Set this to null to hide navigation icon
  /// * [menus] Navigation menu on the right side
  /// * [onMenuTap] Navigation menu item on tap listener
  /// * [onSearchBarTap] Search bar on tap listener, just in case you have to
  /// use this component as an entry point only.
  /// * [showSeparatorLine] Whether show or hide separator line
  ///   on the bottom side
  /// * [searchEnabled] Whether search bar in enabled or disabled state
  /// * [elevation] Navigation bar search elevation
  ///   See [ShadowToken]
  /// * [action] Action text on the right side
  ///   Text instead of icon from navigation menu
  /// * [onActionTap] Action text on tap listener
  /// * [cancelSearchText] Cancel search button text
  ///   This one should not be empty
  /// * [searchAutoFocus] Auto focus search bar and show the keyboard
  /// * [searchPlaceholder] Search bar placeholder text
  /// * [onSearchTextChanged] Search bar text value changed listener
  /// * [onSearchTextSubmitted] Keyboard action tap listener
  /// * [onSearchCancelled] Search cancel button tap listener
  ///   [cancelSearchText] is the text value of cancel button
  /// * [searchAutoFocus] Auto focus the search bar and show the keyboard
  ///   Immediately show the keyboard when the screen opened
  /// * [keyNavigationIcon] Navigation icon key
  /// * [keyAction] Navigation [action] key
  /// * [keyMoreMenu] Navigation menu more icon key
  /// * [keySearchBar] Navigation search search bar key [searchText]
  /// * [keySearchCancel] Navigation search search bar cancel button
  const NavBarSearchComponent({
    Key? key = const Key(keyValueNavBarSearch),
    VoidCallback? onNavigationTap,
    this.menus = const [],
    this.onMenuTap,
    this.showSeparatorLine = true,
    this.searchEnabled = true,
    this.elevation,
    this.action,
    this.onSearchBarTap,
    this.onActionTap,
    this.searchText,
    this.searchPlaceholder,
    this.onSearchTextChanged,
    this.onSearchTextSubmitted,
    this.cancelSearchText = "",
    this.onSearchCancelled,
    this.searchAutoFocus = false,
    this.keyNavigationIcon = const Key(keyValueNavigationIcon),
    this.keyAction = const Key(keyValueAction),
    this.keyMoreMenu = keyValueMoreMenu,
    this.keySearchBar = const Key(keyValueSearchBar),
    this.keySearchInput = const Key(SearchBarComponent.keyValueSearchInput),
    this.keySearchCancel = const Key(keyValueSearchCancel),
  }) : assert(
        cancelSearchText.length > 0,
        "Cancel search text should be filled"
      ),
      onIconTap = onNavigationTap,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _NavBarSearchState();

  // navigation bar search height should include separator line height
  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _NavBarSearchState extends State<NavBarSearchComponent> {
  final focusNode = FocusNode(debugLabel: "searchbar-focus");
  bool focused = false;

  @override
  void initState() {
    super.initState();
    // focused state should follow autoFocus value
    // this will prevent widget rebuild
    // and causing search to lose its focus
    focused = widget.searchAutoFocus;
  }
  @override
  Widget build(BuildContext context) {
    final navbar = NavBarComponent.custom(
      title: _getNavigationTitle(),
      icon: _getNavigationIcon(),
      onIconTap: widget.onIconTap,
      showSeparatorLine: widget.showSeparatorLine,
      elevation: widget.elevation,
      onMenuTap: widget.onMenuTap,
      onActionTap: widget.onActionTap,
      // menu and action should be hidden when search bar is focused
      menus: focused ? const <MenuBarItem>[] : widget.menus,
      action: focused ? null : widget.action,
      keyAction: widget.keyAction,
      keyNavigationIcon: widget.keyNavigationIcon,
      keyMoreMenu: widget.keyMoreMenu,
    );
    return navbar;
  }

  ImageHolder? _getNavigationIcon() {
    return !focused && widget.onIconTap != null ?
      ImageHolder.asset(BaseIcon.backAndroid) : null;
  }

  Widget _getNavigationTitle() {
    final searchEnabled = widget.onSearchBarTap != null
        ? false
        : widget.searchEnabled;

    final searchBar = SearchBarComponent(
      enabled: searchEnabled,
      focusNode: focusNode,
      key: widget.keySearchBar,
      keySearchInput: widget.keySearchInput,
      text: widget.searchText,
      placeholder: widget.searchPlaceholder,
      autoFocus: widget.searchAutoFocus,
      onTextChanged: widget.onSearchTextChanged,
      onTextSubmitted: (value) {
        // clear focus of search bar
        FocusScope.of(context).unfocus();

        widget.onSearchTextSubmitted?.call(value);
      },
      onFocusChanged: (hasFocus) {
        focused = hasFocus;
        setState(() {});
      },
    );

    final searchContent = widget.onSearchBarTap != null
        ? Tappable.gestureDetector(
            key: const Key(NavBarSearchComponent.keyTappable),
            onTap: widget.onSearchBarTap,
            child: searchBar,
          )
        : searchBar;

    return Row(
      children: [
        Expanded(child: searchContent),
        if (focused) ...[
          const SizedBox(width: 8),
          ButtonLinkComponent(
            widget.cancelSearchText,
            key: widget.keySearchCancel,
            onTap: () {
              final focus = FocusScope.of(context).focusedChild;
              if (focus?.debugLabel == focusNode.debugLabel) {
                // current search bar is focused
                // clear focus of search bar
                FocusScope.of(context).unfocus();
              } else {
                // search bar is not focused
                // manually set focused to false
                focused = false;
                setState(() { });
              }

              widget.onSearchCancelled?.call();
            },
          )
        ]
      ]
    );
  }
}