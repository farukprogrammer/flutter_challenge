import 'package:base_asset/base_asset.dart';
import 'package:flutter/material.dart';

import '../color/color_token.dart';
import '../container/tappable_container.dart';
import '../corner/corner_token.dart';
import '../icon/icon_component.dart';
import '../identifier/badge_general_component.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';

class MenuBarComponent extends StatelessWidget {
  final List<MenuBarItem> menu;
  final MenuBarItem? moreMenu;
  final void Function(MenuBarItem)? onMenuTap;
  final int maxMenu;

  static const double _iconSize = 36;
  static const keyMenuBarMoreMenu = "menubar-more-menu";

  /// Horizontal menu item, usually used in navigation bar.
  ///
  /// * [menu] Menu bar menu items
  /// * [moreMenu] More menu icon when [menu] size > [maxMenu]
  ///   Set to null to disable more menu
  /// * [maxMenu] Maximum menu size
  /// * [onMenuTap] Menu bar item on tap listener
  const MenuBarComponent({
    required this.menu,
    Key? key,
    this.moreMenu,
    this.onMenuTap,
    this.maxMenu = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final more = moreMenu;
    final showMoreMenu = isShowMoreMenu();
    final max = showMoreMenu ? maxMenu - 1 : maxMenu;
    final displayedMenu = menu.length < maxMenu ? menu.length : max;

    return Row(
      children: [
        for (int i = 0; i < displayedMenu; i++) ...[
          _getMenu(menu[i])
        ],
        if (showMoreMenu && more != null) ...[
          _getMoreMenu(context, more, displayedMenu)
        ]
      ],
    );
  }

  Widget _getMoreMenu(BuildContext context, MenuBarItem menu, int start) {
    return Tappable.gestureDetector(
      key: const Key(keyMenuBarMoreMenu),
      child: SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: Center(child: IconComponent.major(menu.icon, color: menu.iconColor,)),
      ),
      onTapDown: (details) => {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            0
          ),
          items: [
            for (int i = start; i < this.menu.length; i++) ...[
              PopupMenuItem(
                key: Key(this.menu[i].id),
                value: this.menu[i].id,
                onTap: () {
                  onMenuTap?.call(this.menu[i]);
                },
                child: TextComponent(
                  this.menu[i].title,
                  style: TypographyToken.body14()
                )
              )
            ]
          ],
        )
      }
    );
  }

  Widget _getMenu(MenuBarItem menu) {
    final badge = _isShowBadge(menu) ?
      BadgeGeneralComponent.regular(
        menu.badgeCount,
        key: Key("${menu.id}-badge")
      ) : null;

    return Tappable(
      key: Key(menu.id),
      child: SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: Stack(
          children: [
            Center(child: IconComponent.major(menu.icon, color: menu.iconColor,)),
            if (badge != null && !menu.hasCheck) ...[
              Align(
                alignment: Alignment.topRight,
                child: badge
              )
            ],
            if (menu.hasCheck) ...[
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: ColorToken.theBackground,
                        borderRadius: CornerToken.radiusCircle
                    ),
                    child: IconComponent(
                      BaseIcon.checkCircle,
                      size: 10,
                      color: ColorToken.iconSuccess,
                      key: Key("${menu.id}-check"),
                    ),
                  ),
                )
              )
            ]
          ],
        ),
      ),
      onTap: () => onMenuTap?.call(menu),
    );
  }

  bool isShowMoreMenu() {
    return menu.length > maxMenu && moreMenu != null;
  }

  bool _isShowBadge(MenuBarItem menu) {
    return menu.forceShowBadge || menu.badgeCount > 0;
  }
}

class MenuBarItem {
  final String icon;
  final Color? iconColor;
  final String title;
  final int badgeCount;
  final bool forceShowBadge;
  final String id;
  final bool hasCheck;

  /// Menu bar item for icon only
  /// * Support badge
  /// * [id] Unique id for each menu bar item
  /// * [icon] Menu bar item icon
  /// * [iconColor] Menu bar item icon color
  /// * [title] Menu bar item title when the menu item showed in more menu popup
  /// * [badgeCount] Badge count
  /// * [forceShowBadge] Show badge even when badge count equals to 0 (zero)
  /// * [hasCheck] Whether show check icon or hide check icon
  ///   Check icon has higher priority than badge
  ///   [hasCheck] true and [badgeCount] > 0 = only check icon will be shown
  const MenuBarItem({
    required this.id,
    required this.icon,
    this.iconColor,
    this.title = "",
    this.badgeCount = 0,
    this.forceShowBadge = false,
    this.hasCheck = false,
  });
}
