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
          value: ObservationData(),
        ),
        ChangeNotifierProvider.value(
          value: InputObservationQuantity(),
        ),
      ],
      // builder: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
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
