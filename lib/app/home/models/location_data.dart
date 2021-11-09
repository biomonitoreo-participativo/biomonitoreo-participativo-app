import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'location.dart';

class LocationData with ChangeNotifier {
  static List<Location> _locations_aclap = [
    Location(
      id: '01',
      name: 'AB-01 Altamira de Biolley-01',
      description: 'Sendero Asoprola',
      decimalLongitude: -83.0090092,
      decimalLatitude: 9.00549542,
    ),
    Location(
      id: '02',
      name: 'AV-02 Altamira de Vocán',
      description: 'Sendero Linda Vista',
      decimalLongitude: -83.4516672,
      decimalLatitude: 9.28438765,
    ),
    Location(
      id: '03',
      name: 'AV-01 Altamira de Volcán',
      description: 'Sendero Perica',
      decimalLongitude: -83.4602387,
      decimalLatitude: 9.28729506,
    ),
    Location(
      id: '04',
      name: 'BI-01 Biolley',
      description: 'Finca Monterromo',
      decimalLongitude: -83.0545614,
      decimalLatitude: 9.0231913,
    ),
    Location(
      id: '05',
      name: 'BI-02 Biolley',
      description: 'Finca María Isabel',
      decimalLongitude: -83.037795,
      decimalLatitude: 9.03876183,
    ),
    Location(
      id: '06',
      name: 'BI-03 Biolley',
      description: 'Sendero Biolley',
      decimalLongitude: -83.0413176,
      decimalLatitude: 9.03425048,
    ),
    Location(
      id: '07',
      name: 'CB-01 Cabagra',
      description: 'Sendero Cabagra Centro',
      decimalLongitude: -83.2036868,
      decimalLatitude: 9.13279284,
    ),
    Location(
      id: '08',
      name: 'CB-03 Cabagra',
      description: 'Finca Edmundo Las Huacas',
      decimalLongitude: -83.1557111,
      decimalLatitude: 9.12137815,
    ),
    Location(
      id: '09',
      name: 'CH-03 Chánguena',
      description: 'Finca Chánguena 03',
      decimalLongitude: -83.2067085,
      decimalLatitude: 8.91894041,
    ),
    Location(
      id: '10',
      name: 'CH-01 Chánguena - Las Nubes',
      description: 'Finca las Nubes de Chánguena',
      decimalLongitude: -83.163918,
      decimalLatitude: 8.91168574,
    ),
    Location(
      id: '11',
      name: 'CH-02 Chánguena - Pilón',
      description: 'Finca Pilón',
      decimalLongitude: -83.1720855,
      decimalLatitude: 8.90642376,
    ),
    Location(
      id: '12',
      name: 'AB-02 Colorado',
      description: 'Sendero Colorado',
      decimalLongitude: -83.0230982,
      decimalLatitude: 9.01146405,
    ),
    Location(
      id: '13',
      name: 'JD-01 El Jardín',
      description: 'Finca Martín Salazar',
      decimalLongitude: -83.7173239,
      decimalLatitude: 9.54753401,
    ),
    Location(
      id: '14',
      name: 'JD-02 El Jardín',
      description: 'Finca Cosme Gamboa',
      decimalLongitude: -83.6977546,
      decimalLatitude: 9.50310902,
    ),
    Location(
      id: '15',
      name: 'JD-03 El Jardín',
      description: 'Finca de Errol Salazar',
      decimalLongitude: -83.7086084,
      decimalLatitude: 9.53414089,
    ),
    Location(
      id: '16',
      name: 'RC-01 Guadalajara',
      description: 'Guadalajara',
      decimalLongitude: -83.3868519,
      decimalLatitude: 9.24059771,
    ),
    Location(
      id: '17',
      name: 'LU-01 La Luchita',
      description: 'Sendero Parcelas',
      decimalLongitude: -83.1265134,
      decimalLatitude: 9.09028874,
    ),
    Location(
      id: '18',
      name: 'LA-01 Los Ángeles',
      description: 'Finca de Andrey y Sonia',
      decimalLongitude: -83.8130617,
      decimalLatitude: 9.48537348,
    ),
    Location(
      id: '19',
      name: 'LA-02 Los Ángeles',
      description: 'Finca de Rafael',
      decimalLongitude: -83.7973644,
      decimalLatitude: 9.51023701,
    ),
    Location(
      id: '20',
      name: 'LA-03 Los Ángeles',
      description: 'Sendero 3',
      decimalLongitude: -83.8086589,
      decimalLatitude: 9.48754174,
    ),
    Location(
      id: '21',
      name: 'PT-01 Pittier',
      description: 'Fila Naranjo',
      decimalLongitude: -82.9573403,
      decimalLatitude: 8.92135315,
    ),
    Location(
      id: '22',
      name: 'PT-02 Pittier',
      description: 'Finca Campos',
      decimalLongitude: -82.9770522,
      decimalLatitude: 8.91132719,
    ),
    Location(
      id: '23',
      name: 'SG-01 San Gerardo',
      description: 'Camino San Gerardo Los Ángeles',
      decimalLongitude: -83.6041212,
      decimalLatitude: 9.46448482,
    ),
    Location(
      id: '24',
      name: 'SG-02 San Gerardo',
      description: 'Reserva Cloud Bridge',
      decimalLongitude: -83.5831321,
      decimalLatitude: 9.4728713,
    ),
    Location(
      id: '25',
      name: 'SJ-01 San Jerónimo',
      description: 'Sendero Zaddy',
      decimalLongitude: -83.5106789,
      decimalLatitude: 9.34226752,
    ),
    Location(
      id: '26',
      name: 'SJ-02 San Jerónimo',
      description: 'Sendero Ena',
      decimalLongitude: -83.5029965,
      decimalLatitude: 9.3643246,
    ),
    Location(
      id: '27',
      name: 'RC-03 Santa María',
      description: 'Ruta las aves',
      decimalLongitude: -83.3788999,
      decimalLatitude: 9.27666952,
    ),
    Location(
      id: '28',
      name: 'RC-02 Santa Rosa',
      description: 'Sendero Mirador',
      decimalLongitude: -83.4000502,
      decimalLatitude: 9.25789457,
    ),
    Location(
      id: '29',
      name: 'SA-01 Savegre Abajo',
      description: 'Finca Esteban Cordero',
      decimalLongitude: -83.845292,
      decimalLatitude: 9.43121269,
    ),
    Location(
      id: '30',
      name: 'SA-02 Savegre Abajo',
      description: 'Finca de Victor',
      decimalLongitude: -83.8582307,
      decimalLatitude: 9.43438383,
    ),
    Location(
      id: '31',
      name: 'TC-01 Tres Colinas',
      description: 'Sendero Huacas',
      decimalLongitude: -83.0803525,
      decimalLatitude: 9.12010704,
    ),
    Location(
      id: '32',
      name: 'TC-02 Tres Colinas',
      description: 'Sendero Los Colibríes',
      decimalLongitude: -83.0775314,
      decimalLatitude: 9.12272236,
    ),
    Location(
      id: '33',
      name: 'TC-03 Tres Colinas',
      description: 'Sendero Guardianes del Bosque',
      decimalLongitude: -83.0788612,
      decimalLatitude: 9.11702845,
    ),
    Location(
      id: '34',
      name: 'UJ-01 Ujarrás',
      description: 'Ujarrás',
      decimalLongitude: -83.3068622,
      decimalLatitude: 9.22145746,
    ),
    Location(
      id: '35',
      name: 'UJ-02 Ujarrás',
      description: 'Sendero Zapotal',
      decimalLongitude: -83.34731,
      decimalLatitude: 9.26376984,
    ),
    Location(
      id: '36',
      name: 'UJ-03 Ujarrás',
      description: 'Sendero Guanacaste',
      decimalLongitude: -83.2953523,
      decimalLatitude: 9.25679632,
    ),
  ];

