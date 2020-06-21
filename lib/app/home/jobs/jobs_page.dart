import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/app/home/job_entries/job_entries_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/jobs/edit_job_page.dart';
import 'package:biomonitoreoparticipativoapp/app/home/jobs/empty_content.dart';
import 'package:biomonitoreoparticipativoapp/app/home/jobs/job_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/jobs/list_items_builder.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';

import '../models/job.dart';

class JobsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Error al desplegar trabajos',
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
        title: Text('Jobs'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditJobPage.show(
              context,
              database: Provider.of<Database>(context),
            ),
          ),
        ],
      ),
      body: _builContents(context),
    );
  }

  Widget _builContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}
