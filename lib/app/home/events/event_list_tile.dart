import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:intl/intl.dart';

class EventListTile extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventListTile({Key key, @required this.event, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${DateFormat("yyyy/MM/dd").format(event.eventDateTime)} - ${event.locality}'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
