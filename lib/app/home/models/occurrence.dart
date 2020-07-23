import 'package:flutter/foundation.dart';

class Occurrence {
  String eventID;
  String id;
  String basisOfRecord;
  String kingdom;
  String scientificName;
  String vernacularName;
  String taxonRank;
  int individualCount;
  String countryCode;
  String locality;
  double decimalLongitude;
  double decimalLatitude;
  String geodeticDatum;
  DateTime eventDate;
  String occurrenceRemarks;
  DateTime start;
  DateTime end;

  Occurrence({
    @required this.eventID,
    @required this.id,
    this.basisOfRecord = 'Human Observation',
    this.kingdom = 'Animalia',
    @required this.scientificName,
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
      basisOfRecord: value['basisOfRecord'],
      kingdom: value['kingdom'],
      scientificName: value['scientificName'],
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
      'eventId': eventID,
      'basisOfRecord': basisOfRecord,
      'kingdom': kingdom,
      'scientificName': scientificName,
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
