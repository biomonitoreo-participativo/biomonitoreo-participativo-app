import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String eventID;
  final String parentEventID;
  final String samplingProtocol;
  final String sampleSizeUnit;
  final String locality;
  final double decimalLongitude;
  final double decimalLatitude;
  final DateTime eventDate;
  final DateTime startEventDate;
  final DateTime endEventDate;
  final String eventRemarks;
  final String conservationArea;

  Event({
    @required this.id,
    @required this.eventID,
    @required this.parentEventID,
    @required this.samplingProtocol,
    this.sampleSizeUnit,
    @required this.locality,
    @required this.decimalLongitude,
    @required this.decimalLatitude,
    @required this.eventDate,
    @required this.startEventDate,
    @required this.endEventDate,
    this.eventRemarks,
    this.conservationArea,
  });

  double get durationInHours =>
      endEventDate.difference(startEventDate).inMinutes.toDouble() / 60.0;

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String eventID = data['eventID'];
    final String parentEventID = data['parentEventID'];
    final String samplingProtocol = data['samplingProtocol'];
    final String sampleSizeUnit = data['sampleSizeUnit'];
    final String locality = data['locality'];
    final double decimalLongitude = data['decimalLongitude'];
    final double decimalLatitude = data['decimalLatitude'];
    final int eventDateMilliseconds = data['eventDate'];
    final int startEventDateMilliseconds = data['startEventDate'];
    final int endEventDateMilliseconds = data['endEventDate'];
    final String eventRemarks = data['eventRemarks'];
    final String conservationArea = data['conservationArea'];
    return Event(
      id: documentId,
      eventID: documentId,
      parentEventID: parentEventID,
      samplingProtocol: samplingProtocol,
      sampleSizeUnit: sampleSizeUnit,
      locality: locality,
      decimalLongitude: decimalLongitude,
      decimalLatitude: decimalLatitude,
      eventDate: DateTime.fromMillisecondsSinceEpoch(eventDateMilliseconds),
      startEventDate:
          DateTime.fromMillisecondsSinceEpoch(startEventDateMilliseconds),
      endEventDate:
          DateTime.fromMillisecondsSinceEpoch(endEventDateMilliseconds),
      eventRemarks: eventRemarks,
      conservationArea: conservationArea,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventID': eventID,
      'parentEventID': parentEventID,
      'samplingProtocol': samplingProtocol,
      'sampleSizeUnit': sampleSizeUnit,
      'locality': locality,
      'decimalLongitude': decimalLongitude,
      'decimalLatitude': decimalLatitude,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'startEventDate': startEventDate.millisecondsSinceEpoch,
      'endEventDate': endEventDate.millisecondsSinceEpoch,
      'eventRemarks': eventRemarks,
      'conservationArea': conservationArea,
    };
  }
}
