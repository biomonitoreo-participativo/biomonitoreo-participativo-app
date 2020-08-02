import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_grid_tile.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

enum FilterClassOptions {
  Eukaryota,
  Amphibia,
  Mammalia,
  Aves,
}

class TaxonPickGrid extends StatefulWidget {
  final List<String> initialTaxon;

  TaxonPickGrid({
    this.initialTaxon = const ['000001', '1'],
  });

  @override
  _TaxonPickGridState createState() => _TaxonPickGridState();
}

class _TaxonPickGridState extends State<TaxonPickGrid> {
  String _filterClass = 'Eukaryota';

  @override
  Widget build(BuildContext context) {
    final taxaData = Provider.of<Taxa>(context);
    final taxa = _filterClass == 'Eukaryota'
        ? taxaData.items
        : taxaData.findByClass(_filterClass);

    final taxonCart =
        Provider.of<OpportunisticObservationTaxonCart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar especie'),
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
