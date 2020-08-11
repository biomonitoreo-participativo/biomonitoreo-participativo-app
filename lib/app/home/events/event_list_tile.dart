import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/format.dart';

class EventListTile extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventListTile({Key key, @required this.event, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${event.locality}',
      ),
      subtitle: Text(
        '${DateFormat("yyyy/MM/dd HH:mm").format(event.startEventDate)} ${Format.hours(event.durationInHours)}',
      ),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
