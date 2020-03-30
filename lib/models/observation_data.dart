import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'observation.dart';

class ObservationData extends ChangeNotifier {
  List<Observation> _observations = [
    Observation(scientificName: 'Pharomachrus mocinno', quantity: 1),
    Observation(scientificName: 'Pharomachrus mocinno', quantity: 1),
  ];

  UnmodifiableListView<Observation> get observations {
    return UnmodifiableListView(_observations);
  }

  int get observationsCount {
    return _observations.length;
  }

  void addObservation(String newObservationSciName, int newObservationQty) {
    final observation = Observation(
      scientificName: newObservationSciName,
      quantity: newObservationQty,
    );
    _observations.add(observation);
    notifyListeners();
  }

  void deleteObservation(Observation observation) {
    _observations.remove(observation);
    notifyListeners();
  }
}
