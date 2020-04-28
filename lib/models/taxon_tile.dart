import 'package:flutter/material.dart';

class TaxonTile extends StatelessWidget {
  final String taxonTitle;
  final String taxonTrailing;
  final Function longPressCallback;

  TaxonTile({
    this.taxonTitle,
    this.taxonTrailing,
    this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taxonTitle),
      trailing: Text(taxonTrailing),
      onLongPress: longPressCallback,
    );
  }
}
