import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event_taxa_cart.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxon_grid_tile.dart';

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

  var _taxaCart;

  @override
  void didChangeDependencies() {
    _eventTaxaCart = Provider.of<EventTaxaCart>(context, listen: false);

    _taxaCart = Provider.of<EventTaxaCart>(context, listen: false);
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Text(
              'Especies observadas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 180.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.pickedTaxa.length,
              itemBuilder: (ctx, i) {
                _taxaCart.addItem(
                  widget.pickedTaxa[i][0],
                  widget.pickedTaxa[i][1],
                  widget.pickedTaxa[i][2],
                );
                return Card(
                  elevation: 20.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
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
                      Container(
                        padding: EdgeInsets.all(5.0),
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
                                _taxaCart.addItem(
                                  widget.pickedTaxa[i][0],
                                  widget.pickedTaxa[i][1],
                                  widget.pickedTaxa[i][2],
                                );
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
                                    _taxaCart.addItem(
                                      widget.pickedTaxa[i][0],
                                      widget.pickedTaxa[i][1],
                                      widget.pickedTaxa[i][2],
                                    );
                                    if (widget.pickedTaxa[i][1] <= 0) {
                                      widget.pickedTaxa.removeAt(i);
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Text(
              'Especies indicadoras',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
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
                child: EventTaxonGridTile(widget.pickedTaxa, _insertPickedTaxa),
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

  void _insertPickedTaxa(taxonId, individualCount, occurrenceId) {
    var found = false;
    for (var occ in widget.pickedTaxa) {
      if (occ[0] == taxonId) {
        found = true;
      }
    }
    if (!found) {
      setState(() {
        widget.pickedTaxa.insert(0, [taxonId, individualCount, occurrenceId]);
      });
      _taxaCart.addItem(
        widget.pickedTaxa[0][0],
        widget.pickedTaxa[0][1],
        widget.pickedTaxa[0][2],
      );
    }
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
