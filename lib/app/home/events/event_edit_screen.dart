import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';

import 'package:biomonitoreoparticipativoapp/app/home/events/event_location_pick_widget.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_cart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/events/event_taxa_pick_widget.dart';

// Text editing controllers
var _localityController;
var _decimalLongitudeController;
var _decimalLatitudeController;

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
  final _formKey = GlobalKey<FormState>();

  double _decimalLongitude;
  double _decimalLatitude;
  String _locality;
  DateTime _eventDate = DateTime.now();
  String _eventRemarks;

  String _basisOfRecord = 'Human Observation';
  String _countryCode = 'CR';
  String _geodeticDatum = 'EPSG:4326';
  String _occurrenceRemarks = '';

  var _taxaData;
  var taxaCart;
  List _occurrencesList;
  var _occurrencesStream;

  var _pickedTaxa;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _locality = widget.event.locality;
      _decimalLongitude = widget.event.decimalLongitude;
      _decimalLatitude = widget.event.decimalLatitude;
      _eventDate = widget.event.eventDate;
      _eventRemarks = widget.event.eventRemarks;

      // Load occurrences data in List
      _occurrencesStream =
          widget.database.occurrencesStream(event: widget.event);

      _pickedTaxa = [];

      _occurrencesStream.listen((value) {
        for (var occ in value) {
          setState(() {
            _pickedTaxa.add([occ.taxonID, occ.individualCount]);
          });
        }
      });
    }

    _localityController = TextEditingController(
      text: _locality,
    );
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude != null ? '$_decimalLongitude' : null,
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude != null ? '$_decimalLatitude' : null,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    taxaCart = Provider.of<EventTaxaCart>(context);
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
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Guardar evento',
            onPressed: _submmit,
          ),
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
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            readOnly: true,
            controller: _localityController,
            decoration: InputDecoration(labelText: 'Localidad'),
            validator: (value) =>
                value.isNotEmpty ? null : 'La localidad no puede estar vacía',
            onSaved: (value) => _locality = value,
          ),
          EventTaxaPickWidget(_pickTaxa),
          _buildPickedTaxaListView(),
          TextFormField(
            keyboardType: TextInputType.text,
            maxLength: 50,
            maxLines: null,
            decoration: InputDecoration(labelText: 'Comentarios'),
            initialValue: _eventRemarks != null ? '$_eventRemarks' : null,
            onSaved: (value) => _eventRemarks = value,
          ),
        ],
      ),
    );
  }

  bool _validateAndSaveForm() {
    final formEvent = _formKey.currentState;
    if (formEvent.validate()) {
      formEvent.save();
      return true;
    }
    return false;
  }

  Future<void> _submmit() async {
    if (_validateAndSaveForm()) {
      try {
        final eventId = widget.event?.id ?? documentIdFromCurrentDate();
        final event = Event(
          id: eventId,
          locality: _locality,
          decimalLongitude: _decimalLongitude,
          decimalLatitude: _decimalLatitude,
          eventDate: _eventDate,
          eventRemarks: _eventRemarks,
        );
        await widget.database.setEvent(event);

        print(
          'event_edit_screen_dart::_submit::_pickedTaxa.length ${_pickedTaxa.length}',
        );
        for (var taxaItem in _pickedTaxa) {
          print('_pickedTaxaItem: [0]: ${taxaItem[0]} [1]: ${taxaItem[1]}');
          final taxonId = taxaItem[0];
          final individualCount = taxaItem[1];

          Taxon taxon = _taxaData.findById(taxonId);

          final occurrenceId = documentIdFromCurrentDate();
          final occurrence = Occurrence(
            id: occurrenceId,
            eventID: eventId,
            taxonID: taxonId,
            basisOfRecord: _basisOfRecord,
            kingdom: taxon.kingdom,
            phylum: taxon.phylum,
            class_: taxon.class_,
            order: taxon.order,
            family: taxon.family,
            genus: taxon.genus,
            specificEpithet: taxon.specificEpithet,
            scientificName: taxon.scientificName,
            scientificNameAuthorship: taxon.scientificNameAuthorship,
            vernacularName: taxon.vernacularName,
            taxonRank: taxon.taxonRank,
            individualCount: individualCount,
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
        }

        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Error al ingresar evento',
          exception: e,
        ).show(context);
      }
    }
  }

  void _selectPlace(
    double decimalLongitude,
    double decimalLatitude,
    String locality,
  ) {
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

  void _pickTaxa(List pickedTaxa) {
    _pickedTaxa = pickedTaxa;
  }

  Widget _buildPickedTaxaListView() {
    if (_pickedTaxa == null) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      height: 100,
      child: ListView.separated(
          itemCount: _pickedTaxa.length,
          separatorBuilder: (context, index) => Divider(
                height: 0.5,
              ),
          itemBuilder: (context, index) {
            var _taxonId = _pickedTaxa[index][0];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_pickedTaxa[index][1]}'),
                SizedBox(width: 4.0),
                Text(
                  '${_taxaData.findById(_taxonId).scientificName}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(width: 4.0),
                Text('(${_taxaData.findById(_taxonId).vernacularName})'),
              ],
            );
          }),
    );
  }
}