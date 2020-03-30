import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/observation_tile.dart';
import '../models/observation_data.dart';

class ObservationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ObservationData>(
      builder: (context, observationData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final observation = observationData.observations[index];
            return ObservationTile(
              observationTitle: observation.scientificName,
              observationTrailing: '${observation.quantity}',
              longPressCallback: () {
                observationData.deleteObservation(observation);
              },
            );
          },
          itemCount: observationData.observationsCount,
        );
      },
    );
  }
}
