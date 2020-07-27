import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/taxon.dart';

import 'package:biomonitoreoparticipativoapp/services/database.dart';

import 'package:biomonitoreoparticipativoapp/common_widgets/locality_picker.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/taxon_picker.dart';

import 'package:biomonitoreoparticipativoapp/app/home/opportunistic_observations/taxon_data.dart';

var _scientificNameController;
var _individualCountController;
var _localityController;
var _decimalLongitudeController;
var _decimalLatitudeController;

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

  String _eventID = '0';
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
  String _locality;
  double _decimalLongitude;
  double _decimalLatitude;
  String _geodeticDatum = 'EPSG:4326';
  DateTime _eventDate = DateTime.now();
  String _occurrenceRemarks;
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  List<double> _pickedLocation;
  List<String> _pickedTaxon;

  @override
  void initState() {
    super.initState();
    if (widget.occurrence != null) {
      _eventID = widget.occurrence.eventID;
      _basisOfRecord = widget.occurrence.basisOfRecord;
      _kingdom = widget.occurrence.kingdom;
      _phylum = widget.occurrence.phylum;
      _class_ = widget.occurrence.class_;
      _order = widget.occurrence.order;
      _family = widget.occurrence.family;
      _genus = widget.occurrence.genus;
      _specificEpithet = widget.occurrence.specificEpithet;
      _scientificName = widget.occurrence.scientificName;
      _scientificNameAuthorship = widget.occurrence.scientificNameAuthorship;
      _vernacularName = widget.occurrence.vernacularName;
      _taxonRank = widget.occurrence.taxonRank;
      _individualCount = widget.occurrence.individualCount;
      _countryCode = widget.occurrence.countryCode;
      _locality = widget.occurrence.locality;
      _decimalLongitude = widget.occurrence.decimalLongitude;
      _decimalLatitude = widget.occurrence.decimalLatitude;
      _geodeticDatum = widget.occurrence.geodeticDatum;
      _eventDate = widget.occurrence.eventDate;
      _occurrenceRemarks = widget.occurrence.occurrenceRemarks;
      _start = widget.occurrence.start;
      _end = widget.occurrence.end;
    }

    _scientificNameController = TextEditingController(text: _scientificName);
    _localityController = TextEditingController(text: _locality);
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
        final id = widget.occurrence?.id ?? documentIdFromCurrentDate();
        final occurrence = Occurrence(
          id: id,
          eventID: _eventID,
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
          start: _start,
          end: _end,
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

  @override
  Widget build(BuildContext context) {
    _taxaData = Provider.of<Taxa>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.occurrence == null
            ? 'Creación de observación'
            : 'Edición de observación'),
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

  void _selectPlace(double lat, double lng) {
    _pickedLocation = [lat, lng];
    setState(() {
      _decimalLongitude = lng;
      _decimalLatitude = lat;
    });
    _decimalLongitudeController = TextEditingController(
      text: _decimalLongitude.toStringAsFixed(2),
    );
    _decimalLatitudeController = TextEditingController(
      text: _decimalLatitude.toStringAsFixed(2),
    );
  }

  void _selectTaxon(String taxonId, int individualCount) {
    Taxon taxon = _taxaData.findById(taxonId);

    _pickedTaxon = [taxon.scientificName, individualCount.toString()];
    setState(() {
      _kingdom = taxon.kingdom;
      _phylum = taxon.phylum;
      _class_ = taxon.class_;
      _order = taxon.order;
      _family = taxon.family;
      _genus = taxon.genus;
      _specificEpithet = taxon.specificEpithet;
      _scientificName = taxon.scientificName;
      _scientificNameAuthorship = taxon.scientificNameAuthorship;
      _taxonRank = taxon.taxonRank;
      _individualCount = individualCount;
    });
    _scientificNameController = TextEditingController(
      text: _scientificName,
    );
    _individualCountController = TextEditingController(
      text: _individualCount.toString(),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        controller: _scientificNameController,
        decoration: InputDecoration(labelText: 'Nombre científico'),
        validator: (value) => value.isNotEmpty
            ? null
            : 'El nombre científico no puede estar vacío',
        onSaved: (value) => _scientificName = value,
      ),
      TextFormField(
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        controller: TextEditingController(text: '$_individualCount'),
        decoration: InputDecoration(
          labelText: 'Cantidad',
        ),
        onChanged: (value) => _individualCount = int.tryParse(value) ?? 0,
      ),
      TaxonPicker(_selectTaxon),
      TextFormField(
        controller: _localityController,
        decoration: InputDecoration(labelText: 'Localidad'),
        validator: (value) =>
            value.isNotEmpty ? null : 'La localidad no puede estar vacía',
        onSaved: (value) => _locality = value,
      ),
      TextFormField(
        readOnly: true,
        controller: _decimalLongitudeController,
        decoration: InputDecoration(labelText: 'Longitud'),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _decimalLongitude = double.tryParse(value) ?? 0.0,
      ),
      TextFormField(
        readOnly: true,
        controller: _decimalLatitudeController,
        decoration: InputDecoration(labelText: 'Latitud'),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _decimalLatitude = double.tryParse(value) ?? 0.0,
      ),
      LocalityPicker(_selectPlace),
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
      TextFormField(
        keyboardType: TextInputType.text,
        maxLength: 50,
        maxLines: null,
        decoration: InputDecoration(labelText: 'Comentarios'),
        initialValue: _occurrenceRemarks != null ? '$_occurrenceRemarks' : null,
        onSaved: (value) => _occurrenceRemarks = value,
      ),
    ];
  }
}