  static List<Location> _locations_acosa = [
    Location(
      id: '37',
      name: 'La Trocha',
      description: 'La Trocha',
      decimalLongitude: -83.60091,
      decimalLatitude: 8.96393,
    ),
    Location(
      id: '38',
      name: 'Ciudad Cortés',
      description: 'Ciudad Cortés',
      decimalLongitude: -83.59841,
      decimalLatitude: 8.98459,
    ),
    Location(
      id: '39',
      name: 'Isla Violines',
      description: 'Isla Violines',
      decimalLongitude: -83.60117,
      decimalLatitude: 8.7981,
    ),
    Location(
      id: '40',
      name: 'Estero Azul',
      description: 'Estero Azul',
      decimalLongitude: -83.47083,
      decimalLatitude: 8.88516,
    ),
    Location(
      id: '41',
      name: 'La Olla',
      description: 'La Olla',
      decimalLongitude: -83.40087,
      decimalLatitude: 8.8444,
    ),
    Location(
      id: '42',
      name: 'Laguna Sierpe',
      description: 'Laguna Sierpe',
      decimalLongitude: -83.33076,
      decimalLatitude: 8.80883,
    ),
    Location(
      id: '51',
      name: 'Sendero La Catarata',
      description: 'Sendero La Catarata',
      decimalLongitude: -83.177754,
      decimalLatitude: 8.656273,
    ),
    Location(
      id: '52',
      name: 'Sendero Río Esquinas',
      description: 'Sendero Río Esquinas',
      decimalLongitude: -83.28481,
      decimalLatitude: 8.74975,
    ),
    Location(
      id: '53',
      name: 'Sendero Ocelote',
      description: 'Sendero Ocelote',
      decimalLongitude: -83.205064,
      decimalLatitude: 8.700444,
    ),
    Location(
      id: '54',
      name: 'Sendero Toñito',
      description: 'Sendero Toñito',
      decimalLongitude: -83.23213,
      decimalLatitude: 8.66919,
    ),
  ];

