import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../nav_tabs.dart';

class BottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  const BottomNavigation({Key key, this.currentTab, this.onSelectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: TabItem.values.indexOf(currentTab),
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.roster),
        _buildItem(TabItem.database),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final NavTab tab = tabName[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        tab.icon,
      ),
      label: tab.label,
    );
  }
}
