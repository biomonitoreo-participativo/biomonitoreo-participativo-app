import 'dart:collection';

import 'location.dart';

class LocationData {
  static List<Location> _locations = [
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
