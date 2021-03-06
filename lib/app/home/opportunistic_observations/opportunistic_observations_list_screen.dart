import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_edit_screen.dart';
import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/list_items_builder.dart';

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
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Occurrence>>(
      stream: database.opportunisticOccurrencesStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Occurrence>(
          snapshot: snapshot,
          itemBuilder: (context, occurrence) => Dismissible(
            key: Key('occurrence-${occurrence.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, occurrence),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmación de borrado"),
                    content:
                        const Text("¿Está seguro de borrar la observación?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Sí")),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
            child: OpportunisticObservationListTile(
              occurrence: occurrence,
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
