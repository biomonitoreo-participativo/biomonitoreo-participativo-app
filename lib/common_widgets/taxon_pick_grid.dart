import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_grid_tile.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/taxon_data.dart';

class TaxonPickGrid extends StatelessWidget {
  final List<String> initialTaxon;
  final bool isSelecting;

  TaxonPickGrid({
    this.initialTaxon = const ['000001', '1'],
    this.isSelecting = false,
  });

  @override
  Widget build(BuildContext context) {
    final taxaData = Provider.of<Taxa>(context);
    final taxa = taxaData.items;
    final taxonCart =
        Provider.of<OpportunisticObservationTaxonCart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar taxón'),
        actions: <Widget>[
          if (isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                print('Check: ${taxonCart.items.values.toList()[0].taxonId}');
                Navigator.of(context).pop(
                  [
                    taxonCart.items.values.toList()[0].taxonId,
                    taxonCart.items.values
                        .toList()[0]
                        .individualCount
                        .toString(),
                  ],
                );
              },
            ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: taxa.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: taxa[i],
          child: TaxonGridTile(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
      ),
    );
  }
}
