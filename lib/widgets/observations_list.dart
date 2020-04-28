import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/observation_tile.dart';
import '../models/observation_data.dart';
import '../models/input_observation_quantity.dart';

class ObservationsList extends StatelessWidget {
  final bool showOnlyObserved;
  final String filter;

  ObservationsList(this.showOnlyObserved, this.filter);

  @override
  Widget build(BuildContext context) {
    final observationData = Provider.of<ObservationData>(context);

    InputObservationQuantity qtyModel =
        Provider.of<InputObservationQuantity>(context);

/*    final observations = showOnlyObserved
        ? observationData.observedSpecies
        : observationData.observations;*/

    final observations = observationData.findByFilter(filter);

    return ListView.builder(
      itemCount: observations.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: observations[index],
        child: ObservationTile(),
      ),
    );
  }
}
