import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:biomonitoreoparticipativoapp/screens/select_datetime_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  static const String id = 'select_location_screen';

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(9.3384541, -83.4233894);

  Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    markers.addAll([
      Marker(
        markerId: MarkerId('01'),
        position: LatLng(9.531, -83.714),
        infoWindow: InfoWindow(
            title: "Finca Seis Ancestros",
            onTap: () {
              print('Seis');
            }),
      ),
      Marker(
        markerId: MarkerId('02'),
        position: LatLng(8.994, -82.997),
        infoWindow: InfoWindow(
            title: "Hamacas",
            onTap: () {
              print('Hamacas');
            }),
      ),
      Marker(
        markerId: MarkerId('03'),
        position: LatLng(9.488, -83.612),
        infoWindow: InfoWindow(
            title: "Reserva Río Blanco",
            onTap: () {
              print('Río Blanco');
            }),
      ),
      Marker(
        markerId: MarkerId('04'),
        position: LatLng(9.43, -83.843),
        infoWindow: InfoWindow(
            title: "Savegre Ecolodge",
            onTap: () {
              print('Savegre Ecolodge');
            }),
      ),
      Marker(
        markerId: MarkerId('05'),
        position: LatLng(9.133, -83.167),
        infoWindow: InfoWindow(
            title: "Cabagra",
            onTap: () {
              print('Cabagra');
            }),
      ),
      Marker(
        markerId: MarkerId('05'),
        position: LatLng(9.12, -83.068),
        infoWindow: InfoWindow(
            title: "Tres Colinas",
            onTap: () {
              print('Tres Colinas');
            }),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de localidad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 9.0,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Presionado');
          Navigator.pushNamed(context, SelectDateTimeScreen.id);
        },
        label: Text('Seleccionar'),
      ),
    );
  }
}
