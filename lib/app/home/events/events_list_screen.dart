import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_edit_screen.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/list_items_builder.dart';

class EventsListScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos de monitoreo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EventEditScreen.show(
              context,
              database: Provider.of<Database>(context),
            ),
            tooltip: "Crear un evento",
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
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
              onTap: () => EventEditScreen.show(
                context,
                database: Provider.of<Database>(context),
                event: event,
              ),
            ),
          ),
        );
      },
    );
  }
}
