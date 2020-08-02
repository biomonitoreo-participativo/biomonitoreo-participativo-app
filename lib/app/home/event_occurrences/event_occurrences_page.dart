import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/occurrence_list_item.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/occurrence_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_edit_screen.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/list_items_builder.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';

class EventOccurrencesPage extends StatelessWidget {
  final Database database;
  final Event event;

  const EventOccurrencesPage({@required this.database, @required this.event});

  static Future<void> show(BuildContext context, Event event) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) =>
            EventOccurrencesPage(database: database, event: event),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Occurrence occurrence) async {
    try {
      await database.deleteOccurrence(occurrence);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Se produjo un error',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
        stream: database.eventStream(eventId: event.id),
        builder: (context, snapshot) {
          final event = snapshot.data;
          final eventLocality = event?.locality ?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              // title: Text(eventLocality),
              title: Text("Observaciones"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () => EventEditScreen.show(
                    context,
                    database: database,
                    event: event,
                  ),
                  tooltip: "Editar el evento",
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () => OccurrencePage.show(
                    context: context,
                    database: database,
                    event: event,
                  ),
                  tooltip: "Crear una observación",
                ),
              ],
            ),
            body: _buildContent(context, event),
          );
        });
  }

  Widget _buildContent(BuildContext context, Event event) {
    return StreamBuilder<List<Occurrence>>(
      stream: database.occurrencesStream(event: event),
      builder: (context, snapshot) {
        return ListItemsBuilder<Occurrence>(
          snapshot: snapshot,
          itemBuilder: (context, occurrence) {
            return DismissibleEntryListItem(
              key: Key('occurrence-${occurrence.id}'),
              entry: occurrence,
              job: event,
              onDismissed: () => _deleteEntry(context, occurrence),
              onTap: () => OccurrencePage.show(
                context: context,
                database: database,
                event: event,
                occurrence: occurrence,
              ),
            );
          },
        );
      },
    );
  }
}
