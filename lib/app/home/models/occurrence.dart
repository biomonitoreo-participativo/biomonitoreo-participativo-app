import 'package:flutter/foundation.dart';

class Occurrence {
  final String id;
  final String basisOfRecord;
  final String occurrenceID;
  final int individualCount;
  final String occurrenceStatus;
  final String occurrenceRemarks;
  final String eventID;
  final DateTime eventDate;
  final String locationID;
  final String country;
  final String countryCode;
  final String locality;
  final double decimalLatitude;
  final double decimalLongitude;
  final String geodeticDatum;
  final String taxonID;
  final String scientificName;
  final String kingdom;
  final String phylum;
  final String class_;
  final String order;
  final String family;
  final String genus;
  final String specificEpithet;
  final String taxonRank;
  final String scientificNameAuthorship;
  final String vernacularName;

  Occurrence({
    @required this.id,
    @required this.basisOfRecord,
    @required this.occurrenceID,
    this.individualCount,
    this.occurrenceStatus,
    this.occurrenceRemarks,
    this.eventID,
    @required this.eventDate,
    this.locationID,
    this.country,
    this.countryCode,
    this.locality,
    this.decimalLatitude,
    this.decimalLongitude,
    this.geodeticDatum,
    this.taxonID,
    @required this.scientificName,
    this.kingdom,
    this.phylum,
    this.class_,
    this.order,
    this.family,
    this.genus,
    this.specificEpithet,
    this.taxonRank,
    this.scientificNameAuthorship,
    this.vernacularName,
  });

  factory Occurrence.fromMap(Map<dynamic, dynamic> value, String id) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    final int eventDateMilliseconds = value['eventDate'];
    return Occurrence(
      id: id,
      basisOfRecord: value['basisOfRecord'],
      occurrenceID: id,
      individualCount: value['individualCount'],
      occurrenceStatus: value['occurrenceStatus'],
      occurrenceRemarks: value['occurrenceRemarks'],
      eventID: value['eventID'],
      eventDate: DateTime.fromMillisecondsSinceEpoch(eventDateMilliseconds),
      locationID: value['locationID'],
      country: value['country'],
      countryCode: value['countryCode'],
      locality: value['locality'],
      decimalLatitude: value['decimalLatitude'],
      decimalLongitude: value['decimalLongitude'],
      geodeticDatum: value['geodeticDatum'],
      taxonID: value['taxonID'],
      scientificName: value['scientificName'],
      kingdom: value['kingdom'],
      phylum: value['phylum'],
      class_: value['class_'],
      order: value['order'],
      family: value['family'],
      genus: value['genus'],
      specificEpithet: value['specificEpithet'],
      taxonRank: value['taxonRank'],
      scientificNameAuthorship: value['scientificNameAuthorship'],
      vernacularName: value['vernacularName'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'basisOfRecord': basisOfRecord,
      'occurrenceID': occurrenceID,
      'individualCount': individualCount,
      'occurrenceStatus': occurrenceStatus,
      'occurrenceRemarks': occurrenceRemarks,
      'eventID': eventID,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'locationID': locationID,
      'country': country,
      'countryCode': countryCode,
      'locality': locality,
      'decimalLatitude': decimalLatitude,
      'decimalLongitude': decimalLongitude,
      'geodeticDatum': geodeticDatum,
      'taxonID': taxonID,
      'scientificName': scientificName,
      'kingdom': kingdom,
      'phylum': phylum,
      'class_': class_,
      'order': order,
      'family': family,
      'genus': genus,
      'specificEpithet': specificEpithet,
      'taxonRank': taxonRank,
      'scientificNameAuthorship': scientificNameAuthorship,
      'vernacularName': vernacularName,
    };
  }
}
