import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';
import 'package:intl/intl.dart';

class EditEventPage extends StatefulWidget {
  final Database database;
  final Event event;

  const EditEventPage({Key key, @required this.database, this.event})
      : super(key: key);

  static Future<void> show(
    BuildContext context, {
    Database database,
    Event event,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditEventPage(
          database: database,
          event: event,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();

  String _locality;
  double _decimalLongitude;
  double _decimalLatitude;
  DateTime _eventDateTime;
  String _eventRemarks;
  String _conservationArea;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _locality = widget.event.locality;
      _decimalLongitude = widget.event.decimalLongitude;
      _decimalLatitude = widget.event.decimalLatitude;
      _eventDateTime = widget.event.eventDateTime;
      _eventRemarks = widget.event.eventRemarks;
      _conservationArea = widget.event.conservationArea;
      _ratePerHour = widget.event.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submmit() async {
    if (_validateAndSaveForm()) {
      try {
        final events = await widget.database.eventsStream().first;
        final allLocalities = events.map((event) => event.locality).toList();
        if (widget.event != null) {
          allLocalities.remove(widget.event.locality);
        }
        if (allLocalities.contains(_locality)) {
          PlatformAlertDialog(
            title: 'La localidad ya está en uso',
            content: 'Por favor use una localidad diferente',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.event?.id ?? documentIdFromCurrentDate();
          final event = Event(
            id: id,
            locality: _locality,
            decimalLongitude: _decimalLongitude,
            decimalLatitude: _decimalLatitude,
            eventDateTime: _eventDateTime,
            eventRemarks: _eventRemarks,
            conservationArea: _conservationArea,
            //ratePerHour: _ratePerHour,
            ratePerHour: 1,
          );
          await widget.database.setEvent(event);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Error al ingresar evento',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.event == null ? 'Crear evento' : 'Editar evento'),
        actions: <Widget>[
          FlatButton(
            child: Text('Guardar',
                style: TextStyle(fontSize: 18.0, color: Colors.white)),
            onPressed: _submmit,
          )
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:
              Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Localidad'),
        initialValue: _locality,
        validator: (value) =>
            value.isNotEmpty ? null : 'La localidad no puede estar vacía',
        onSaved: (value) => _locality = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Longitud'),
        initialValue: _decimalLongitude != null ? '$_decimalLongitude' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        onSaved: (value) => _decimalLongitude = double.tryParse(value) ?? 0.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Latitud'),
        initialValue: _decimalLatitude != null ? '$_decimalLatitude' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        onSaved: (value) => _decimalLatitude = double.tryParse(value) ?? 0.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Área de Conservación'),
        initialValue: _conservationArea,
        validator: (value) => value.isNotEmpty
            ? null
            : 'El área de conservación no puede estar vacía',
        onSaved: (value) => _conservationArea = value,
      ),
/*      TextFormField(
        decoration: InputDecoration(labelText: 'Tasa por hora'),
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),*/
      DateTimeField(
        decoration: InputDecoration(labelText: 'Fecha y hora'),
        format: DateFormat("yyyy-MM-dd"),
        initialValue: _eventDateTime,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
            locale: Locale('es'),
          );
        },
        onSaved: (value) => _eventDateTime = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Comentarios'),
        initialValue: _eventRemarks != null ? '$_eventRemarks' : null,
        keyboardType: TextInputType.text,
        onSaved: (value) => _eventRemarks = value,
      ),
    ];
  }
}
