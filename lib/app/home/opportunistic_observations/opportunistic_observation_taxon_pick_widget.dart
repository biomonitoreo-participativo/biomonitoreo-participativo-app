import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_taxon_pick_screen.dart';

class OpportunisticObservationTaxonPickerWidget extends StatefulWidget {
  final Function onPickTaxon;

  OpportunisticObservationTaxonPickerWidget(this.onPickTaxon);

  @override
  _OpportunisticObservationTaxonPickerWidgetState createState() =>
      _OpportunisticObservationTaxonPickerWidgetState();
}

class _OpportunisticObservationTaxonPickerWidgetState
    extends State<OpportunisticObservationTaxonPickerWidget> {
  List _pickedTaxon;

  Future<void> _pickOnGrid() async {
    _pickedTaxon = await Navigator.of(context).push<List<Object>>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => OpportunisticObservationPickScreen(),
      ),
    );

    if (_pickedTaxon == null) {
      return;
    }

    widget.onPickTaxon(
      _pickedTaxon[0],
      _pickedTaxon[1],
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
