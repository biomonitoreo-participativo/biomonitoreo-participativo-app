import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observations_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/app/home/account/account_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/cupertino_home_scaffold.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/events_list_screen.dart';
import 'package:biomonitoreoparticipativoapp/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.events;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.events: GlobalKey<NavigatorState>(),
    //TabItem.occurrences: GlobalKey<NavigatorState>(),
    //TabItem.localities: GlobalKey<NavigatorState>(),
    TabItem.occurrences2: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.events: (_) => EventsListScreen(),
      //TabItem.occurrences: (context) => EntriesPage.create(context),
      //TabItem.localities: (_) => LocalitiesPage(),
      //TabItem.occurrences2: (_) => ObservationsScreen(),
      TabItem.occurrences2: (_) => OpportunisticObservationsListScreen(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
