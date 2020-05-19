import 'dart:collection';

import 'package:biomonitoreoparticipativoapp/models/input_observation_quantity.dart';
import 'package:biomonitoreoparticipativoapp/models/observation.dart';
import 'package:biomonitoreoparticipativoapp/models/taxon.dart';
import 'package:biomonitoreoparticipativoapp/screens/pdf_viewer.dart';
import 'package:biomonitoreoparticipativoapp/widgets/observations_list_view.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/models/observation_data.dart';

import 'package:pdf/widgets.dart' as pdfLib;
import 'dart:io';

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
          Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${Provider.of<InputObservationQuantity>(context).getQuantity()} especies observadas',
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
              child: ObservationsListView(),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RoundedButton(
                title: 'Generar PDF',
                colour: Colors.blue,
                onPressed: () => _generatePdfAndView(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _generatePdfAndView(context) async {
    List<Observation> data = [
      Observation(
        id: '000000001',
        taxon: Taxon(
          id: '000001',
          scientificName: 'Panthera onca',
          scientificNameAuthorship: '(Linnaeus, 1758)',
          vernacularName: 'Jaguar',
          taxonRank: 'species',
        ),
        quantity: 2,
      ),
      Observation(
        id: '000000002',
        taxon: Taxon(
          id: '000002',
          scientificName: 'Puma concolor',
          scientificNameAuthorship: '(Linnaeus, 1771)',
          vernacularName: 'Puma',
          taxonRank: 'species',
        ),
        quantity: 4,
      ),
    ];

    // final UnmodifiableListView<Observation> data = Provider.of<ObservationData>(context).observations;

    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

/*
    pdf.addPage(
      pdfLib.Page(
        build: (pdfLib.Context context) => pdfLib.Center(
          child: pdfLib.Text('Hello World!'),
        ),
      ),
    );
*/

    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
          pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
            <String>['Cantidad', 'Nombre científico', 'Nombre común'],
            ...data.map((item) => [
                  item.quantity.toString(),
                  item.taxon.scientificName,
                  item.taxon.vernacularName,
                ])
          ]),
        ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);

    final String path = '$dir/monitoreo.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );

    //final file = File('example.pdf');
    //file.writeAsBytesSync(pdf.save());
  }
}
