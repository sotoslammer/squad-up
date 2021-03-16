import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {
  roster,
  database,
}

const Map<TabItem, NavTab> tabName = {
  TabItem.roster: const NavTab('Roster', Icons.star),
  TabItem.database: const NavTab('Database', Icons.list),
};



class NavTab {
  final String label;
  final IconData icon;

  const NavTab(this.label, this.icon);
}
