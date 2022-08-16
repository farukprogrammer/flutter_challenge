import 'package:base_asset/base_asset.dart';
import 'package:flutter/material.dart';

import '../button/button_link_component.dart';
import '../color/color_token.dart';
import '../container/tappable_container.dart';
import '../icon/icon_component.dart';
import '../image/image_holder.dart';
import '../structure/separator_line_component.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';
import 'menubar_component.dart';
import 'navbar_component.dart';

class CollapsingNavBarComponent extends StatefulWidget {
  final Widget? titleWidget;
  final String title;
  final ImageHolder? icon;
  final VoidCallback? onNavigationTap;
  final String? action;
  final VoidCallback? onActionTap;
  final List<MenuBarItem> menus;
  final void Function(MenuBarItem)? onMenuTap;
  final bool showSeparatorLine;
  final BoxShadow? elevation;
  final Key keyNavigationIcon;
  final Key keyAction;
  final String keyMoreMenu;
  final int navBarType;

  final Widget? flexibleSpace;
  final double? expandedHeight;
  final bool collapsible;
  final bool floating;
  final bool pinned;
  final bool snap;

  static const _typeDefault = 0;
  static const _typeCustom = 1;

  static const keyValueCollapsingNavBar = "Base_CollapsingNavBar";
  static const keyValueNavigationIcon = "NavBar_NavigationIcon";
  static const keyValueAction = "NavBar_Action";
  static const keyValueMoreMenu = "NavBar_MoreMenu";
  static const keyValueSeparatorLine = "NavBar_SeparatorLine";

  /// Collapsing navigation bar with base style
  ///
  /// * [title] Navigation title
  /// * [onNavigationTap] Navigation back icon on tap listener
  ///   Set to null to hide navigation back icon
  /// * [menus] Navigation menu on the right side
  /// * [onMenuTap] Navigation menu item on tap listener
  /// * [action] Action text on the right side
  ///   Text instead of icon from navigation menu
  /// * [onActionTap] Action text on tap listener
  /// * [showSeparatorLine] Whether show or hide separator line
  ///   on the bottom side
  /// * [elevation] Navigation bar elevation
  ///   See [ShadowToken]
  /// * [flexibleSpace] The content when navigation bar is expanded
  ///   See [FlexibleSpaceBar]
  /// * [floating] See [SliverAppBar.floating] for more info
  /// * [pinned] See [SliverAppBar.pinned] for more info
  /// * [snap] See [SliverAppBar.snap] for more info
  /// * [collapsible] Whether the navigation bar collapsible or keep expanded
  /// * [keyNavigationIcon] Navigation icon key
  /// * [keyAction] Navigation [action] key
  /// * [keyMoreMenu] Navigation menu more icon key
  const CollapsingNavBarComponent({
    Key? key = const Key(keyValueCollapsingNavBar),
    required this.title,
    this.onNavigationTap,
    this.menus = const [],
    this.onMenuTap,
    this.action,
    this.onActionTap,
    this.showSeparatorLine = true,
    this.elevation,
    this.flexibleSpace,
    this.expandedHeight,
    this.floating = false,
    this.pinned = true,
    this.snap = false,
    this.collapsible = true,
    this.keyNavigationIcon = const Key(keyValueNavigationIcon),
    this.keyAction = const Key(keyValueAction),
    this.keyMoreMenu = keyValueMoreMenu,
  }) : navBarType = _typeDefault,
      icon = null,
      titleWidget = null,
      super(key: key);

  /// Collapsing navigation bar with custom style
  ///
  /// * [title] Navigation title
  /// * [onIconTap] Navigation icon on tap listener
  ///   Set to null to hide navigation back icon
  /// * [menus] Navigation menu on the right side
  /// * [onMenuTap] Navigation menu item on tap listener
  /// * [action] Action text on the right side
  ///   Text instead of icon from navigation menu
  /// * [onActionTap] Action text on tap listener
  /// * [showSeparatorLine] Whether show or hide separator line
  ///   on the bottom side
  /// * [elevation] Navigation bar elevation
  ///   See [ShadowToken]
  /// * [flexibleSpace] The content when navigation bar is expanded
  ///   See [FlexibleSpaceBar]
  /// * [floating] See [SliverAppBar.floating] for more info
  /// * [pinned] See [SliverAppBar.pinned] for more info
  /// * [snap] See [SliverAppBar.snap] for more info
  /// * [collapsible] Whether the navigation bar collapsible or keep expanded
  /// * [keyNavigationIcon] Navigation icon key
  /// * [keyAction] Navigation [action] key
  /// * [keyMoreMenu] Navigation menu more icon key
  /// * [navigationIconEventAttributes] Additional attributes
  ///   for [UserEvent.click] when navigation icon tapped
  /// * [moreMenuEventAttributes] Additional attributes for [UserEvent.click]
  ///   when more menu icon tapped
  const CollapsingNavBarComponent.custom({
    Key? key = const Key(keyValueCollapsingNavBar),
    Widget? title,
    this.icon,
    VoidCallback? onIconTap,
    this.action,
    this.onActionTap,
    this.menus = const [],
    this.onMenuTap,
    this.showSeparatorLine = true,
    this.elevation,
    this.flexibleSpace,
    this.expandedHeight,
    this.floating = false,
    this.pinned = true,
    this.snap = false,
    this.collapsible = true,
    this.keyNavigationIcon = const Key(keyValueNavigationIcon),
    this.keyAction = const Key(keyValueAction),
    this.keyMoreMenu = keyValueMoreMenu,
  }) : navBarType = _typeCustom,
      title = "",
      titleWidget = title,
      onNavigationTap = onIconTap,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _CollapsingNavBarState();
}

