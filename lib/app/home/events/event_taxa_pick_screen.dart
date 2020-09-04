import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event_taxa_cart.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxon_grid_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxon_list_tile.dart';

enum FilterClassOptions {
  Eukaryota,
  Amphibia,
  Mammalia,
  Aves,
}

class EventTaxaPickScreen extends StatefulWidget {
  final List pickedTaxa;

  EventTaxaPickScreen(
    this.pickedTaxa,
  );

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
/*          PopupMenuButton(
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
          ),*/
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _done();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.pickedTaxa.length,
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 20.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: GridTile(
                            child: GestureDetector(
                              onTap: () {},
                              onLongPress: () => _launchURL(_taxaData
                                  .findById(
                                    widget.pickedTaxa[i][0],
                                  )
                                  .urlSpeciesPage),
                              child: Image.network(
                                _taxaData
                                    .findById(
                                      widget.pickedTaxa[i][0],
                                    )
                                    .urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              child: CircleAvatar(
                                child: Text(
                                  '${widget.pickedTaxa[i][1]}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                radius: 15.0,
                              ),
                              onTap: () {
                                // Add individual
                                setState(() {
                                  widget.pickedTaxa[i][1] += 1;
                                  //_selected = true;
                                });
/*                                _taxaCart.addItem(
                                  _taxon.id,
                                  _individualCount,
                                  _occurrenceId,
                                );*/
                              },
                              onLongPress: () {
                                // Substract individual
                                if (widget.pickedTaxa[i][1] > 0) {
                                  setState(() {
                                    widget.pickedTaxa[i][1] -= 1;
/*                                    _taxaCart.addItem(
                                      _taxon.id,
                                      _individualCount,
                                      _occurrenceId,
                                    );*/
                                    if (widget.pickedTaxa[i][1] <= 0) {
                                      //_taxaCart.removeItem(_taxon.id);
                                      //_selected = false;
                                    }
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _taxaData
                                        .findById(widget.pickedTaxa[i][0])
                                        .scientificName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _taxaData
                                        .findById(widget.pickedTaxa[i][0])
                                        .vernacularName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12.0),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 600.0,
            child: GridView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: _taxa.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                // builder: (c) => products[i],
                value: _taxa[i],
                child: EventTaxonGridTile(widget.pickedTaxa),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No fue posible acceder a $url';
    }
  }

  void _done() {
    List _eventTaxaCartList = _eventTaxaCart.items.values.toList();
    List _pickedTaxa = [];

    for (var _eventTaxaCartItem in _eventTaxaCartList) {
      _pickedTaxa.add(
        [
          _eventTaxaCartItem.taxonId,
          _eventTaxaCartItem.individualCount,
          _eventTaxaCartItem.occurrenceId,
        ],
      );
    }

    _eventTaxaCart.clear();

    Navigator.of(context).pop(_pickedTaxa);
  }
}
