import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_cart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxon_grid_tile.dart';

enum FilterClassOptions {
  Eukaryota,
  Amphibia,
  Mammalia,
  Aves,
}

class EventTaxaPickScreen extends StatefulWidget {
  final List initialTaxa;

  EventTaxaPickScreen({
    this.initialTaxa,
  });

  @override
  _EventTaxaPickScreenState createState() => _EventTaxaPickScreenState();
}

class _EventTaxaPickScreenState extends State<EventTaxaPickScreen> {
  var _eventTaxaCart;
  String _filterClass = 'Eukaryota';

  @override
  void didChangeDependencies() {
    _eventTaxaCart = Provider.of<EventTaxaCart>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final _taxaData = Provider.of<Taxa>(context);
    final _taxa = _filterClass == 'Eukaryota'
        ? _taxaData.items
        : _taxaData.findByClass(_filterClass);

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
              _done();
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: _taxa.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: _taxa[i],
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

  void _done() {
    List _eventTaxaCartList = _eventTaxaCart.items.values.toList();
    List _pickedTaxa = [];

    for (var _eventTaxaCartItem in _eventTaxaCartList) {
      _pickedTaxa.add(
        [
          _eventTaxaCartItem.taxonId,
          _eventTaxaCartItem.individualCount,
        ],
      );
    }

    _eventTaxaCart.clear();

    Navigator.of(context).pop(_pickedTaxa);
  }
}
