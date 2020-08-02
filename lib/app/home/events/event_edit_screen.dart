import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_pick_widget.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';
import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_taxon_picker_widget.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'event_location_pick_widget.dart';
import 'event_taxa_cart.dart';

var _localityController;
var _decimalLongitudeController;
var _decimalLatitudeController;
var _scientificNameController;
var _vernacularNameController;
var _individualCountController;

class EventEditScreen extends StatefulWidget {
  final Database database;
  final Event event;

  const EventEditScreen({Key key, @required this.database, this.event})
      : super(key: key);

  static Future<void> show(
    BuildContext context, {
    Database database,
    Event event,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EventEditScreen(
          database: database,
          event: event,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  final _formKeyEvent = GlobalKey<FormState>();
  final _formKeyOccurrence = GlobalKey<FormState>();

  var _taxaData;
  var _taxaCart;

  double _decimalLongitude;
  double _decimalLatitude;
  String _locality;
  DateTime _eventDate = DateTime.now();
  String _eventRemarks;

  String _eventID;
  String _taxonID;
  String _basisOfRecord = 'Human Observation';
  String _kingdom = 'Animalia';
  String _phylum;
  String _class_;
  String _order;
  String _family;
  String _genus;
  String _specificEpithet;
  String _scientificName;
  String _scientificNameAuthorship;
  String _vernacularName = '';
  String _taxonRank = 'species';
  int _individualCount = 1;
  String _countryCode = 'CR';
  String _geodeticDatum = 'EPSG:4326';
  String _occurrenceRemarks = '';
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  List<String> _pickedTaxon;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _locality = widget.event.locality;
      _decimalLongitude = widget.event.decimalLongitude;
      _decimalLatitude = widget.event.decimalLatitude;
      _eventDate = widget.event.eventDate;
      _eventRemarks = widget.event.eventRemarks;
    }

    _localityController = TextEditingController(text: _locality);
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude != null ? '$_decimalLongitude' : null,
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude != null ? '$_decimalLatitude' : null,
    );

    _scientificNameController = TextEditingController(text: _scientificName);
    _vernacularNameController = TextEditingController(text: _vernacularName);
    _individualCountController = TextEditingController(
      text: _individualCount.toString(),
    );
  }

  bool _validateAndSaveFormEvent() {
    final formEvent = _formKeyEvent.currentState;
    if (formEvent.validate()) {
      formEvent.save();
      return true;
    }
    return false;
  }

  bool _validateAndSaveFormOccurrence() {
    final formOccurrence = _formKeyOccurrence.currentState;
    if (formOccurrence.validate()) {
      formOccurrence.save();
      return true;
    }
    return false;
  }

