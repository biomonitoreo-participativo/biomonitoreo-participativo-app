import 'dart:async';
import 'dart:collection';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/group.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/location.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/location_data.dart';


class EventLocationPickScreen extends StatefulWidget {
  final List<double> initialLocality;

  EventLocationPickScreen({
    this.initialLocality,
  });

  @override
  _EventLocationPickScreenState createState() =>
      _EventLocationPickScreenState();
}

class _EventLocationPickScreenState extends State<EventLocationPickScreen> {
  Completer<GoogleMapController> _controller = Completer();

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

    // ACOSA
    List IN_ACOSA = [
      [-82.90321383, 8.73374146],
      [-82.8297529, 8.634711],
      [-82.83945931, 8.48018378],
      [-83.05189098, 8.33451376],
      [-82.99061868, 8.27126165],
      [-82.94221309, 8.27179192],
      [-82.8860846, 8.10847695],
      [-82.9004578, 8.04008937],
      [-82.90299418, 8.1136665],
      [-82.96779927, 8.23354421],
      [-83.14651085, 8.36722777],
      [-83.09247969, 8.45012072],
      [-83.180732, 8.61001653],
      [-83.1522604, 8.60954547],
      [-83.16721707, 8.58840864],
      [-83.16240817, 8.57785643],
      [-83.12388344, 8.60084992],
      [-83.1716779, 8.64289767],
      [-83.18230351, 8.62182174],
      [-83.29533235, 8.653638],
      [-83.32917322, 8.68056626],
      [-83.32384965, 8.7180337],
      [-83.38103979, 8.74660734],
      [-83.48434854, 8.71187572],
      [-83.3988905, 8.59229313],
      [-83.28449394, 8.54162012],
      [-83.29151271, 8.37488942],
      [-83.45844479, 8.44153525],
      [-83.56624373, 8.44054691],
      [-83.73181438, 8.59181857],
      [-83.71029198, 8.68520323],
      [-83.65395063, 8.69792242],
      [-83.64747943, 8.76777539],
      [-83.61876784, 8.77426072],
      [-83.65245048, 8.79422648],
      [-83.58045551, 8.84758797],
      [-83.6178721, 8.874738],
      [-83.5921647, 8.89216545],
      [-83.62224232, 8.91783295],
      [-83.66026578, 9.06537884],
      [-83.64789146, 9.05025241],
      [-83.63294465, 9.04112712],
      [-83.62581957, 9.04376806],
      [-83.77922701, 9.19293259],
      [-83.84478797, 9.22071984],
      [-83.85880643, 9.27691321],
      [-83.80016261, 9.22397503],
      [-83.75646936, 9.21757726],
      [-83.74803743, 9.24433256],
      [-83.70597071, 9.22522191],
      [-83.67245435, 9.15412689],
      [-83.54955037, 9.08309157],
      [-83.5595806, 9.05304933],
      [-83.46939281, 8.99609597],
      [-83.41700899, 8.97669869],
      [-83.40269213, 8.99469079],
      [-83.35654612, 8.94487563],
      [-83.24776756, 8.91478759],
      [-83.15988389, 8.80264689],
      [-83.09597735, 8.77506269],
      [-82.97946236, 8.78215904],
      [-82.9833954, 8.73341211],
      [-82.94892187, 8.69057175],
      [-82.91018918, 8.69672183],
      [-82.90321383, 8.73374146],
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


    List<LatLng> polygonLatLongs_acosa = List<LatLng>();

    for (var i = 0; i < IN_ACOSA.length; i++) {
      var ltlng = LatLng(IN_ACOSA[i][1], IN_ACOSA[i][0]);
      polygonLatLongs_acosa.add(ltlng);
    }

    _polygons.add(
      Polygon(
        polygonId: PolygonId("ACOSA"),
        points: polygonLatLongs_acosa,
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
          zoom: 16,
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

    Group group = Provider.of<Group>(context);

    if (group.group == "ACLAP") {
      markers.addAll(
        [
          Marker(
            markerId: MarkerId('01'),
            position: LatLng(9.00549542, -83.0090092),
            infoWindow: InfoWindow(
              title: "AB-01 Altamira de Biolley-01",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.0090092,
                  9.00549542,
                  'AB-01 Altamira de Biolley-01'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('02'),
            position: LatLng(9.28438765, -83.4516672),
            infoWindow: InfoWindow(
              title: "AV-02 Altamira de Vocán",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.4516672,
                  9.28438765,
                  'AV-02 Altamira de Vocán'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('03'),
            position: LatLng(9.28729506, -83.4602387),
            infoWindow: InfoWindow(
              title: "AV-01 Altamira de Volcán",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.4602387,
                  9.28729506,
                  'AV-01 Altamira de Volcán'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('04'),
            position: LatLng(9.0231913, -83.0545614),
            infoWindow: InfoWindow(
              title: "BI-01 Biolley",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.0545614, 9.0231913, 'BI-01 Biolley'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('05'),
            position: LatLng(9.03876183, -83.037795),
            infoWindow: InfoWindow(
              title: "BI-02 Biolley",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.037795, 9.03876183, 'BI-02 Biolley'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('06'),
            position: LatLng(9.03425048, -83.0413176),
            infoWindow: InfoWindow(
              title: "BI-03 Biolley",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.0413176, 9.03425048, 'BI-03 Biolley'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('07'),
            position: LatLng(9.13279284, -83.2036868),
            infoWindow: InfoWindow(
              title: "CB-01 Cabagra",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.2036868, 9.13279284, 'CB-01 Cabagra'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('08'),
            position: LatLng(9.12137815, -83.1557111),
            infoWindow: InfoWindow(
              title: "CB-03 Cabagra",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.1557111, 9.12137815, 'CB-03 Cabagra'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('09'),
            position: LatLng(8.91894041, -83.2067085),
            infoWindow: InfoWindow(
              title: "CH-03 Chánguena",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.2067085, 8.91894041, 'CH-03 Chánguena'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('10'),
            position: LatLng(8.91168574, -83.163918),
            infoWindow: InfoWindow(
              title: "CH-01 Chánguena - Las Nubes",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.163918,
                  8.91168574,
                  'CH-01 Chánguena - Las Nubes'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('11'),
            position: LatLng(8.90642376, -83.1720855),
            infoWindow: InfoWindow(
              title: "CH-02 Chánguena - Pilón",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.1720855,
                  8.90642376,
                  'CH-02 Chánguena - Pilón'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('12'),
            position: LatLng(9.01146405, -83.0230982),
            infoWindow: InfoWindow(
              title: "AB-02 Colorado",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.0230982, 9.01146405, 'AB-02 Colorado'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('13'),
            position: LatLng(9.54753401, -83.7173239),
            infoWindow: InfoWindow(
              title: "JD-01 El Jardín",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.7173239, 9.54753401, 'JD-01 El Jardín'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('14'),
            position: LatLng(9.50310902, -83.6977546),
            infoWindow: InfoWindow(
              title: "JD-02 El Jardín",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.6977546, 9.50310902, 'JD-02 El Jardín'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('15'),
            position: LatLng(9.53414089, -83.7086084),
            infoWindow: InfoWindow(
              title: "JD-03 El Jardín",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.7086084, 9.53414089, 'JD-03 El Jardín'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('16'),
            position: LatLng(9.24059771, -83.3868519),
            infoWindow: InfoWindow(
              title: "RC-01 Guadalajara",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.3868519, 9.24059771, 'RC-01 Guadalajara'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('17'),
            position: LatLng(9.09028874, -83.1265134),
            infoWindow: InfoWindow(
              title: "LU-01 La Luchita",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.1265134, 9.09028874, 'LU-01 La Luchita'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('18'),
            position: LatLng(9.48537348, -83.8130617),
            infoWindow: InfoWindow(
              title: "LA-01 Los Ángeles",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.8130617, 9.48537348, 'LA-01 Los Ángeles'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('19'),
            position: LatLng(9.51023701, -83.7973644),
            infoWindow: InfoWindow(
              title: "LA-02 Los Ángeles",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.7973644, 9.51023701, 'LA-02 Los Ángeles'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('20'),
            position: LatLng(9.48754174, -83.8086589),
            infoWindow: InfoWindow(
              title: "LA-03 Los Ángeles",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.8086589, 9.48754174, 'LA-03 Los Ángeles'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('21'),
            position: LatLng(8.92135315, -82.9573403),
            infoWindow: InfoWindow(
              title: "PT-01 Pittier",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-82.9573403, 8.92135315, 'PT-01 Pittier'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('22'),
            position: LatLng(8.91132719, -82.9770522),
            infoWindow: InfoWindow(
              title: "PT-02 Pittier",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-82.9770522, 8.91132719, 'PT-02 Pittier'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('23'),
            position: LatLng(9.46448482, -83.6041212),
            infoWindow: InfoWindow(
              title: "SG-01 San Gerardo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.6041212, 9.46448482, 'SG-01 San Gerardo'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('24'),
            position: LatLng(9.4728713, -83.5831321),
            infoWindow: InfoWindow(
              title: "SG-02 San Gerardo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.5831321, 9.4728713, 'SG-02 San Gerardo'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('25'),
            position: LatLng(9.34226752, -83.5106789),
            infoWindow: InfoWindow(
              title: "SJ-01 San Jerónimo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.5106789, 9.34226752, 'SJ-01 San Jerónimo'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('26'),
            position: LatLng(9.3643246, -83.5029965),
            infoWindow: InfoWindow(
              title: "SJ-02 San Jerónimo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.5029965, 9.3643246, 'SJ-02 San Jerónimo'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('27'),
            position: LatLng(9.27666952, -83.3788999),
            infoWindow: InfoWindow(
              title: "RC-03 Santa María",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.3788999, 9.27666952, 'RC-03 Santa María'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('28'),
            position: LatLng(9.25789457, -83.4000502),
            infoWindow: InfoWindow(
              title: "RC-02 Santa Rosa",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.4000502, 9.25789457, 'RC-02 Santa Rosa'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('29'),
            position: LatLng(9.43121269, -83.845292),
            infoWindow: InfoWindow(
              title: "SA-01 Savegre Abajo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.845292, 9.43121269, 'SA-01 Savegre Abajo'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('30'),
            position: LatLng(9.43438383, -83.8582307),
            infoWindow: InfoWindow(
              title: "SA-02 Savegre Abajo",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [
                  -83.8582307,
                  9.43438383,
                  'SA-02 Savegre Abajo'
                ];
              });
            },
          ),
          Marker(
            markerId: MarkerId('31'),
            position: LatLng(9.12010704, -83.0803525),
            infoWindow: InfoWindow(
              title: "TC-01 Tres Colinas",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.0803525, 9.12010704, 'TC-01 Tres Colinas'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('32'),
            position: LatLng(9.12272236, -83.0775314),
            infoWindow: InfoWindow(
              title: "TC-02 Tres Colinas",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.0775314, 9.12272236, 'TC-02 Tres Colinas'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('33'),
            position: LatLng(9.11702845, -83.0788612),
            infoWindow: InfoWindow(
              title: "TC-03 Tres Colinas",
            ),
            onTap: () {
              setState(() {
                _pickedLocation =
                [-83.0788612, 9.11702845, 'TC-03 Tres Colinas'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('34'),
            position: LatLng(9.22145746, -83.3068622),
            infoWindow: InfoWindow(
              title: "UJ-01 Ujarrás",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.3068622, 9.22145746, 'UJ-01 Ujarrás'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('35'),
            position: LatLng(9.26376984, -83.34731),
            infoWindow: InfoWindow(
              title: "UJ-02 Ujarrás",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.34731, 9.26376984, 'UJ-02 Ujarrás'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('36'),
            position: LatLng(9.25679632, -83.2953523),
            infoWindow: InfoWindow(
              title: "UJ-03 Ujarrás",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.2953523, 9.25679632, 'UJ-03 Ujarrás'];
              });
            },
          ),
        ],
      );
    } else if (group.group == "ACOSA") {
      markers.addAll(
        [
          Marker(
            markerId: MarkerId('37'),
            position: LatLng(8.96393, -83.60091),
            infoWindow: InfoWindow(
              title: "La Trocha",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.60091, 8.96393, 'La Trocha'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('38'),
            position: LatLng(8.98459, -83.59841),
            infoWindow: InfoWindow(
              title: "Ciudad Cortés",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.59841, 8.98459, 'Ciudad Cortés'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('39'),
            position: LatLng(8.7981, -83.60117),
            infoWindow: InfoWindow(
              title: "Isla Violines",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.60117, 8.7981, 'Isla Violines'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('40'),
            position: LatLng(8.88516, -83.47083),
            infoWindow: InfoWindow(
              title: "Estero Azul",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.47083, 8.88516, 'Estero Azul'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('41'),
            position: LatLng(8.8444, -83.40087),
            infoWindow: InfoWindow(
              title: "La Olla",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.40087, 8.8444, 'La Olla'];
              });
            },
          ),
          Marker(
            markerId: MarkerId('42'),
            position: LatLng(8.80883, -83.33076),
            infoWindow: InfoWindow(
              title: "Laguna Sierpe",
            ),
            onTap: () {
              setState(() {
                _pickedLocation = [-83.33076, 8.80883, 'Laguna Sierpe'];
              });
            },
          ),
        ],
      );
    }

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
        target: LatLng(
          widget.initialLocality[1],
          widget.initialLocality[0],
        ),
        zoom: 10,
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
                subtitle: Text('${suggestion.description}'),
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