  static List<Location> _locations_acopac = [
    Location(
      id: '43',
      name: 'ACOPAC',
      description: 'ACOPAC',
      decimalLongitude: -84.61171085009283,
      decimalLatitude: 9.806941148583254,
    ),
  ];

  static List<Location> _locations_act = [
    Location(
      id: '44',
      name: 'ACT',
      description: 'ACT',
      decimalLongitude: -85.43159510976471,
      decimalLatitude: 10.097173266511323,
    ),
  ];

  static List<Location> _locations_acat = [
    Location(
      id: '45',
      name: 'ACAT',
      description: 'ACAT',
      decimalLongitude: -85.0767033473549,
      decimalLatitude: 10.447173798931836,
    ),
  ];

  static List<Location> _locations_acg = [
    Location(
      id: '46',
      name: 'ACG',
      description: 'ACG',
      decimalLongitude: -85.52764979312006,
      decimalLatitude: 10.845064476388764,
    ),
  ];

  static List<Location> _locations_acc = [
    Location(
      id: '47',
      name: 'ACC',
      description: 'ACC',
      decimalLongitude: -84.05044994824789,
      decimalLatitude: 9.895786170330801,
    ),
  ];

  static List<Location> _locations_acto = [
    Location(
      id: '48',
      name: 'ACTo',
      description: 'ACTo',
      decimalLongitude: -83.67621337588776,
      decimalLatitude: 10.453114160016387,
    ),
  ];

  static List<Location> _locations_acahn = [
    Location(
      id: '49',
      name: 'ACAHN',
      description: 'ACAHN',
      decimalLongitude: -84.52626490572972,
      decimalLatitude: 10.661593464999669,
    ),
  ];

  static List<Location> _locations_aclac = [
    Location(
      id: '50',
      name: 'ACLAC',
      description: 'ACLAC',
      decimalLongitude: -83.17880105587238,
      decimalLatitude: 9.729058926118755,
    ),
  ];


  static List<Location> _locations = _locations_aclap;

  void setLocations(String list) {
    if (list == "ACLAP") {
      _locations = _locations_aclap;
    } else if (list == "ACOSA") {
      _locations = _locations_acosa;
    } else if (list == "ACOPAC") {
      _locations = _locations_acopac;
    } else if (list == "ACT") {
      _locations = _locations_act;
    } else if (list == "ACAT") {
      _locations = _locations_acat;
    } else if (list == "ACG") {
      _locations = _locations_acg;
    } else if (list == "ACC") {
      _locations = _locations_acc;
    } else if (list == "ACTo") {
      _locations = _locations_acto;
    } else if (list == "ACAHN") {
      _locations = _locations_acahn;
    } else if (list == "ACLAC") {
      _locations = _locations_aclac;
    } else {
      _locations = _locations_aclap;
    }
  }

  static UnmodifiableListView<Location> get locations {
    return UnmodifiableListView(
      _locations,
    );
  }

  static List<Location> getLocations() {
    return _locations;
  }

  static UnmodifiableListView<Location> _getSortedLocations(List<Location> l) {
    l.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    // l = l.reversed.toList();

    return UnmodifiableListView(
      l,
    );
  }

  static UnmodifiableListView<Location> findByFilter(String filter) {
/*    if (filter == '*') {
      _observations = _getSortedObservations(_observations);
      return UnmodifiableListView(
        _observations.toList(),
      );
    }*/

    List<Location> filteredLocations = _locations
        .where(
          (l) => (l.name.toLowerCase().contains(
                filter.toLowerCase(),
              )),
        )
        .toList();
    filteredLocations = _getSortedLocations(filteredLocations);

    return UnmodifiableListView(filteredLocations);
  }
}
