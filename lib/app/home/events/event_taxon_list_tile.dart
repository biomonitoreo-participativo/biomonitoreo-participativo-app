import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event_taxa_cart.dart';

class EventTaxonListTile extends StatefulWidget {
  final List pickedTaxa;

  EventTaxonListTile(this.pickedTaxa);

  @override
  _EventTaxonListTileState createState() => _EventTaxonListTileState();
}

class _EventTaxonListTileState extends State<EventTaxonListTile> {
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
                  child: Image.network(
                    _taxon.urlImage,
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
                      '99',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.green,
                    radius: 15.0,
                  ),
                ),
              ],
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
}
