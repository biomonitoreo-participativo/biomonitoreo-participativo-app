import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/format.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';

class OccurrenceListItem extends StatelessWidget {
  final Occurrence occurrence;
  final Event event;
  final VoidCallback onTap;

  const OccurrenceListItem({
    @required this.occurrence,
    @required this.event,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final scientificName = occurrence.scientificName;
    final quantity = occurrence.individualCount;

    final dayOfWeek = Format.dayOfWeek(occurrence.start);
    final startDate = Format.date(occurrence.start);
    final startTime = TimeOfDay.fromDateTime(occurrence.start).format(context);
    final endTime = TimeOfDay.fromDateTime(occurrence.end).format(context);
    final durationFormatted = Format.hours(occurrence.durationInHours);

    final pay = event.ratePerHour * occurrence.durationInHours;
    final payFormatted = Format.currency(pay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text('$scientificName ($quantity)',
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          //Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          //SizedBox(width: 15.0),
          //Text(startDate, style: TextStyle(fontSize: 18.0)),
          if (event.ratePerHour > 0.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              payFormatted,
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ]),
        if (occurrence.occurrenceRemarks.isNotEmpty)
          Text(
            occurrence.occurrenceRemarks,
            style: TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    this.key,
    this.entry,
    this.job,
    this.onDismissed,
    this.onTap,
  });

  final Key key;
  final Occurrence entry;
  final Event job;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      child: OccurrenceListItem(
        occurrence: entry,
        event: job,
        onTap: onTap,
      ),
    );
  }
}
