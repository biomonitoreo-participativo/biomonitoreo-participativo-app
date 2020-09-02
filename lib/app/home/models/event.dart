import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String eventID;
  final String parentEventID;
  final DateTime eventDate;
  final DateTime startEventDate; // Not in DwC, used to calculate duration
  final DateTime endEventDate; // Not in DwC, used to calculate duration
  final String samplingProtocol;
  final double sampleSizeValue;
  final String sampleSizeUnit;
  final String samplingEffort;
  final String eventRemarks;
  final String locationID;
  final String country;
  final String countryCode;
  final String locality;
  final double decimalLatitude;
  final double decimalLongitude;
  final String geodeticDatum;

  Event({
    @required this.id,
    @required this.eventID,
    this.parentEventID,
    @required this.eventDate,
    this.startEventDate,
    this.endEventDate,
    @required this.samplingProtocol,
    this.sampleSizeValue,
    this.sampleSizeUnit,
    this.samplingEffort,
    this.eventRemarks,
    this.locationID,
    this.country,
    this.countryCode,
    this.locality,
    this.decimalLatitude,
    this.decimalLongitude,
    this.geodeticDatum,
  });

  double get durationInHours =>
      endEventDate.difference(startEventDate).inMinutes.toDouble() / 60.0;

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String eventID = data['eventID'];
    final String parentEventID = data['parentEventID'];
    final int eventDateMilliseconds = data['eventDate'];
    final int startEventDateMilliseconds = data['startEventDate'];
    final int endEventDateMilliseconds = data['endEventDate'];
    final String samplingProtocol = data['samplingProtocol'];
    final double sampleSizeValue = data['sampleSizeValue'];
    final String sampleSizeUnit = data['sampleSizeUnit'];
    final String samplingEffort = data['samplingEffort'];
    final String eventRemarks = data['eventRemarks'];
    final String locationID = data['locationID'];
    final String country = data['country'];
    final String countryCode = data['countryCode'];
    final String locality = data['locality'];
    final double decimalLatitude = data['decimalLatitude'];
    final double decimalLongitude = data['decimalLongitude'];
    final String geodeticDatum = data['geodetidDatum'];
    return Event(
      id: documentId,
      eventID: documentId,
      parentEventID: parentEventID,
      eventDate: DateTime.fromMillisecondsSinceEpoch(eventDateMilliseconds),
      startEventDate:
          DateTime.fromMillisecondsSinceEpoch(startEventDateMilliseconds),
      endEventDate:
          DateTime.fromMillisecondsSinceEpoch(endEventDateMilliseconds),
      samplingProtocol: samplingProtocol,
      sampleSizeValue: sampleSizeValue,
      sampleSizeUnit: sampleSizeUnit,
      samplingEffort: samplingEffort,
      eventRemarks: eventRemarks,
      locationID: locationID,
      country: country,
      countryCode: countryCode,
      locality: locality,
      decimalLatitude: decimalLatitude,
      decimalLongitude: decimalLongitude,
      geodeticDatum: geodeticDatum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventID': eventID,
      'parentEventID': parentEventID,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'startEventDate': startEventDate.millisecondsSinceEpoch,
      'endEventDate': endEventDate.millisecondsSinceEpoch,
      'samplingProtocol': samplingProtocol,
      'sampleSizeValue': sampleSizeValue,
      'sampleSizeUnit': sampleSizeUnit,
      'samplingEffort': samplingEffort,
      'eventRemarks': eventRemarks,
      'locationID': locationID,
      'country': country,
      'countryCode': countryCode,
      'locality': locality,
      'decimalLongitude': decimalLongitude,
      'decimalLatitude': decimalLatitude,
      'geodeticDatum': geodeticDatum,
    };
  }
}
