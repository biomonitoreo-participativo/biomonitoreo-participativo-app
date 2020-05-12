import 'dart:collection';

import 'package:biomonitoreoparticipativoapp/models/location.dart';

class LocationData {
  static List<Location> _locations = [
    Location(
      id: '01',
      name: 'Finca Esteban Cordero',
      description: 'Finca Esteban Cordero',
      decimalLongitude: -83.84320,
      decimalLatitude: 9.43039,
    ),
    Location(
      id: '02',
      name: 'Finca de Victor',
      description: 'Finca de Victor',
      decimalLongitude: -83.85632,
      decimalLatitude: 9.43362,
    ),
    Location(
      id: '03',
      name: 'Finca de Andrey y Sonia',
      description: 'Finca de Andrey y Sonia',
      decimalLongitude: -83.80704,
      decimalLatitude: 9.48405,
    ),
    Location(
      id: '04',
      name: 'Finca de Rafael',
      description: 'Finca de Andrey y Sonia',
      decimalLongitude: -83.79451,
      decimalLatitude: 9.50930,
    ),
    Location(
      id: '05',
      name: 'Sendero 3',
      description: 'Sendero 3',
      decimalLongitude: -83.80604,
      decimalLatitude: 9.48670,
    ),
    Location(
      id: '06',
      name: 'Finca Cosme Gamboa',
      description: 'Finca Cosme Gamboa',
      decimalLongitude: -83.69381,
      decimalLatitude: 9.50198,
    ),
    Location(
      id: '07',
      name: 'Finca de Errol Salazar',
      description: 'Finca de Errol Salazar',
      decimalLongitude: -83.70460,
      decimalLatitude: 9.53331,
    ),
    Location(
      id: '08',
      name: 'Finca Martín Salazar',
      description: 'Finca Martín Salazar',
      decimalLongitude: -83.71342,
      decimalLatitude: 9.54667,
    ),
    Location(
      id: '09',
      name: 'Camino San Gerardo Los Ángeles',
      description: 'Camino San Gerardo Los Ángeles',
      decimalLongitude: -83.59874,
      decimalLatitude: 9.46367,
    ),
    Location(
      id: '10',
      name: 'Reserva Cloud Bridge',
      description: 'Reserva Cloud Bridge',
      decimalLongitude: -83.57746,
      decimalLatitude: 9.47210,
    ),
    Location(
      id: '11',
      name: 'Sendero Zaddy',
      description: 'Sendero Zaddy',
      decimalLongitude: -83.50421,
      decimalLatitude: 9.34146,
    ),
    Location(
      id: '12',
      name: 'Sendero Ena',
      description: 'Sendero Ena',
      decimalLongitude: -83.49639,
      decimalLatitude: 9.36354,
    ),
    Location(
      id: '13',
      name: 'Sendero Perica',
      description: 'Sendero Perica',
      decimalLongitude: -83.45692,
      decimalLatitude: 9.28686,
    ),
    Location(
      id: '14',
      name: 'Guadalajara',
      description: 'Guadalajara',
      decimalLongitude: -83.37892,
      decimalLatitude: 9.23980,
    ),
    Location(
      id: '15',
      name: 'Sendero Mirador',
      description: 'Sendero Mirador',
      decimalLongitude: -83.39225,
      decimalLatitude: 9.25712,
    ),
    Location(
      id: '16',
      name: 'Ruta las aves',
      description: 'Ruta las aves',
      decimalLongitude: -83.37080,
      decimalLatitude: 9.27587,
    ),
    Location(
      id: '17',
      name: 'Ujarrás',
      description: 'Ujarrás',
      decimalLongitude: -83.30128,
      decimalLatitude: 9.23270,
    ),
    Location(
      id: '18',
      name: 'Sendero Zapotal',
      description: 'Sendero Zapotal',
      decimalLongitude: -83.33883,
      decimalLatitude: 9.26302,
    ),
    Location(
      id: '19',
      name: 'Sendero Parcelas',
      description: 'Sendero Parcelas',
      decimalLongitude: -83.11559,
      decimalLatitude: 9.08958,
    ),
    Location(
      id: '20',
      name: 'Sendero Huacas',
      description: 'Sendero Huacas',
      decimalLongitude: -83.06877,
      decimalLatitude: 9.11940,
    ),
    Location(
      id: '21',
      name: 'Sendero 1',
      description: 'Sendero 1',
      decimalLongitude: -83.05455,
      decimalLatitude: 9.02319,
    ),
    Location(
      id: '22',
      name: 'Finca María Isabel',
      description: 'Finca María Isabel',
      decimalLongitude: -83.03779,
      decimalLatitude: 9.03876,
    ),
    Location(
      id: '23',
      name: 'Sendero Biolley',
      description: 'Sendero Biolley',
      decimalLongitude: -83.04131,
      decimalLatitude: 9.03426,
    ),
    Location(
      id: '24',
      name: 'Sendero Colorado',
      description: 'Sendero Colorado',
      decimalLongitude: -83.02309,
      decimalLatitude: 9.01146,
    ),
    Location(
      id: '25',
      name: 'Sendero Asoprola',
      description: 'Sendero Asoprola',
      decimalLongitude: -83.00901,
      decimalLatitude: 9.00549,
    ),
    Location(
      id: '26',
      name: 'Sendero Cabagra',
      description: 'Sendero Cabagra',
      decimalLongitude: -83.19557,
      decimalLatitude: 9.13701,
    ),
    Location(
      id: '27',
      name: 'Sendero Chánguena',
      description: 'Sendero Chánguena',
      decimalLongitude: -83.20337,
      decimalLatitude: 8.93879,
    ),
    Location(
      id: '28',
      name: 'Sendero Pittier',
      description: 'Sendero Pittier',
      decimalLongitude: -82.93996,
      decimalLatitude: 8.95203,
    ),
    Location(
      id: '29',
      name: 'Sendero Tablas',
      description: 'Sendero Tablas',
      decimalLongitude: -82.81732,
      decimalLatitude: 8.88802,
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
