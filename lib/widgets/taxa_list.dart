import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/taxon_tile.dart';
import '../models/taxon_data.dart';

class TaxaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaxonData>(
      builder: (context, taxonData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final taxon = taxonData.taxa[index];
            return TaxonTile(
              taxonTitle: taxon.scientificName,
              taxonTrailing: taxon.vernacularName,
              longPressCallback: () {},
            );
          },
          itemCount: taxonData.taxaCount,
        );
      },
    );
  }
}
