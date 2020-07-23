import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';

class OpportunisticObservationListTile extends StatelessWidget {
  final Occurrence occurrence;
  final VoidCallback onTap;

  const OpportunisticObservationListTile(
      {Key key, @required this.occurrence, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${occurrence.scientificName}'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
