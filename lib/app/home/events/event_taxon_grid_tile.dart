import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_cart.dart';

class EventTaxonGridTile extends StatefulWidget {
  final List pickedTaxa;

  EventTaxonGridTile(this.pickedTaxa);

  @override
  _EventTaxonGridTileState createState() => _EventTaxonGridTileState();
}

class _EventTaxonGridTileState extends State<EventTaxonGridTile> {
  int _individualCount = 0;
  bool _selected = false;

  var _taxaCart;
  var _taxon;

  var _occurrenceId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _taxaCart = Provider.of<EventTaxaCart>(context, listen: false);
    _taxon = Provider.of<Taxon>(context, listen: false);

    if (widget.pickedTaxa != null) {
      for (var occ in widget.pickedTaxa) {
        if (occ[0] == _taxon.id) {
          setState(() {
            _individualCount = occ[1];
            _occurrenceId = occ[2];
            _selected = true;
          });
          _taxaCart.addItem(
            _taxon.id,
            _individualCount,
            _occurrenceId,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: _selected
            ? BorderSide(color: Colors.red, width: 2.0)
            : BorderSide(color: Colors.black, width: 2.0),
      ),
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
                  onLongPress: () => _launchURL(_taxon.urlSpeciesPage),
                  child: Image.network(
                    _taxon.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
                footer: GridTileBar(),
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
                      '$_individualCount',
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
                      _individualCount += 1;
                      _selected = true;
                    });
                    _taxaCart.addItem(
                      _taxon.id,
                      _individualCount,
                      _occurrenceId,
                    );
                  },
                  onLongPress: () {
                    // Substract individual
                    if (_individualCount > 0) {
                      setState(() {
                        _individualCount -= 1;
                        _taxaCart.addItem(
                          _taxon.id,
                          _individualCount,
                          _occurrenceId,
                        );
                        if (_individualCount <= 0) {
                          _taxaCart.removeItem(_taxon.id);
                          _selected = false;
                        }
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _taxon.scientificName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _taxon.vernacularName,
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
          )
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
}
