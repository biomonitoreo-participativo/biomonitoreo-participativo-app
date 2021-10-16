import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/services/auth.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/landing_page.dart';

import 'app/home/models/event_taxa_cart.dart';
import 'app/home/models/group.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (_) => Auth()),
        ChangeNotifierProvider.value(
          value: Taxa(),
        ),
        ChangeNotifierProvider.value(
          value: EventTaxaCart(),
        ),
        ChangeNotifierProvider.value(
          value: OpportunisticObservationTaxonCart(),
        ),
        ChangeNotifierProvider.value(
          value: Group(),
        ),
      ],
      // builder: (context) => Auth(),
      child: MaterialApp(
        title: 'Monitoreo biológico participativo',
        theme: ThemeData(
          // primarySwatch: Colors.indigo,
          primaryColor: Color.fromRGBO(117, 164, 103, 1),
        ),
        home: LandingPage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'),
        ],
      ),
    );
  }
}
