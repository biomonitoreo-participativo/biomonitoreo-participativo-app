import 'dart:collection';

import 'package:biomonitoreoparticipativoapp/models/input_observation_quantity.dart';
import 'package:biomonitoreoparticipativoapp/models/observation.dart';
import 'package:biomonitoreoparticipativoapp/models/provider_datetime.dart';
import 'package:biomonitoreoparticipativoapp/models/provider_location.dart';
import 'package:biomonitoreoparticipativoapp/models/provider_observer.dart';
import 'package:biomonitoreoparticipativoapp/screens/pdf_viewer_screen.dart';
import 'package:biomonitoreoparticipativoapp/widgets/observations_list_view.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
              'Observador: ${Provider.of<ProviderObserver>(context).getName()}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Localidad: ${Provider.of<ProviderLocation>(context).getName()}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Fecha: ${Provider.of<ProviderDateTime>(context).getLabel()}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Text(
              'Cantidad de especies observadas: ${Provider.of<ObservationData>(context).getCountObservationsQtyGt0()}',
              style: TextStyle(fontSize: 16.0),
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
    String observerName = Provider.of<ProviderObserver>(context).getName();
    String dateTimeLabel = Provider.of<ProviderDateTime>(context).getLabel();
    String locationName = Provider.of<ProviderLocation>(context).getName();
    int observedSpecies =
        Provider.of<ObservationData>(context).getCountObservationsQtyGt0();
    List<Observation> data =
        Provider.of<ObservationData>(context).getObservationsQtyGt0();

    String fileName = '$observerName-$dateTimeLabel-$locationName.pdf';

    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
          pdfLib.Center(
            child: pdfLib.Text(
              'Biomonitoreo participativo',
              style: pdfLib.TextStyle(
                  fontSize: 26, fontWeight: pdfLib.FontWeight.bold),
            ),
          ),
          pdfLib.Center(
            child: pdfLib.Text(
              'Especies indicadoras',
              style: pdfLib.TextStyle(
                  fontSize: 24, fontWeight: pdfLib.FontWeight.bold),
            ),
          ),
          pdfLib.Text('\n\n\n'),
          pdfLib.Text('Observador: ${observerName}\n'),
          pdfLib.Text('Localidad: ${locationName}\n'),
          pdfLib.Text('Fecha y hora: ${dateTimeLabel}\n'),
          pdfLib.Text('\n'),
          pdfLib.Text('Cantidad de especies observadas: ${observedSpecies}\n'),
          pdfLib.Text('\n\n'),
          pdfLib.Center(
            child: pdfLib.Text('Observaciones'),
          ),
          pdfLib.Text('\n'),
          pdfLib.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              <String>['Cantidad', 'Nombre científico', 'Nombre común'],
              ...data.map(
                (obs) => [
                  obs.quantity.toString(),
                  obs.taxon.scientificName,
                  obs.taxon.vernacularName,
                ],
              ),
            ],
          ),
        ],
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);

    //final String path = '$dir/monitoreo.pdf';
    final String path = '$dir/$fileName';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PDFViewerScreen(path: path),
      ),
    );
    // Navigator.pushNamed(context, PDFViewerScreen.id);
  }
}
