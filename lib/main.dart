import 'package:biomonitoreoparticipativoapp/screens/pdf_viewer_screen.dart';
import 'package:biomonitoreoparticipativoapp/widgets/observations_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/observation_data.dart';
import 'models/provider_datetime.dart';
import 'models/provider_location.dart';
import 'models/provider_observer.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/select_datetime_screen.dart';
import 'screens/select_location_screen.dart';
import 'screens/observations_screen.dart';
import 'screens/summary_screen.dart';
import 'models/input_observation_quantity.dart';

void main() => runApp(ParticipatoryBioMonitoring());

class ParticipatoryBioMonitoring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ObservationData(),
        ),
        ChangeNotifierProvider.value(
          value: InputObservationQuantity(),
        ),
        ChangeNotifierProvider.value(
          value: ProviderLocation(),
        ),
        ChangeNotifierProvider.value(
          value: ProviderDateTime(),
        ),
        ChangeNotifierProvider.value(
          value: ProviderObserver(),
        ),
      ],
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
          SelectDateTimeScreen.id: (context) => SelectDateTimeScreen(),
          SelectLocationScreen.id: (context) => SelectLocationScreen(),
          ObservationsScreen.id: (context) => ObservationsScreen(),
          SummaryScreen.id: (context) => SummaryScreen(),
          PDFViewerScreen.id: (context) => PDFViewerScreen(),
        },
      ),
    );
  }
}
