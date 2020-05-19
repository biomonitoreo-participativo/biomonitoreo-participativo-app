import 'package:biomonitoreoparticipativoapp/models/observation_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/observation_data.dart';
import '../models/input_observation_quantity.dart';

class ObservationsListView extends StatelessWidget {
  ObservationsListView();

  @override
  Widget build(BuildContext context) {
    final observationData = Provider.of<ObservationData>(context);

    InputObservationQuantity qtyModel =
        Provider.of<InputObservationQuantity>(context);

    final observations = observationData.observedSpecies;

    return ListView.builder(
      itemCount: observations.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: observations[index],
        child: ObservationTileView(),
      ),
    );
  }
}
