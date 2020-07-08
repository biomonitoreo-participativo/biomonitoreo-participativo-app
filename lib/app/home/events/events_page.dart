import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/event_occurrences_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/edit_event_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/list_items_builder.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';

import '../models/event.dart';

class EventsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Event event) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteEvent(event);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Error al desplegar eventos',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inicio de código útil para pruebas
    // final database = Provider.of<Database>(context);
    // print('Listado de trabajos: ');
    // database.jobsStream();
    // Fin de código útil para pruebas

    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos de monitoreo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditEventPage.show(
              context,
              database: Provider.of<Database>(context),
            ),
            tooltip: "Crear un evento",
          ),
        ],
      ),
      body: _builContents(context),
    );
  }

  Widget _builContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Event>>(
      stream: database.eventsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Event>(
          snapshot: snapshot,
          itemBuilder: (context, event) => Dismissible(
            key: Key('event-${event.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, event),
            child: EventListTile(
              event: event,
              onTap: () => EventOccurrencesPage.show(context, event),
            ),
          ),
        );
      },
    );
  }
}