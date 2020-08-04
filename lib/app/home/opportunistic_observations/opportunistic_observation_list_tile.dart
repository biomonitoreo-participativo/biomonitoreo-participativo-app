import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
      leading: Text('${DateFormat("yyyy/MM/dd").format(occurrence.eventDate)}'),
      title: Text(
        '${occurrence.scientificName} ${occurrence.individualCount}',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      subtitle: Text('${occurrence.vernacularName}'),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
