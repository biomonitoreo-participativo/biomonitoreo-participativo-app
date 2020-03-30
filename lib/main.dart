import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/observations_screen.dart';
import 'package:provider/provider.dart';
import 'models/observation_data.dart';

void main() => runApp(ParticipatoryBioMonitoring());

class ParticipatoryBioMonitoring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ObservationData(),
      child: MaterialApp(
        title: 'Biomonitoreo participativo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ObservationsScreen.id: (context) => ObservationsScreen(),
        },
      ),
    );
  }
}
