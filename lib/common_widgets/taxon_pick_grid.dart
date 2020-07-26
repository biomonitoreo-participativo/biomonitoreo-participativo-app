import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/taxon_data.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_grid_tile.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TaxonPickGrid extends StatefulWidget {
  final List<double> initialLocality;
  final bool isSelecting;

  TaxonPickGrid({
    this.initialLocality = const [-84.0, 10.0],
    this.isSelecting = false,
  });

  @override
  _TaxonPickGridState createState() => _TaxonPickGridState();
}

class _TaxonPickGridState extends State<TaxonPickGrid> {
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
    final taxaData = Provider.of<Taxa>(context);
    final taxa = taxaData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar taxón'),
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
      body: GridView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: taxa.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: taxa[i],
          child: TaxonGridTile(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
      ),
    );
  }
}
