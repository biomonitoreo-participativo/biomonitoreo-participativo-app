import 'package:flutter/material.dart';

enum TabItem { events, occurrences, localities, occurrences2, account }

class TabItemData {
  final String title;
  final IconData icon;

  const TabItemData({@required this.title, @required this.icon});

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.events: TabItemData(title: 'Eventos', icon: Icons.directions_walk),
    TabItem.occurrences: TabItemData(title: 'Resumen', icon: Icons.menu),
    TabItem.localities: TabItemData(title: 'Localidades', icon: Icons.place),
    TabItem.occurrences2:
        TabItemData(title: 'Observaciones', icon: Icons.remove_red_eye),
    TabItem.account: TabItemData(title: 'Usuario', icon: Icons.person),
  };
}
