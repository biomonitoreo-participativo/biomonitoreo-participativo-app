import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Occurrence {
  final String eventID;
  final String taxonID;
  final String id;
  final String basisOfRecord;
  final String kingdom;
  final String phylum;
  final String class_;
  final String order;
  final String family;
  final String genus;
  final String specificEpithet;
  final String scientificName;
  final String scientificNameAuthorship;
  final String vernacularName;
  final String taxonRank;
  final int individualCount;
  final String countryCode;
  final String locality;
  final double decimalLongitude;
  final double decimalLatitude;
  final String geodeticDatum;
  final DateTime eventDate;
  final String occurrenceRemarks;
  final DateTime start;
  final DateTime end;

  Occurrence({
    @required this.eventID,
    @required this.taxonID,
    @required this.id,
    this.basisOfRecord = 'Human Observation',
    this.kingdom = 'Animalia',
    this.phylum = '',
    this.class_ = '',
    this.order = '',
    this.family = '',
    this.genus = '',
    this.specificEpithet = '',
    @required this.scientificName,
    this.scientificNameAuthorship = '',
    this.vernacularName = '',
    this.taxonRank = 'species',
    @required this.individualCount,
    this.countryCode = 'CR',
    @required this.locality,
    @required this.decimalLongitude,
    @required this.decimalLatitude,
    this.geodeticDatum = 'EPSG:4326',
    @required this.eventDate,
    this.occurrenceRemarks = '',
    @required this.start,
    @required this.end,
  });

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Occurrence.fromMap(Map<dynamic, dynamic> value, String id) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    final int eventDateMilliseconds = value['eventDate'];
    return Occurrence(
      id: id,
      eventID: value['eventID'],
      taxonID: value['taxonID'],
      basisOfRecord: value['basisOfRecord'],
      kingdom: value['kingdom'],
      phylum: value['phylum'],
      class_: value['class_'],
      order: value['order'],
      family: value['family'],
      genus: value['genus'],
      specificEpithet: value['specificEpithet'],
      scientificName: value['scientificName'],
      scientificNameAuthorship: value['scientificNameAuthorship'],
      vernacularName: value['vernacularName'],
      taxonRank: value['taxonRank'],
      individualCount: value['individualCount'],
      countryCode: value['countryCode'],
      locality: value['locality'],
      decimalLongitude: value['decimalLongitude'],
      decimalLatitude: value['decimalLatitude'],
      geodeticDatum: value['geodeticDatum'],
      eventDate: DateTime.fromMillisecondsSinceEpoch(eventDateMilliseconds),
      occurrenceRemarks: value['occurrenceRemarks'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventID': eventID,
      'taxonID': taxonID,
      'basisOfRecord': basisOfRecord,
      'kingdom': kingdom,
      'phylum': phylum,
      'class_': class_,
      'order': order,
      'family': family,
      'genus': genus,
      'specificEpithet': specificEpithet,
      'scientificName': scientificName,
      'scientificNameAuthorship': scientificNameAuthorship,
      'vernacularName': vernacularName,
      'taxonRank': taxonRank,
      'individualCount': individualCount,
      'countryCode': countryCode,
      'locality': locality,
      'decimalLongitude': decimalLongitude,
      'decimalLatitude': decimalLatitude,
      'geodeticDatum': geodeticDatum,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'occurrenceRemarks': occurrenceRemarks,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
    };
  }
}
