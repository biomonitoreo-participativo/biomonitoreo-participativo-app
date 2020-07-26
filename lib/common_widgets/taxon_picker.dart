import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_pick_grid.dart';

class TaxonPicker extends StatefulWidget {
  final Function onSelectTaxon;

  TaxonPicker(this.onSelectTaxon);

  @override
  _TaxonPickerState createState() => _TaxonPickerState();
}

class _TaxonPickerState extends State<TaxonPicker> {
  String _taxonText = 'Especie no seleccionada';
  List<String> _selectedTaxon;

  void _updateTaxonText(String scientificName, int individualCount) {
    setState(() {
      _taxonText =
          'Especie: $scientificName, cantidad ${individualCount.toString()}';
    });
  }

  Future<void> _selectOnGrid() async {
    _selectedTaxon = await Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => TaxonPickGrid(
          isSelecting: true,
        ),
      ),
    );

    if (_selectedTaxon == null) {
      return;
    }

    _updateTaxonText(
      _selectedTaxon[0],
      int.tryParse(_selectedTaxon[1]),
    );

    widget.onSelectTaxon(
      _selectedTaxon[0],
      int.tryParse(_selectedTaxon[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
/*        Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Text(
            _localityText,
            textAlign: TextAlign.center,
          ),
        ),*/
        FlatButton.icon(
          icon: Icon(
            Icons.map,
          ),
          label: Text('Seleccionar taxón'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _selectOnGrid,
        ),
      ],
    );
  }
}
