import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/taxon_data.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/app/landing_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/home/observations/input_observation_quantity.dart';
import 'app/home/observations/observation_data.dart';

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
          value: OpportunisticObservationTaxonCart(),
        ),
        ChangeNotifierProvider.value(
          value: ObservationData(),
        ),
        ChangeNotifierProvider.value(
          value: InputObservationQuantity(),
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
