import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/widgets/observations_list.dart';
import 'package:biomonitoreoparticipativoapp/models/observation_data.dart';

class SummaryScreen extends StatefulWidget {
  static const String id = 'summary_screen';

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Resumen del monitoreo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Observador: Manuel Vargas',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Localidad: Savegre Ecolodge',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Fecha y hora: 2020-04-01 14:00 (30 min)',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Comentarios: Dia nublado y con mucho viento...',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${Provider.of<ObservationData>(context).observationsCount} observaciones',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // child: ObservationsList(),
            ),
          ),
        ],
      ),
    );
  }
}
