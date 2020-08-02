import 'dart:async';
import 'dart:collection';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/observations/Location.dart';
import 'package:biomonitoreoparticipativoapp/app/home/observations/location_data.dart';

class EventLocationPickScreen extends StatefulWidget {
  @override
  _EventLocationPickScreenState createState() =>
      _EventLocationPickScreenState();
}

class _EventLocationPickScreenState extends State<EventLocationPickScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(9.3384541, -83.4233894);
  // static const LatLng _center = const LatLng(37.77483, -122.41942);

  Set<Marker> markers = Set();
  List<Location> locations = <Location>[];
  String dropdownValue = 'Finca Esteban Cordero';

  // Location selectedLocation;

  Set<Polygon> _polygons = HashSet<Polygon>();
  BitmapDescriptor _markerIcon;

  List _pickedLocation;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/logo-aclap.png');
  }

  void _setPolygons() {
    // ACLAP
    List IN = [
      [-83.49122080907378, 9.613933099130998],
      [-83.41875986128208, 9.613552144806341],
      [-83.4189668602041, 9.379330587492305],
      [-83.45405978625452, 9.379071235715381],
      [-83.42267659194081, 9.367040770214478],
      [-83.39890227533789, 9.337693200458938],
      [-83.35102231783084, 9.350938136265972],
      [-83.34691312775657, 9.369547400101101],
      [-83.31945674570211, 9.384142663312016],
      [-83.22420557587249, 9.320533162372168],
      [-83.17739223298437, 9.326426471213832],
      [-83.13438411705927, 9.276227506982138],
      [-83.07329994030209, 9.250271037255727],
      [-83.07654586346361, 9.21988296882534],
      [-83.05562766054966, 9.195107464099454],
      [-83.0657147937705, 9.178069164312255],
      [-83.04658830378425, 9.160260061002976],
      [-82.99168282097135, 9.155168030651213],
      [-82.99612337578975, 9.12746791187696],
      [-82.9771677843355, 9.093905488287888],
      [-82.95118482625287, 9.0911653845385],
      [-82.93908609658567, 9.074749546344252],
      [-82.88730168917239, 9.087816664086642],
      [-82.87751647312466, 9.060440008649692],
      [-82.81755266076529, 9.029853889018815],
      [-82.79963188457444, 9.003431088544014],
      [-82.74830504804127, 8.991022517310975],
      [-82.71712206886394, 8.949988603256397],
      [-82.71221374655823, 8.922069990124617],
      [-82.74886244574888, 8.906403295677936],
      [-82.7609471679608, 8.885150769016539],
      [-82.85483310437495, 8.85617788529439],
      [-82.88314712333708, 8.831714916521241],
      [-82.8629655108865, 8.813770558425201],
      [-82.89059138622763, 8.791457770842278],
      [-82.89262225096012, 8.771868424284836],
      [-82.91940417964217, 8.765148253914457],
      [-82.90321016478393, 8.733732564437538],
      [-82.91018548940367, 8.696712932959363],
      [-82.95993416863584, 8.695563161699976],
      [-82.9833917368313, 8.733403148653114],
      [-82.98336560216221, 8.757225901768653],
      [-82.96918724678906, 8.764043449241122],
      [-82.97945873335452, 8.782150086545702],
      [-83.02932413485775, 8.788595152583488],
      [-83.04667316714433, 8.77478675358318],
      [-83.09597371373678, 8.775053639241063],
      [-83.12934179628375, 8.785454060666243],
      [-83.23528877883281, 8.884345353403488],
      [-83.24776401868624, 8.914778408703588],
      [-83.31879594783568, 8.945256303294293],
      [-83.35654260422609, 8.944866363120285],
      [-83.37305306634322, 8.980286943911755],
      [-83.40925523150177, 8.995599362615634],
      [-83.41700549261239, 8.976689371525607],
      [-83.46916828545103, 8.995964952628068],
      [-83.51600511145861, 9.044623228002589],
      [-83.55957715622147, 9.053039888722218],
      [-83.54924282813771, 9.082762864426828],
      [-83.67245097940206, 9.154117354350774],
      [-83.66903026658245, 9.182575708333351],
      [-83.70596739846445, 9.225212344609513],
      [-83.7346208675405, 9.223750641755881],
      [-83.75641842914284, 9.24409095822484],
      [-83.75271600387597, 9.22179358208757],
      [-83.76808903877694, 9.215496513601442],
      [-83.84231619417179, 9.256624687041517],
      [-83.85998437668837, 9.307378921745714],
      [-83.84151727532256, 9.343006736527656],
      [-83.89056020450829, 9.361928554560528],
      [-83.90925813344955, 9.40485712518903],
      [-83.93439301485228, 9.39914405291054],
      [-83.93606954376607, 9.38707853196917],
      [-83.96177605280525, 9.395914569312273],
      [-83.96152962428094, 9.409768908862429],
      [-84.002574780834, 9.44428670934449],
      [-83.98608301548369, 9.468210925988231],
      [-83.95285523650173, 9.430807192163757],
      [-83.94002344683635, 9.490425464215676],
      [-83.89621682110464, 9.497701274491114],
      [-83.84810777512543, 9.534896035667105],
      [-83.82513035277465, 9.531005483243085],
      [-83.77622929793789, 9.59845884492324],
      [-83.75259920833312, 9.559747031094016],
      [-83.68438381231502, 9.551762450888432],
      [-83.62835421288673, 9.591421502101806],
      [-83.62828762630875, 9.61357757239451],
      [-83.49122080907378, 9.613933099130998],
    ];

    List<LatLng> polygonLatLongs = List<LatLng>();

    for (var i = 0; i < IN.length; i++) {
      var ltlng = LatLng(IN[i][1], IN[i][0]);
      polygonLatLongs.add(ltlng);
    }

    _polygons.add(
      Polygon(
        polygonId: PolygonId("ACLAP"),
        points: polygonLatLongs,
        fillColor: Color.fromARGB(10, 66, 165, 245),
        strokeColor: Colors.blueAccent,
        strokeWidth: 3,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 15,
          tilt: 50.0,
          bearing: 45.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ProviderLocation providerLocation = Provider.of<ProviderLocation>(context);

    var selectedLocation = 'Ninguna finca';

    markers.addAll(
      [
        Marker(
          markerId: MarkerId('01'),
          position: LatLng(9.43039, -83.84320),
          infoWindow: InfoWindow(
            title: "SA-01	Savegre abajo-01",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.84320, 9.43039, 'SA-01	Savegre abajo-01'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('02'),
          position: LatLng(9.43362, -83.85632),
          infoWindow: InfoWindow(
            title: "SA-02 Savegre abajo-02",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.85632, 9.43362, 'SA-02 Savegre abajo-02'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('03'),
          position: LatLng(9.48405, -83.80704),
          infoWindow: InfoWindow(
            title: "LA-01 Los Ángeles-01",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.80704, 9.48405, 'LA-01 Los Ángeles-01'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('04'),
          position: LatLng(9.50930, -83.79451),
          infoWindow: InfoWindow(
            title: "LA-02 Los Ángeles-02",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.79451, 9.50930, 'LA-02 Los Ángeles-02'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('05'),
          position: LatLng(9.48670, -83.80604),
          infoWindow: InfoWindow(
            title: "LA-03 Los Ángeles-03",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.80604, 9.48670, 'LA-03 Los Ángeles-03'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('06'),
          position: LatLng(9.50198, -83.69381),
          infoWindow: InfoWindow(
            title: "JD-02 El Jardín-02",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.69381, 9.50198, 'JD-02 El Jardín-02'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('07'),
          position: LatLng(9.53331, -83.70460),
          infoWindow: InfoWindow(
            title: "JD-03 El Jardín-03",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.70460, 9.53331, 'JD-03 El Jardín-03'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('08'),
          position: LatLng(9.54667, -83.71342),
          infoWindow: InfoWindow(
            title: "JD-01 El Jardín-01",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.71342, 9.54667, 'JD-01 El Jardín-01'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('09'),
          position: LatLng(9.46367, -83.59874),
          infoWindow: InfoWindow(
            title: "SG-01 San Gerardo-01",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.59874, 9.46367, 'SG-01 San Gerardo-01'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('10'),
          position: LatLng(9.47210, -83.57746),
          infoWindow: InfoWindow(
            title: "SG-02 San Gerardo-02",
          ),
          onTap: () {
            setState(() {
              _pickedLocation = [-83.57746, 9.47210, 'SG-02 San Gerardo-02'];
            });
          },
        ),
        Marker(
          markerId: MarkerId('11'),
          position: LatLng(9.34146, -83.50421),
          infoWindow: InfoWindow(
            title: "Sendero Zaddy",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Zaddy');
          },
        ),
        Marker(
          markerId: MarkerId('12'),
          position: LatLng(9.36354, -83.49639),
          infoWindow: InfoWindow(
            title: "Sendero Ena",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Ena');
          },
        ),
        Marker(
          markerId: MarkerId('13'),
          position: LatLng(9.28686, -83.45692),
          infoWindow: InfoWindow(
            title: "Sendero Perica",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Perica');
          },
        ),
        Marker(
          markerId: MarkerId('14'),
          position: LatLng(9.23980, -83.37892),
          infoWindow: InfoWindow(
            title: "Guadalajara",
          ),
          onTap: () {
            Navigator.pop(context, 'Guadalajara');
          },
        ),
        Marker(
          markerId: MarkerId('15'),
          position: LatLng(9.25712, -83.39225),
          infoWindow: InfoWindow(
            title: "Sendero Mirador",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Mirador');
          },
        ),
        Marker(
          markerId: MarkerId('16'),
          position: LatLng(9.27587, -83.37080),
          infoWindow: InfoWindow(
            title: "Ruta las aves",
          ),
          onTap: () {
            Navigator.pop(context, 'Ruta las aves');
          },
        ),
        Marker(
          markerId: MarkerId('17'),
          position: LatLng(9.23270, -83.30128),
          infoWindow: InfoWindow(
            title: "Ujarrás",
          ),
          onTap: () {
            Navigator.pop(context, 'Ujarrás');
          },
        ),
        Marker(
          markerId: MarkerId('18'),
          position: LatLng(9.26302, -83.33883),
          infoWindow: InfoWindow(
            title: "Sendero Zapotal",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Zapotal');
          },
        ),
        Marker(
          markerId: MarkerId('19'),
          position: LatLng(9.08958, -83.11559),
          infoWindow: InfoWindow(
            title: "Sendero Parcelas",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Parcelas');
          },
        ),
        Marker(
          markerId: MarkerId('20'),
          position: LatLng(9.11940, -83.06877),
          infoWindow: InfoWindow(
            title: "Sendero Huacas",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Huacas');
          },
        ),
        Marker(
          markerId: MarkerId('21'),
          position: LatLng(9.02319, -83.05455),
          infoWindow: InfoWindow(
            title: "Sendero 1",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero 1');
          },
        ),
        Marker(
          markerId: MarkerId('22'),
          position: LatLng(9.03876, -83.03779),
          infoWindow: InfoWindow(
            title: "Finca María Isabel",
          ),
          onTap: () {
            Navigator.pop(context, 'Finca María Isabel');
          },
        ),
        Marker(
          markerId: MarkerId('23'),
          position: LatLng(9.03426, -83.04131),
          infoWindow: InfoWindow(
            title: "Sendero Biolley",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Biolley');
          },
        ),
        Marker(
          markerId: MarkerId('24'),
          position: LatLng(9.01146, -83.02309),
          infoWindow: InfoWindow(
            title: "Sendero Colorado",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Colorado');
          },
        ),
        Marker(
          markerId: MarkerId('25'),
          position: LatLng(9.00549, -83.00901),
          infoWindow: InfoWindow(
            title: "Sendero Asoprola",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Asoprola');
          },
        ),
        Marker(
          markerId: MarkerId('26'),
          position: LatLng(9.13701, -83.19557),
          infoWindow: InfoWindow(
            title: "Sendero Cabagra",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Cabagra');
          },
        ),
        Marker(
          markerId: MarkerId('27'),
          position: LatLng(8.93879, -83.20337),
          infoWindow: InfoWindow(
            title: "Sendero Chánguena",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Chánguena');
          },
        ),
        Marker(
          markerId: MarkerId('28'),
          position: LatLng(8.95203, -82.93996),
          infoWindow: InfoWindow(
            title: "Sendero Pittier",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Pittier');
          },
        ),
        Marker(
          markerId: MarkerId('29'),
          position: LatLng(8.88802, -82.81732),
          infoWindow: InfoWindow(
            title: "Sendero Tablas",
          ),
          onTap: () {
            Navigator.pop(context, 'Sendero Tablas');
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de localidad'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    print(
                        '$_pickedLocation: ${_pickedLocation[0]} ${_pickedLocation[1]} ${_pickedLocation[2]}');
                    Navigator.of(context).pop(_pickedLocation);
                  },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.hybrid,
      onMapCreated: _onMapCreated,
      markers: markers,
      polygons: _polygons,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 9.0,
      ),
    );
  }

  Widget _buildContainer() {
    return Positioned(
      top: 5.0,
      right: 15.0,
      left: 15.0,
      child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Nombre de la localidad',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                suffixIcon: IconButton(
                    icon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: null,
                  iconSize: 30.0,
                )),
              ),
            ),
            suggestionsCallback: (pattern) {
              return LocationData.findByFilter(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(suggestion.name),
                subtitle: Text(
                    '${suggestion.decimalLongitude}, ${suggestion.decimalLatitude}'),
              );
            },
            onSuggestionSelected: (suggestion) {
              // This when someone click the items
              print(suggestion);
              _gotoLocation(
                suggestion.decimalLatitude,
                suggestion.decimalLongitude,
              );
            },
          )),
    );
  }
}
