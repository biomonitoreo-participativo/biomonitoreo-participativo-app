import 'package:biomonitoreoparticipativoapp/common_widgets/locality_pick_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalityPicker extends StatefulWidget {
  final Function onSelectPlace;

  LocalityPicker(this.onSelectPlace);

  @override
  _LocalityPickerState createState() => _LocalityPickerState();
}

class _LocalityPickerState extends State<LocalityPicker> {
  String _localityText = 'Coordenadas no seleccionadas';
  LatLng _selectedLocation;

  void _updateLocalityText(double lat, double lng) {
    setState(() {
      _localityText =
          'Longitud: ${lng.toStringAsFixed(2)} Latitud: ${lat.toStringAsFixed(2)}';
    });
  }

  Future<void> _selectOnMap() async {
    _selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => LocalityPickMap(
          isSelecting: true,
        ),
      ),
    );

    if (_selectedLocation == null) {
      return;
    }

    _updateLocalityText(
      _selectedLocation.latitude,
      _selectedLocation.longitude,
    );

    widget.onSelectPlace(
      _selectedLocation.latitude,
      _selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(
            Icons.place,
          ),
          label: Text('Seleccionar coordenadas en mapa'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _selectOnMap,
        ),
      ],
    );
  }
}
