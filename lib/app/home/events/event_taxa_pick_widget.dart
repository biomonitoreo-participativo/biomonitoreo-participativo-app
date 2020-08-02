import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_pick_screen.dart';
import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_pick_grid.dart';

class EventTaxaPickWidget extends StatefulWidget {
  final Function onPickTaxa;

  EventTaxaPickWidget(this.onPickTaxa);

  @override
  _EventTaxaPickWidgetState createState() => _EventTaxaPickWidgetState();
}

class _EventTaxaPickWidgetState extends State<EventTaxaPickWidget> {
  List _pickedTaxa;

  Future<void> _pickOnGrid() async {
    _pickedTaxa = await Navigator.of(context).push<List>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => EventTaxaPickScreen(),
      ),
    );

    if (_pickedTaxa == null) {
      return;
    }

    print('_pickedTaxa: ${_pickedTaxa[0][0]} ${_pickedTaxa[0][1]}');
    widget.onPickTaxa(
      _pickedTaxa[0][0],
      _pickedTaxa[0][1],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(
            Icons.nature,
          ),
          label: Text('Seleccionar especie de lista'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickOnGrid,
        ),
      ],
    );
  }
}
