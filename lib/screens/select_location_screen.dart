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
        position: LatLng(9.43039, -83.84320),
        infoWindow: InfoWindow(
            title: "Finca Esteban Cordero",
            onTap: () {
              print('Finca Esteban Cordero');
            }),
      ),
      Marker(
        markerId: MarkerId('02'),
        position: LatLng(9.43362, -83.85632),
        infoWindow: InfoWindow(
            title: "Finca de Victor",
            onTap: () {
              print('Hamacas');
            }),
      ),
      Marker(
        markerId: MarkerId('03'),
        position: LatLng(9.48405, -83.80704),
        infoWindow: InfoWindow(
            title: "Finca de Andrey y Sonia",
            onTap: () {
              print('Río Blanco');
            }),
      ),
      Marker(
        markerId: MarkerId('04'),
        position: LatLng(9.50930, -83.79451),
        infoWindow: InfoWindow(
            title: "Finca de Rafael",
            onTap: () {
              print('Savegre Ecolodge');
            }),
      ),
      Marker(
        markerId: MarkerId('05'),
        position: LatLng(9.48670, -83.80604),
        infoWindow: InfoWindow(
            title: "Sendero 3",
            onTap: () {
              print('Cabagra');
            }),
      ),
      Marker(
        markerId: MarkerId('06'),
        position: LatLng(9.50198, -83.69381),
        infoWindow: InfoWindow(
            title: "Finca Cosme Gamboa",
            onTap: () {
              print('Tres Colinas');
            }),
      ),
      Marker(
        markerId: MarkerId('07'),
        position: LatLng(9.53331, -83.70460),
        infoWindow: InfoWindow(
            title: "Finca de Errol Salazar",
            onTap: () {
              print('Finca de Errol Salazar');
            }),
      ),
      Marker(
        markerId: MarkerId('08'),
        position: LatLng(9.54667, -83.71342),
        infoWindow: InfoWindow(
            title: "Finca Martín Salazar",
            onTap: () {
              print('Finca Martín Salazar');
            }),
      ),
      Marker(
        markerId: MarkerId('09'),
        position: LatLng(9.46367, -83.59874),
        infoWindow: InfoWindow(
            title: "Camino San Gerardo Los Ángeles",
            onTap: () {
              print('Camino San Gerardo Los Ángeles');
            }),
      ),
      Marker(
        markerId: MarkerId('10'),
        position: LatLng(9.47210, -83.57746),
        infoWindow: InfoWindow(
            title: "Reserva Cloud Bridge",
            onTap: () {
              print('Reserva Cloud Bridge');
            }),
      ),
      Marker(
        markerId: MarkerId('11'),
        position: LatLng(9.34146, -83.50421),
        infoWindow: InfoWindow(
            title: "Sendero Zaddy",
            onTap: () {
              print('Sendero Zaddy');
            }),
      ),
      Marker(
        markerId: MarkerId('12'),
        position: LatLng(9.36354, -83.49639),
        infoWindow: InfoWindow(
            title: "Sendero Ena",
            onTap: () {
              print('Sendero Ena');
            }),
      ),
      Marker(
        markerId: MarkerId('13'),
        position: LatLng(9.28686, -83.45692),
        infoWindow: InfoWindow(
            title: "Sendero Perica",
            onTap: () {
              print('Sendero Perica');
            }),
      ),
      Marker(
        markerId: MarkerId('14'),
        position: LatLng(9.23980, -83.37892),
        infoWindow: InfoWindow(
            title: "Guadalajara",
            onTap: () {
              print('Guadalajara');
            }),
      ),
      Marker(
        markerId: MarkerId('15'),
        position: LatLng(9.25712, -83.39225),
        infoWindow: InfoWindow(
            title: "Sendero Mirador",
            onTap: () {
              print('Sendero Mirador');
            }),
      ),
      Marker(
        markerId: MarkerId('16'),
        position: LatLng(9.27587, -83.37080),
        infoWindow: InfoWindow(
            title: "Ruta las aves",
            onTap: () {
              print('Ruta las aves');
            }),
      ),
      Marker(
        markerId: MarkerId('17'),
        position: LatLng(9.23270, -83.30128),
        infoWindow: InfoWindow(
            title: "Ujarrás",
            onTap: () {
              print('Ujarrás');
            }),
      ),
      Marker(
        markerId: MarkerId('18'),
        position: LatLng(9.26302, -83.33883),
        infoWindow: InfoWindow(
            title: "Sendero Zapotal",
            onTap: () {
              print('Sendero Zapotal');
            }),
      ),
      Marker(
        markerId: MarkerId('19'),
        position: LatLng(9.08958, -83.11559),
        infoWindow: InfoWindow(
            title: "Sendero Parcelas",
            onTap: () {
              print('Sendero Parcelas');
            }),
      ),
      Marker(
        markerId: MarkerId('20'),
        position: LatLng(9.11940, -83.06877),
        infoWindow: InfoWindow(
            title: "Sendero Huacas",
            onTap: () {
              print('Sendero Huacas');
            }),
      ),
      Marker(
        markerId: MarkerId('21'),
        position: LatLng(9.02319, -83.05455),
        infoWindow: InfoWindow(
            title: "Sendero 1",
            onTap: () {
              print('Sendero 1');
            }),
      ),
      Marker(
        markerId: MarkerId('22'),
        position: LatLng(9.03876, -83.03779),
        infoWindow: InfoWindow(
            title: "Finca María Isabel",
            onTap: () {
              print('Finca María Isabel');
            }),
      ),
      Marker(
        markerId: MarkerId('23'),
        position: LatLng(9.03426, -83.04131),
        infoWindow: InfoWindow(
            title: "Sendero Biolley",
            onTap: () {
              print('Sendero Biolley');
            }),
      ),
      Marker(
        markerId: MarkerId('24'),
        position: LatLng(9.01146, -83.02309),
        infoWindow: InfoWindow(
            title: "Sendero Colorado",
            onTap: () {
              print('Sendero Colorado');
            }),
      ),
      Marker(
        markerId: MarkerId('25'),
        position: LatLng(9.00549, -83.00901),
        infoWindow: InfoWindow(
            title: "Sendero Asoprola",
            onTap: () {
              print('Sendero Asoprola');
            }),
      ),
      Marker(
        markerId: MarkerId('26'),
        position: LatLng(9.13701, -83.19557),
        infoWindow: InfoWindow(
            title: "Sendero Cabagra",
            onTap: () {
              print('Sendero Cabagra');
            }),
      ),
      Marker(
        markerId: MarkerId('27'),
        position: LatLng(8.93879, -83.20337),
        infoWindow: InfoWindow(
            title: "Sendero Chánguena",
            onTap: () {
              print('Sendero Chánguena');
            }),
      ),
      Marker(
        markerId: MarkerId('28'),
        position: LatLng(8.95203, -82.93996),
        infoWindow: InfoWindow(
            title: "Sendero Pittier",
            onTap: () {
              print('Sendero Pittier');
            }),
      ),
      Marker(
        markerId: MarkerId('29'),
        position: LatLng(8.88802, -82.81732),
        infoWindow: InfoWindow(
            title: "Sendero Tablas",
            onTap: () {
              print('Sendero Tablas');
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