  Future<void> _submmit() async {
    if (_validateAndSaveFormEvent()) {
      try {
        final id = widget.event?.id ?? documentIdFromCurrentDate();
        final event = Event(
          id: id,
          locality: _locality,
          decimalLongitude: _decimalLongitude,
          decimalLatitude: _decimalLatitude,
          eventDate: _eventDate,
          eventRemarks: _eventRemarks,
        );
        await widget.database.setEvent(event);

        final occId = documentIdFromCurrentDate();
        final occurrence = Occurrence(
          id: occId,
          eventID: id,
          taxonID: _taxonID,
          basisOfRecord: _basisOfRecord,
          kingdom: _kingdom,
          phylum: _phylum,
          class_: _class_,
          order: _order,
          family: _family,
          genus: _genus,
          specificEpithet: _specificEpithet,
          scientificName: _scientificName,
          scientificNameAuthorship: _scientificNameAuthorship,
          vernacularName: _vernacularName,
          taxonRank: _taxonRank,
          individualCount: _individualCount,
          countryCode: _countryCode,
          locality: _locality,
          decimalLongitude: _decimalLongitude,
          decimalLatitude: _decimalLatitude,
          geodeticDatum: _geodeticDatum,
          eventDate: _eventDate,
          occurrenceRemarks: _occurrenceRemarks,
          start: _eventDate,
          end: _eventDate,
        );
        await widget.database.setOccurrence(occurrence);

        Navigator.of(context).pop();
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
    _taxaData = Provider.of<Taxa>(context, listen: false);

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildFormEvent(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormEvent() {
    return Form(
      key: _formKeyEvent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormEventChildren(),
      ),
    );
  }

  List<Widget> _buildFormEventChildren() {
    return [
      DateTimeField(
        decoration: InputDecoration(labelText: 'Fecha'),
        format: DateFormat("yyyy-MM-dd"),
        initialValue: _eventDate,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(2018),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2020),
            locale: Locale('es'),
          );
        },
        onSaved: (value) => _eventDate = value,
      ),
      EventLocationPickWidget(_selectPlace),
      Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              readOnly: true,
              controller: _decimalLongitudeController,
              decoration: InputDecoration(labelText: 'Longitud'),
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              onSaved: (value) =>
                  _decimalLongitude = double.tryParse(value) ?? 0.0,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: TextFormField(
              readOnly: true,
              controller: _decimalLatitudeController,
              decoration: InputDecoration(labelText: 'Latitud'),
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              onSaved: (value) =>
                  _decimalLatitude = double.tryParse(value) ?? 0.0,
            ),
          ),
        ],
      ),
      TextFormField(
        controller: _localityController,
        decoration: InputDecoration(labelText: 'Localidad'),
        validator: (value) =>
            value.isNotEmpty ? null : 'La localidad no puede estar vacía',
        onSaved: (value) => _locality = value,
      ),
      EventTaxaPickWidget(_selectTaxon),
      TextFormField(
        readOnly: true,
        controller: _scientificNameController,
        decoration: InputDecoration(
          labelText: 'Nombre científico',
        ),
        style: TextStyle(fontStyle: FontStyle.italic),
        validator: (value) => value.isNotEmpty
            ? null
            : 'El nombre científico no puede estar vacío',
        onSaved: (value) => _scientificName = value,
      ),
      TextFormField(
        readOnly: true,
        controller: _vernacularNameController,
        decoration: InputDecoration(labelText: 'Nombre común'),
        onSaved: (value) => _vernacularName = value,
      ),
      TextFormField(
        controller: _individualCountController,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        decoration: InputDecoration(
          labelText: 'Cantidad',
        ),
        onChanged: (value) => _individualCount = int.tryParse(value) ?? 0,
      ),
      _buildTaxaListView(),
      TextFormField(
        keyboardType: TextInputType.text,
        maxLength: 50,
        maxLines: null,
        decoration: InputDecoration(labelText: 'Comentarios'),
        initialValue: _eventRemarks != null ? '$_eventRemarks' : null,
        onSaved: (value) => _eventRemarks = value,
      ),
    ];
  }

  Widget _buildTaxaListView() {
    _taxaCart = Provider.of<EventTaxaCart>(context, listen: false);
    var _items = _taxaCart.items;
    print('_taxaCart.itemCount: ${_taxaCart.itemCount}');
    if (_taxaCart.itemCount > 0) {
      print('ITEMCOUNT');
      print('item: ${_taxaCart.items.values.toList()[0].taxonId}');
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 100,
      width: 300,
      child: ListView.separated(
          itemCount: _taxaCart.itemCount,
          separatorBuilder: (context, index) => Divider(
                height: 0.5,
              ),
          itemBuilder: (context, index) {
            var _taxonId = _taxaCart.items.values.toList()[index].taxonId;
            return Column(
              children: [
                Text('${_taxaData.findById(_taxonId).scientificName}'),
                Text('${_taxaData.findById(_taxonId).vernacularName}'),
              ],
            );
          }),
    );
  }

  void _selectPlace(
      double decimalLongitude, double decimalLatitude, String locality) {
    setState(() {
      _decimalLongitude = decimalLongitude;
      _decimalLatitude = decimalLatitude;
      _locality = locality;
    });
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude.toStringAsFixed(6),
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude.toStringAsFixed(6),
    );
    _localityController = TextEditingController(text: _locality);
  }

  void _selectTaxon(String taxonId, int individualCount) {
    Taxon taxon = _taxaData.findById(taxonId);

    _pickedTaxon = [taxon.scientificName, individualCount.toString()];
    setState(() {
      _taxonID = taxon.id;
      _kingdom = taxon.kingdom;
      _phylum = taxon.phylum;
      _class_ = taxon.class_;
      _order = taxon.order;
      _family = taxon.family;
      _genus = taxon.genus;
      _specificEpithet = taxon.specificEpithet;
      _scientificName = taxon.scientificName;
      _vernacularName = taxon.vernacularName;
      _scientificNameAuthorship = taxon.scientificNameAuthorship;
      _taxonRank = taxon.taxonRank;
      _individualCount = individualCount;
    });
    _scientificNameController = TextEditingController(
      text: _scientificName,
    );
    _vernacularNameController = TextEditingController(
      text: _vernacularName,
    );
    _individualCountController = TextEditingController(
      text: _individualCount.toString(),
    );
  }
}
