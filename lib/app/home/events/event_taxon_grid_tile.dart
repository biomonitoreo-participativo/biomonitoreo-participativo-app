import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_cart.dart';

class EventTaxonGridTile extends StatefulWidget {
  @override
  _EventTaxonGridTileState createState() => _EventTaxonGridTileState();
}

class _EventTaxonGridTileState extends State<EventTaxonGridTile> {
  int _individualCount = 0;
  bool _selected = false;

  var taxaCart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    taxaCart = Provider.of<EventTaxaCart>(context);
  }

  @override
  Widget build(BuildContext context) {
    final taxon = Provider.of<Taxon>(context, listen: false);

    String taxaCartItemTaxonId;
    int taxaCartItemIndividualCount;

    if (taxaCart.itemCount > 0) {
      print(
          'Taxones en el carrito: ${taxaCart.itemCount}. ${taxaCart.items.values.toList()[0].taxonId} (${taxaCart.items.values.toList()[0].individualCount})');

      taxaCartItemTaxonId = taxaCart.items.values.toList()[0].taxonId;
      taxaCartItemIndividualCount =
          taxaCart.items.values.toList()[0].individualCount;

      if (taxon.id == taxaCartItemTaxonId) {
        setState(() {
          _individualCount = taxaCartItemIndividualCount;
        });
      }
    } else {
      print('Carrito vacío');
    }

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
                  onLongPress: () => _launchURL(taxon.urlSpeciesPage),
                  child: Image.network(
                    taxon.urlImage,
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
                    taxaCart.addItem(taxon.id, _individualCount);
                  },
                  onLongPress: () {
                    // Substract individual
                    if (_individualCount > 0) {
                      setState(() {
                        _individualCount -= 1;
                      });
                      taxaCart.addItem(taxon.id, _individualCount);
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
                        taxon.scientificName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        taxon.vernacularName,
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
