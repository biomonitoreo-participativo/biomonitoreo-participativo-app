import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_taxon_grid_tile.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/group.dart';

enum FilterClassOptions {
  Eukaryota,
  Amphibia,
  Mammalia,
  Aves,
}

class OpportunisticObservationPickScreen extends StatefulWidget {
  final List<String> initialTaxon;

  OpportunisticObservationPickScreen({
    this.initialTaxon = const ['000001', '1'],
  });

  @override
  _OpportunisticObservationPickScreenState createState() =>
      _OpportunisticObservationPickScreenState();
}

class _OpportunisticObservationPickScreenState
    extends State<OpportunisticObservationPickScreen> {
  String _filterClass = 'Eukaryota';

  @override
  Widget build(BuildContext context) {
    final taxaData = Provider.of<Taxa>(context);

    final group = Provider.of<Group>(context);
    taxaData.setItems(group.group);


    final taxa = _filterClass == 'Eukaryota'
        ? taxaData.items
        : taxaData.findByClass(_filterClass);

    final taxonCart =
        Provider.of<OpportunisticObservationTaxonCart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Indicadoras de ${group.group}'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterClassOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterClassOptions.Mammalia) {
                  _filterClass = 'Mammalia';
                } else if (selectedValue == FilterClassOptions.Aves) {
                  _filterClass = 'Aves';
                } else if (selectedValue == FilterClassOptions.Amphibia) {
                  _filterClass = 'Amphibia';
                } else {
                  _filterClass = 'Eukaryota';
                }
              });
            },
            icon: Icon(
              Icons.filter,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterClassOptions.Eukaryota,
              ),
              PopupMenuItem(
                child: Text('Anfibios'),
                value: FilterClassOptions.Amphibia,
              ),
              PopupMenuItem(
                child: Text('Aves'),
                value: FilterClassOptions.Aves,
              ),
              PopupMenuItem(
                child: Text('Mamíferos'),
                value: FilterClassOptions.Mammalia,
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.of(context).pop(
                [
                  taxonCart.items.values.toList()[0].taxonId,
                  taxonCart.items.values.toList()[0].individualCount,
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
