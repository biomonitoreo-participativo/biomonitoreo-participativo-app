import 'package:flutter/material.dart';

class ObservationTile extends StatelessWidget {
  final String observationTitle;
  final String observationTrailing;
  final Function longPressCallback;

  ObservationTile({
    this.observationTitle,
    this.observationTrailing,
    this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(observationTitle),
      trailing: Text(observationTrailing),
      onLongPress: longPressCallback,
    );
  }
}
