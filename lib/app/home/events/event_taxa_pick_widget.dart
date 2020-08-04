import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_pick_screen.dart';

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

    print(
        'event_taxa_pick_widget::_pickOnGrid::_pickedTaxa.length ${_pickedTaxa.length}');
    for (var l in _pickedTaxa) {
      print('_pickedTaxaItem: [0]: ${l[0]} [1]: ${l[1]}');
    }

    widget.onPickTaxa(
      _pickedTaxa,
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
          label: Text('Seleccionar especies de lista'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickOnGrid,
        ),
      ],
    );
  }
}
