import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/opportunistic_observation_taxon_cart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

class TaxonGridTile extends StatefulWidget {
  @override
  _TaxonGridTileState createState() => _TaxonGridTileState();
}

class _TaxonGridTileState extends State<TaxonGridTile> {
  int _individualCount = 0;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No fue posible acceder a $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final taxon = Provider.of<Taxon>(context, listen: false);
    final taxonCart =
        Provider.of<OpportunisticObservationTaxonCart>(context, listen: false);

    if (taxonCart.itemCount > 0) {
      print(
          'Taxones en el carrito: ${taxonCart.itemCount}. ${taxonCart.items.values.toList()[0].taxonId} (${taxonCart.items.values.toList()[0].individualCount})');
    } else {
      print('Carrito vacío');
    }

    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
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
                    });

                    taxonCart.clear();
                    taxonCart.addItem(taxon.id, _individualCount);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Individuo agregado',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Substract individual
                    if (_individualCount > 0) {
                      setState(() {
                        _individualCount -= 1;
                      });
                      taxonCart.clear();
                      taxonCart.addItem(taxon.id, _individualCount);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Individuo restado',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
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
}