class _CollapsingNavBarState extends State<CollapsingNavBarComponent> {

  @override
  Widget build(BuildContext context) {
    final showNavigationIcon = _isShowNavigationIcon();
    final navigationTitle = _getNavigationTitle();
    final showAction = _isShowAction();

    final content = Row(
      children: [
        // navigation icon
        if (showNavigationIcon) ...[
          _getNavigationIcon()
        ],
        // navigation title
        if (navigationTitle != null) ...[
          showNavigationIcon
            ? const SizedBox(width: 8) : const SizedBox(width: 16),
          navigationTitle,
          const SizedBox(width: 8),
        ],
        if (navigationTitle == null) ...[
          // keep action and menu bar alignment to right
          // when navigation title is empty
          const Spacer()
        ],
        // navigation action on the left side of navigation menu
        if (showAction) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ButtonLinkComponent(
              widget.action ?? "",
              key: widget.keyAction,
              onTap: widget.onActionTap
            )
          )
        ],
        // navigation menu on the right side
        MenuBarComponent(
          menu: widget.menus,
          maxMenu: _getMenuSize(showNavigationIcon, showAction),
          onMenuTap: widget.onMenuTap,
          moreMenu: MenuBarItem(
            id: widget.keyMoreMenu,
            icon: BaseIcon.moreVertical
          ),
        ),
        _getRightSpace()
      ],
    );

    final elevation = widget.elevation?.offset.dy ?? 0;
    final shadowColor = widget.elevation?.color;
    final collapsedHeight = widget.collapsible
      ? NavBarComponent.defaultHeight.toDouble() : widget.expandedHeight;
    return SliverAppBar(
      title: content,
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: ColorToken.theBackground,
      automaticallyImplyLeading: false,
      collapsedHeight: collapsedHeight,
      titleSpacing: 0,
      expandedHeight: widget.expandedHeight,
      flexibleSpace: widget.flexibleSpace,
      floating: widget.floating,
      pinned: widget.pinned,
      snap: widget.snap,
      foregroundColor: ColorToken.brand01,
      bottom: _getSeparatorLine(),
      forceElevated: !widget.collapsible,
    );
  }

  bool _isShowNavigationIcon() {
    if (widget.navBarType == CollapsingNavBarComponent._typeDefault) {
      return widget.onNavigationTap != null;
    }
    return widget.icon != null;
  }

  bool _isShowAction() {
    return widget.action != null && widget.action?.isNotEmpty == true;
  }

  int _getMenuSize(bool showNavigationIcon, bool showAction) {
    if (showAction) {
      return 1;
    } else if (showNavigationIcon && !showAction) {
      return 3;
    }
    // !showNavigationIcon && !showAction
    return 4;
  }

  double get _iconSize => IconComponent.sizeMajor;

  int get _iconBleedingArea => 12;

  Widget _getNavigationIcon() {
    final imageHolder = widget.navBarType == CollapsingNavBarComponent._typeDefault
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
    if (widget.navBarType == CollapsingNavBarComponent._typeDefault) {
      return Expanded(
        child: TextComponent(
          widget.title,
          style: TypographyToken.subheading18(),
          maxLines: 1
        )
      );
    }
    return widget.titleWidget;
  }

  Widget _getRightSpace() {
    if (widget.action != null && widget.menus.isEmpty) {
      return const SizedBox(width: 10);
    }
    return widget.menus.isNotEmpty
      ? const SizedBox(width: 8) : const SizedBox(width: 16);
  }

  PreferredSizeWidget? _getSeparatorLine() {
    if (widget.showSeparatorLine && widget.elevation == null) {
      return const PreferredSize(
        key: Key(CollapsingNavBarComponent.keyValueSeparatorLine),
        preferredSize: Size.fromHeight(SeparatorLineComponent.height),
        child: SeparatorLineComponent()
      );
    }
    return null;
  }
}