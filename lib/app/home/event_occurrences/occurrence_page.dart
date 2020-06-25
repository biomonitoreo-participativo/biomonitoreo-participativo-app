import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/date_time_picker.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/format.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';

class OccurrencePage extends StatefulWidget {
  final Event event;
  final Occurrence occurrence;
  final Database database;

  const OccurrencePage(
      {@required this.database, @required this.event, this.occurrence});

  static Future<void> show(
      {BuildContext context,
      Database database,
      Event event,
      Occurrence occurrence}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => OccurrencePage(
            database: database, event: event, occurrence: occurrence),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _OccurrencePageState();
}

class _OccurrencePageState extends State<OccurrencePage> {
  String _scientificName;
  int _quantity;
  String _occurrenceRemarks;
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    final start = widget.occurrence?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.occurrence?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _scientificName = widget.occurrence?.scientificName ?? '';
    _quantity = widget.occurrence?.quantity ?? 1;
    _occurrenceRemarks = widget.occurrence?.occurrenceRemarks ?? '';
  }

  Occurrence _entryFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final id = widget.occurrence?.id ?? documentIdFromCurrentDate();
    return Occurrence(
      id: id,
      eventId: widget.event.id,
      scientificName: _scientificName,
      quantity: _quantity,
      occurrenceRemarks: _occurrenceRemarks,
      start: start,
      end: end,
    );
  }

  Future<void> _setEntryAndDismiss(BuildContext context) async {
    try {
      final entry = _entryFromState();
      await widget.database.setOccurrence(entry);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Falló la operación',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.event.locality),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.occurrence != null ? 'Editar' : 'Crear',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _setEntryAndDismiss(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
/*              _buildStartDate(),
              _buildEndDate(),
              SizedBox(height: 8.0),
              _buildDuration(),*/
              SizedBox(height: 8.0),
              _buildScientificName(),
              SizedBox(height: 8.0),
              _buildQuantity(),
              SizedBox(height: 8.0),
              _buildComment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScientificName() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _scientificName),
      decoration: InputDecoration(
        labelText: 'Nombre científico',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (scientificName) => _scientificName = scientificName,
    );
  }

  Widget _buildQuantity() {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      //maxLength: 50,
      //controller: TextEditingController(text: _scientificName),
      decoration: InputDecoration(
        labelText: 'Cantidad',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      onChanged: (value) => _quantity = int.tryParse(value) ?? 0,
    );
  }

  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _occurrenceRemarks),
      decoration: InputDecoration(
        labelText: 'Comentarios',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (occurrenceRemarks) => _occurrenceRemarks = occurrenceRemarks,
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Inicio',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectDate: (date) => setState(() => _startDate = date),
      onSelectTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'Fin',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectDate: (date) => setState(() => _endDate = date),
      onSelectTime: (time) => setState(() => _endTime = time),
    );
  }

  Widget _buildDuration() {
    final currentEntry = _entryFromState();
    final durationFormatted = Format.hours(currentEntry.durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duración: $durationFormatted',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

/*  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _occurrenceRemarks),
      decoration: InputDecoration(
        labelText: 'Comentarios',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (comment) => _occurrenceRemarks = comment,
    );
  }*/
}
