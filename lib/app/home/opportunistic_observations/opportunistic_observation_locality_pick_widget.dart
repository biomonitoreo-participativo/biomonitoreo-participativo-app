import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_locality_pick_screen.dart';

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
    try {
      final locData = await Location().getLocation();
      _selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => LocalityPickMap(
            initialLocality: [locData.longitude, locData.latitude],
            isSelecting: true,
          ),
        ),
      );
    } catch (error) {
      return;
    }

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
