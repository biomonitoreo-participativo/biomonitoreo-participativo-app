import 'package:location/location.dart';

import 'package:flutter/material.dart';

import 'event_location_pick_screen.dart';

class EventLocationPickWidget extends StatefulWidget {
  final Function onPickLocation;

  EventLocationPickWidget(this.onPickLocation);

  @override
  _EventLocationPickWidgetState createState() =>
      _EventLocationPickWidgetState();
}

class _EventLocationPickWidgetState extends State<EventLocationPickWidget> {
  String _localityText = 'Ubicación no seleccionada';
  List _pickedLocation;

  void _updateLocalityText(
    double decimalLongitude,
    double decimalLatitude,
    String locality,
  ) {
    setState(() {
      _localityText =
          'Longitud: ${decimalLongitude.toStringAsFixed(2)} Latitud: ${decimalLatitude.toStringAsFixed(2)}';
    });
  }

  Future<void> _selectOnMap() async {
    try {
      final locData = await Location().getLocation();
      _pickedLocation = await Navigator.of(context).push<List>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => EventLocationPickScreen(
            initialLocality: [locData.longitude, locData.latitude],
          ),
        ),
      );
    } catch (error) {
      return;
    }

    if (_pickedLocation == null) {
      return;
    }

    _updateLocalityText(
      _pickedLocation[0],
      _pickedLocation[1],
      _pickedLocation[2],
    );

    widget.onPickLocation(
      _pickedLocation[0],
      _pickedLocation[1],
      _pickedLocation[2],
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
          label: Text('Seleccionar localidad en mapa'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _selectOnMap,
        ),
      ],
    );
  }
}
