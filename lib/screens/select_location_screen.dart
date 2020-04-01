import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:biomonitoreoparticipativoapp/screens/select_datetime_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  static const String id = 'select_location_screen';

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localidad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                LocationResult result = await showLocationPicker(
                  context,
                  'AIzaSyBL6mEckyJoCF2DqnbU6X3xtSUSzWnt9Is',
                  initialCenter: LatLng(10, -84),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                  myLocationButtonEnabled: true,
                  layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                );
                print("result = $result");
                setState(() => _pickedLocation = result);
              },
              child: Text('Pick location'),
            ),
            Text(_pickedLocation.toString()),
            SizedBox(
              height: 80.0,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RoundedButton(
                  title: 'Seleccionar la fecha y la hora',
                  colour: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, SelectDateTimeScreen.id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
