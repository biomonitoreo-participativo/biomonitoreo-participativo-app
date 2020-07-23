import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';

import 'opportunistic_observation_edit_screen.dart';
import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/list_items_builder.dart';

class OpportunisticObservationsListScreen extends StatelessWidget {
  Future<void> _delete(BuildContext context, Occurrence occurrence) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteOccurrence(occurrence);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Error al desplegar observaciones oportunistas',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observaciones oportunistas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => OpportunisticObservationEditScreen.show(
              context,
              database: Provider.of<Database>(context),
            ),
            tooltip: "Crear una observación",
          ),
        ],
      ),
      body: _builContents(context),
    );
  }

  Widget _builContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Occurrence>>(
      stream: database.occurrencesStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Occurrence>(
          snapshot: snapshot,
          itemBuilder: (context, occurrence) => Dismissible(
            key: Key('occurrence-${occurrence.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, occurrence),
            child: OpportunisticObservationListTile(
              occurrence: occurrence,
              //onTap: () => EventOccurrencesPage.show(context, event),
              onTap: () => OpportunisticObservationEditScreen.show(
                context,
                database: Provider.of<Database>(context),
                occurrence: occurrence,
              ),
            ),
          ),
        );
      },
    );
  }
}
