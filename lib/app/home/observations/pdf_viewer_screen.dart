import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFViewerScreen extends StatelessWidget {
  final String path;
  const PDFViewerScreen({Key key, this.path}) : super(key: key);

  static const String id = 'pdfViewer_screen';

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('PDF resumen'),
      ),
      path: path,
    );
  }
}
