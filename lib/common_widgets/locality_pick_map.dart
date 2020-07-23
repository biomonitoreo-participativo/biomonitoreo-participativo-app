import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalityPickMap extends StatefulWidget {
  final List<double> initialLocality;
  final bool isSelecting;

  LocalityPickMap({
    this.initialLocality = const [-84.0, 10.0],
    this.isSelecting = false,
  });

  @override
  _LocalityPickMapState createState() => _LocalityPickMapState();
}

class _LocalityPickMapState extends State<LocalityPickMap> {
  LatLng _pickedLocality;

  void _pickLocality(LatLng position) {
    setState(() {
      _pickedLocality = position;
      print(
          'LocalityPickMap::_pickLocality() ${_pickedLocality.longitude} ${_pickedLocality.latitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar localidad'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocality == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocality);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocality[1],
            widget.initialLocality[0],
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _pickLocality : null,
        markers: (_pickedLocality == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('Inicio'),
                  position: _pickedLocality ??
                      LatLng(
                        widget.initialLocality[0],
                        widget.initialLocality[1],
                      ),
                ),
              },
      ),
    );
  }
}
