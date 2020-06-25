import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'input_observation_quantity.dart';
import 'observation_data.dart';
import 'observation_tile_view.dart';

class ObservationsListView extends StatelessWidget {
  ObservationsListView();

  @override
  Widget build(BuildContext context) {
    final observationData = Provider.of<ObservationData>(context);

    InputObservationQuantity qtyModel =
        Provider.of<InputObservationQuantity>(context);

    final observations = observationData.getObservationsQtyGt0();

    return ListView.builder(
      itemCount: observations.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: observations[index],
        child: ObservationTileView(),
      ),
    );
  }
}
