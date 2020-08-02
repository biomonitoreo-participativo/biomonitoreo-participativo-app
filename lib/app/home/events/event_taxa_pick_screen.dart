import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxon_grid_tile.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_cart.dart';

enum FilterClassOptions {
  Eukaryota,
  Amphibia,
  Mammalia,
  Aves,
}

class EventTaxaPickScreen extends StatefulWidget {
  final List<String> initialTaxon;

  EventTaxaPickScreen({
    this.initialTaxon = const ['000001', '1'],
  });

  @override
  _EventTaxaPickScreenState createState() => _EventTaxaPickScreenState();
}

class _EventTaxaPickScreenState extends State<EventTaxaPickScreen> {
  String _filterClass = 'Eukaryota';

  @override
  Widget build(BuildContext context) {
    final taxaData = Provider.of<Taxa>(context);
    final taxa = _filterClass == 'Eukaryota'
        ? taxaData.items
        : taxaData.findByClass(_filterClass);

    final taxaCart = Provider.of<EventTaxaCart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar especies'),
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
              print('taxaCart: len ${taxaCart.items.length}');
              List list = [];
              List subList = [
                taxaCart.items.values.toList()[0].taxonId,
                taxaCart.items.values.toList()[0].individualCount,
              ];
              list.add(subList);
              Navigator.of(context).pop(list);
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
          child: EventTaxonGridTile(),
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
