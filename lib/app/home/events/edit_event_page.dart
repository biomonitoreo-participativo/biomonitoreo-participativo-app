import 'package:biomonitoreoparticipativoapp/app/home/observations/localities_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';
import 'package:intl/intl.dart';

var _decimalLongitudeController;
var _decimalLatitudeController;
var _consAreaController;
var _localityController;

void _updateControllers(String result) {
  if (result == "Finca Esteban Cordero") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.84320";
    _decimalLatitudeController.text = "9.43039";
  } else if (result == "Finca de Victor") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.85632";
    _decimalLatitudeController.text = "9.43362";
  } else if (result == "Finca de Andrey y Sonia") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.80704";
    _decimalLatitudeController.text = "9.48405";
  } else if (result == "Finca de Rafael") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.79451";
    _decimalLatitudeController.text = "9.50930";
  } else if (result == "Sendero 3") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.80604";
    _decimalLatitudeController.text = "9.48670";
  } else if (result == "Finca Cosme Gamboa") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.69381";
    _decimalLatitudeController.text = "9.50198";
  } else if (result == "Finca de Errol Salazar") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.70460";
    _decimalLatitudeController.text = "9.53331";
  } else if (result == "Finca Martín Salazar") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.71342";
    _decimalLatitudeController.text = "9.54667";
  } else if (result == "Camino San Gerardo Los Ángeles") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.59874";
    _decimalLatitudeController.text = "9.46367";
  } else if (result == "Reserva Cloud Bridge") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.57746";
    _decimalLatitudeController.text = " 	9.47210";
  } else if (result == "Sendero Zaddy") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.50421";
    _decimalLatitudeController.text = "9.34146";
  } else if (result == "Sendero Ena") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.49639";
    _decimalLatitudeController.text = "9.36354";
  } else if (result == "Sendero Perica") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.45692";
    _decimalLatitudeController.text = "9.28686";
  } else if (result == "Guadalajara") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.37892";
    _decimalLatitudeController.text = " 9.23980";
  } else if (result == "Sendero Mirador") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.39225";
    _decimalLatitudeController.text = " 9.25712";
  } else if (result == "Ruta las aves") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.37080";
    _decimalLatitudeController.text = " 9.27587";
  } else if (result == "Ujarrás") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.30128";
    _decimalLatitudeController.text = "9.23270";
  } else if (result == "Sendero Zapotal") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.33883";
    _decimalLatitudeController.text = "9.26302";
  } else if (result == "Sendero Parcelas") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.11559";
    _decimalLatitudeController.text = "9.08958";
  } else if (result == "Sendero Huacas") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.06877";
    _decimalLatitudeController.text = "9.11940";
  } else if (result == "Sendero 1") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.05455";
    _decimalLatitudeController.text = "9.02319";
  } else if (result == "Finca María Isabel") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.03779";
    _decimalLatitudeController.text = "9.03876";
  } else if (result == "Sendero Biolley") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.04131";
    _decimalLatitudeController.text = "9.03426";
  } else if (result == "Sendero Colorado") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.02309";
    _decimalLatitudeController.text = "9.01146";
  } else if (result == "Sendero Asoprola") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.00901";
    _decimalLatitudeController.text = "9.00549";
  } else if (result == "Sendero Cabagra") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.19557";
    _decimalLatitudeController.text = "9.13701";
  } else if (result == "Sendero Chánguena") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-83.20337";
    _decimalLatitudeController.text = "8.93879";
  } else if (result == "Sendero Pittier") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-82.93996";
    _decimalLatitudeController.text = "8.95203";
  } else if (result == "Sendero Tablas") {
    _localityController.text = result;
    _decimalLongitudeController.text = "-82.81732";
    _decimalLatitudeController.text = "8.88802";
  }
}

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

    _localityController = TextEditingController(text: _locality);
    _consAreaController = TextEditingController(text: 'ACLAP');
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude != null ? '$_decimalLongitude' : null,
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude != null ? '$_decimalLatitude' : null,
    );
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
        //if (allLocalities.contains(_locality)) { //TODO: no tiene sentido esta pregunta, hay que quitarla
        if (false) {
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
        title: Text(
            widget.event == null ? 'Creación de evento' : 'Edición de evento'),
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

  var _items = <String>[
    "Finca Esteban Cordero",
    "Finca de Victor",
    "Finca de Andrey y Sonia",
  ];

  List<Widget> _buildFormChildren() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SelectionButton(),
      ),
      TextFormField(
        controller: _localityController,
        decoration: InputDecoration(labelText: 'Localidad'),
        //initialValue: _locality,
        validator: (value) =>
            value.isNotEmpty ? null : 'La localidad no puede estar vacía',
        onSaved: (value) => _locality = value,
      ),
/*      DropdownButtonFormField(
          value: _locality,
          // hint: Text("Seleccione la localidad"),
          decoration: InputDecoration(labelText: 'Localidad'),
          onChanged: (result) {
            setState(() {
              print(result);
              _updateControllers(result);
              _locality = result;
            });
          },
          items: _items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList()),*/
      TextFormField(
        controller: _decimalLongitudeController,
        decoration: InputDecoration(labelText: 'Longitud'),
        //initialValue: _decimalLongitude != null ? '$_decimalLongitude' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        onSaved: (value) => _decimalLongitude = double.tryParse(value) ?? 0.0,
      ),
      TextFormField(
        controller: _decimalLatitudeController,
        decoration: InputDecoration(labelText: 'Latitud'),
        //initialValue: _decimalLatitude != null ? '$_decimalLatitude' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        onSaved: (value) => _decimalLatitude = double.tryParse(value) ?? 0.0,
      ),
      TextFormField(
        controller: _consAreaController,
        decoration: InputDecoration(labelText: 'Área de Conservación'),
        //initialValue: _conservationArea,
        validator: (value) => value.isNotEmpty
            ? null
            : 'El área de conservación no puede estar vacía',
        onSaved: (value) => _conservationArea = value,
      ),
      DateTimeField(
        decoration: InputDecoration(labelText: 'Fecha'),
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

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('Seleccione una localidad del mapa'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => SelectionScreen()),
      MaterialPageRoute(builder: (context) => LocalitiesPage()),
    );

    print('Resultado: $result');
    _updateControllers(result);

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
