import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:biomonitoreoparticipativoapp/constants.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_locality_pick_widget.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/opportunistic_observation_taxon_pick_widget.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/taxon_data.dart';

// Text editing controllers
var _individualCountController;
var _localityController;
var _decimalLatitudeController;
var _decimalLongitudeController;
var _scientificNameController;
var _vernacularNameController;

class OpportunisticObservationEditScreen extends StatefulWidget {
  final Database database;
  final Occurrence occurrence;

  const OpportunisticObservationEditScreen(
      {Key key, @required this.database, this.occurrence})
      : super(key: key);

  static Future<void> show(
    BuildContext context, {
    Database database,
    Occurrence occurrence,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => OpportunisticObservationEditScreen(
          database: database,
          occurrence: occurrence,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _OpportunisticObservationEditScreenState createState() =>
      _OpportunisticObservationEditScreenState();
}

class _OpportunisticObservationEditScreenState
    extends State<OpportunisticObservationEditScreen> {
  final _formKey = GlobalKey<FormState>();
  var _taxaData;

  String _basisOfRecord = kBasisOfRecord;
  String _occurrenceID;
  int _individualCount;
  String _occurrenceStatus = kOccurrenceStatus;
  String _occurrenceRemarks;
  String _eventID = kOpportunisticOccurrenceEventID;
  DateTime _eventDate;
  String _locationID;
  String _country = kCountry;
  String _countryCode = kCountryCode;
  String _locality;
  double _decimalLatitude;
  double _decimalLongitude;
  String _geodeticDatum = kGeodeticDatum;
  String _taxonID;
  String _scientificName;
  String _kingdom;
  String _phylum;
  String _class_;
  String _order;
  String _family;
  String _genus;
  String _specificEpithet;
  String _taxonRank;
  String _scientificNameAuthorship;
  String _vernacularName;

  List<double> _pickedLocation;
  List<String> _pickedTaxon;

  @override
  void initState() {
    super.initState();
    if (widget.occurrence != null) {
      _basisOfRecord = widget.occurrence.basisOfRecord;
      _occurrenceID = widget.occurrence.occurrenceID;
      _individualCount = widget.occurrence.individualCount;
      _occurrenceStatus = widget.occurrence.occurrenceStatus;
      _occurrenceRemarks = widget.occurrence.occurrenceRemarks;
      _eventID = widget.occurrence.eventID;
      _eventDate = widget.occurrence.eventDate;
      _locationID = widget.occurrence.locationID;
      _country = widget.occurrence.country;
      _countryCode = widget.occurrence.countryCode;
      _locality = widget.occurrence.locality;
      _decimalLatitude = widget.occurrence.decimalLatitude;
      _decimalLongitude = widget.occurrence.decimalLongitude;
      _geodeticDatum = widget.occurrence.geodeticDatum;
      _taxonID = widget.occurrence.taxonID;
      _scientificName = widget.occurrence.scientificName;
      _kingdom = widget.occurrence.kingdom;
      _phylum = widget.occurrence.phylum;
      _class_ = widget.occurrence.class_;
      _order = widget.occurrence.order;
      _family = widget.occurrence.family;
      _genus = widget.occurrence.genus;
      _specificEpithet = widget.occurrence.specificEpithet;
      _taxonRank = widget.occurrence.taxonRank;
      _scientificNameAuthorship = widget.occurrence.scientificNameAuthorship;
      _vernacularName = widget.occurrence.vernacularName;
    }

    // Initialization of text editing controllers
    _scientificNameController = TextEditingController(text: _scientificName);
    _vernacularNameController = TextEditingController(text: _vernacularName);
    _individualCountController = TextEditingController(
      text: _individualCount != null ? '$_individualCount' : null,
    );
    _localityController = TextEditingController(text: _locality);
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude != null ? '$_decimalLongitude' : null,
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude != null ? '$_decimalLatitude' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    _taxaData = Provider.of<Taxa>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.occurrence == null
            ? 'Creación de observación'
            : 'Edición de observación'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Guardar observación',
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
      DateTimeField(
        decoration: InputDecoration(labelText: 'Fecha y hora'),
        format: DateFormat("yyyy-MM-dd HH:mm"),
        initialValue: _eventDate,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return "La fecha y la hora no pueden estar vacías";
          }
          return null;
        },
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2018),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        onSaved: (value) => _eventDate = value,
      ),
      LocalityPicker(_selectPlace),
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
      OpportunisticObservationTaxonPickerWidget(_pickTaxon),
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextFormField(
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
          ),
          SizedBox(width: 10.0),
          Expanded(
            flex: 1,
            child: TextFormField(
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
          ),
        ],
      ),
      TextFormField(
        readOnly: true,
        controller: _vernacularNameController,
        decoration: InputDecoration(labelText: 'Nombre común'),
        onSaved: (value) => _vernacularName = value,
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        maxLength: 50,
        maxLines: null,
        decoration: InputDecoration(
          labelText: 'Comentarios',
          hintText: 'Descripción del clima, hábitat,...',
        ),
        initialValue: _occurrenceRemarks != null ? '$_occurrenceRemarks' : null,
        onSaved: (value) => _occurrenceRemarks = value,
      ),
    ];
  }

  void _selectPlace(
    double decimalLatitude,
    double decimalLongitude,
  ) {
    _pickedLocation = [decimalLatitude, decimalLongitude];
    setState(() {
      _decimalLongitude = decimalLongitude;
      _decimalLatitude = decimalLatitude;
    });
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude.toStringAsFixed(6),
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude.toStringAsFixed(6),
    );
  }

  void _pickTaxon(String taxonId, int individualCount) {
    Taxon taxon = _taxaData.findById(taxonId);

    _pickedTaxon = [taxon.scientificName, individualCount.toString()];
    setState(() {
      _individualCount = individualCount;
      _taxonID = taxon.id;
      _scientificName = taxon.scientificName;
      _kingdom = taxon.kingdom;
      _phylum = taxon.phylum;
      _class_ = taxon.class_;
      _order = taxon.order;
      _family = taxon.family;
      _genus = taxon.genus;
      _specificEpithet = taxon.specificEpithet;
      _taxonRank = taxon.taxonRank;
      _scientificNameAuthorship = taxon.scientificNameAuthorship;
      _vernacularName = taxon.vernacularName;
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
        final id = widget.occurrence?.id ?? documentIdFromCurrentDate();
        final occurrence = Occurrence(
          id: id,
          basisOfRecord: _basisOfRecord,
          occurrenceID: id,
          individualCount: _individualCount,
          occurrenceStatus: _occurrenceStatus,
          occurrenceRemarks: _occurrenceRemarks,
          eventID: _eventID,
          eventDate: _eventDate,
          locationID: _locationID,
          country: _country,
          countryCode: _countryCode,
          locality: _locality,
          decimalLatitude: _decimalLatitude,
          decimalLongitude: _decimalLongitude,
          geodeticDatum: _geodeticDatum,
          taxonID: _taxonID,
          scientificName: _scientificName,
          kingdom: _kingdom,
          phylum: _phylum,
          class_: _class_,
          order: _order,
          family: _family,
          genus: _genus,
          specificEpithet: _specificEpithet,
          taxonRank: _taxonRank,
          scientificNameAuthorship: _scientificNameAuthorship,
          vernacularName: _vernacularName,
        );
        await widget.database.setOccurrence(occurrence);
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Error al ingresar observación',
          exception: e,
        ).show(context);
      }
    }
  }
}
