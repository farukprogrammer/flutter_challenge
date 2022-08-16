import 'package:base_asset/base_asset.dart';
import 'package:base_component/src/icon/icon_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../button/button_link_component.dart';
import '../color/color_token.dart';
import '../container/tappable_container.dart';
import '../image/image_holder.dart';
import '../structure/separator_line_component.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';
import 'menubar_component.dart';

class NavBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final ImageHolder? icon;
  final VoidCallback? onNavigationTap;
  final List<MenuBarItem> menus;
  final void Function(MenuBarItem)? onMenuTap;
  final int navBarType;
  final Widget? child;
  final int height;
  final bool showSeparatorLine;
  final BoxShadow? elevation;
  final Color? backgroundColor;
  final String? action;
  final VoidCallback? onActionTap;
  final Key keyNavigationIcon;
  final Key keyAction;
  final String keyMoreMenu;

  static const _typeDefault = 0;
  static const _typeCustom = 1;

  static const int defaultHeight = 56;

  static const keyValueNavigationIcon = "NavBar_NavigationIcon";
  static const keyValueMoreMenu = "NavBar_MoreMenu";
  static const keyValueAction = "NavBar_Action";
  static const keyValueNavBar = "Base_NavBar";

  /// Navigation bar with base style
  ///
  /// * [title] Navigation title
  /// * [menus] Navigation menu on the right side
  /// * [onMenuTap] Navigation menu item on tap listener
  /// * [onNavigationTap] Navigation back icon on tap listener
  ///   Set to null to hide navigation back icon
  /// * [showSeparatorLine] Whether show or hide separator line
  ///   on the bottom side
  /// * [elevation] Navigation bar elevation
  ///   See [ShadowToken]
  /// * [action] Action text on the right side
  ///   Text instead of icon from navigation menu
  /// * [onActionTap] Action text on tap listener
  /// * [keyNavigationIcon] Navigation icon key
  /// * [keyAction] Navigation [action] key
  /// * [keyMoreMenu] Navigation menu more icon key
  /// * [navigationIconEventAttributes] Additional attributes
  ///   for [UserEvent.click] when navigation icon tapped
  /// * [moreMenuEventAttributes] Additional attributes for [UserEvent.click]
  ///   when more menu icon tapped
  const NavBarComponent({
    required this.title,
    Key? key = const Key(keyValueNavBar),
    this.menus = const [],
    this.onNavigationTap,
    this.onMenuTap,
    this.showSeparatorLine = true,
    this.elevation,
    this.action,
    this.onActionTap,
    this.keyNavigationIcon = const Key(keyValueNavigationIcon),
    this.keyAction = const Key(keyValueAction),
    this.keyMoreMenu = keyValueMoreMenu,
  }) : icon = null,
      navBarType = _typeDefault,
      child = null,
      height = defaultHeight,
      backgroundColor = null,
      super(key: key);

  /// Navigation bar with custom style
  ///
  /// * [title] Navigation title widget
  /// * [icon] Navigation icon on the left side
  /// * [onIconTap] Navigation icon on tap listener
  /// * [menus] Navigation menu on the right side
  /// * [onMenuTap] Navigation menu item on tap listener
  /// * [style] Navigation bar style
  /// * [height] Navigation bar custom height
  /// * [showSeparatorLine] Whether show or hide separator line
  ///   on the bottom side
  /// * [elevation] Navigation bar elevation
  ///   See [ShadowToken]
  /// * [action] Action text on the right side
  ///   Text instead of icon from navigation menu
  /// * [onActionTap] Action text on tap listener
  /// * [keyNavigationIcon] Navigation icon key
  /// * [keyAction] Navigation [action] key
  /// * [keyMoreMenu] Navigation menu more icon key
  /// * [navigationIconEventAttributes] Additional attributes
  ///   for [UserEvent.click] when navigation icon tapped
  /// * [moreMenuEventAttributes] Additional attributes for [UserEvent.click]
  ///   when more menu icon tapped
  const NavBarComponent.custom({
    Key? key = const Key(keyValueNavBar),
    Widget? title,
    this.icon,
    this.menus = const [],
    VoidCallback? onIconTap,
    this.onMenuTap,
    this.height = defaultHeight,
    this.showSeparatorLine = true,
    this.elevation,
    this.backgroundColor,
    this.action,
    this.onActionTap,
    this.keyNavigationIcon = const Key(keyValueNavigationIcon),
    this.keyAction = const Key(keyValueAction),
    this.keyMoreMenu = keyValueMoreMenu,
  }) : navBarType = _typeCustom,
      title = "",
      child = title,
      onNavigationTap = onIconTap,
      super(key: key);

  // navigation bar height should include separator line height
  // separator line height = 1
  @override
  Size get preferredSize => Size.fromHeight(height.toDouble());

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarComponent> {
  static const _debugModeInfo = "SHOW PAGE INFO";

  bool _screenInfoOpened = false;

  void _toggleShowInfo() {
    setState(() {
      _screenInfoOpened = !_screenInfoOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeName = _screenInfoOpened
      ? ModalRoute.of(context)?.settings.name : _debugModeInfo;
    final showNavigationIcon = _isShowNavigationIcon();
    final showAction = _isShowAction();
    final navigationTitle = _getNavigationTitle();
    final shadow = widget.elevation;

    final navigationIconPadding = 8 + _iconSize + (_iconBleedingArea * 2);

    final content = Stack(children: [
      // hacky solution to set the navigation bar height
      Container(
        color: widget.backgroundColor ?? ColorToken.theBackground,
        width: double.infinity,
        height: widget.height.toDouble(),
        alignment: Alignment.bottomRight,
        child: _isShowSeparatorLine()
          ? const SeparatorLineComponent() : const SizedBox(height: 1),
      ),
      // navigation icon
      if (showNavigationIcon) ...[
        const SizedBox(width: 4),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _getNavigationIcon(),
          )
        )
      ],
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              // navigation title
              if (navigationTitle != null) ...[
                showNavigationIcon
                  ? SizedBox(width: navigationIconPadding)
                  : const SizedBox(width: 16),
              navigationTitle,
              const SizedBox(width: 8)
            ],
            if (navigationTitle == null) ...[
              // keep menu bar alignment to right
              // when navigation title is empty
              const Expanded(child: SizedBox.shrink())
            ],
            // navigation action on the left side of navigation menu
            if (showAction) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ButtonLinkComponent(widget.action ?? "",
                key: widget.keyAction, onTap: widget.onActionTap
                )
              )
            ],
            // navigation menu on the right side
            MenuBarComponent(
              menu: widget.menus,
              maxMenu: _getMenuSize(),
              onMenuTap: widget.onMenuTap,
              moreMenu: MenuBarItem(
                  id: widget.keyMoreMenu, icon: BaseIcon.moreVertical),
            ),
            _getRightSpace()
          ],
        ),
      )),
      if (kDebugMode && routeName != null)
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: _toggleShowInfo,
            child: TextComponent(
              routeName.startsWith('/') ? Uri.parse(routeName).path : routeName,
              textAlign: TextAlign.center,
              style: TypographyToken.caption10(color: ColorToken.brand01),
            ),
          ),
        )
    ]);

    if (shadow != null) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: ColorToken.theBackground,
            boxShadow: [shadow],
          ),
          child: content
        )
      );
    }
    return SafeArea(
        child: Container(color: ColorToken.theBackground, child: content));
  }

  double get _iconSize => IconComponent.sizeMajor;

  int get _iconBleedingArea => 12;

  Widget _getNavigationIcon() {
    final imageHolder = widget.navBarType == NavBarComponent._typeDefault
      ? ImageHolder.asset(BaseIcon.backAndroid) : widget.icon;

    return Tappable(
      key: widget.keyNavigationIcon,
      onTap: widget.onNavigationTap,
      child: IconComponent.imageHolder(
        imageHolder,
        size: _iconSize,
        bleedingArea: _iconBleedingArea
      ),
    );
  }

  Widget? _getNavigationTitle() {
    if (widget.navBarType == NavBarComponent._typeDefault) {
      return Expanded(
        child: TextComponent(
          widget.title,
          style: TypographyToken.subheading18(),
          maxLines: 1
        )
      );
    }
    final child = widget.child;
    return child != null ? Expanded(child: child) : null;
  }

  bool _isShowNavigationIcon() {
    if (widget.navBarType == NavBarComponent._typeDefault) {
      return widget.onNavigationTap != null;
    }
    return widget.icon != null;
  }

  bool _isShowAction() {
    return widget.action != null && widget.action?.isNotEmpty == true;
  }

  bool _isShowSeparatorLine() {
    // separator line should be hidden when elevation is not null
    return widget.showSeparatorLine && widget.elevation == null;
  }

  int _getMenuSize() {
    final showNavigationIcon = _isShowNavigationIcon();
    final showAction =
      widget.action != null && widget.action?.isNotEmpty == true;

    if (showNavigationIcon && showAction) {
      return 1;
    } else if (!showNavigationIcon && showAction) {
      return 1;
    } else if (showNavigationIcon && !showAction) {
      return 3;
    }
    // !showNavigationIcon && !showAction
    return 4;
  }

  Widget _getRightSpace() {
    if (widget.action != null && widget.menus.isEmpty) {
      return const SizedBox(width: 10);
    }
    return widget.menus.isNotEmpty
      ? const SizedBox(width: 8) : const SizedBox(width: 16);
  }
}
