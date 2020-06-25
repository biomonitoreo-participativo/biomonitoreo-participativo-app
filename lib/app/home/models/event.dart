import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String locality;
  final double decimalLongitude;
  final double decimalLatitude;
  final DateTime eventDateTime;
  final String eventRemarks;
  final String conservationArea;
  final int ratePerHour;

  Event({
    @required this.id,
    @required this.locality,
    @required this.decimalLongitude,
    @required this.decimalLatitude,
    @required this.eventDateTime,
    this.eventRemarks = '',
    this.conservationArea = 'ACLAP',
    this.ratePerHour = 1,
  });

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String locality = data['locality'];
    final double decimalLongitude = data['decimalLongitude'];
    final double decimalLatitude = data['decimalLatitude'];
    final int eventDateTimeMilliseconds = data['eventDateTime'];
    final String eventRemarks = data['eventRemarks'];
    final String conservationArea = data['conservationArea'];
    final int ratePerHour = data['ratePerHour'];
    return Event(
      id: documentId,
      locality: locality,
      decimalLongitude: decimalLongitude,
      decimalLatitude: decimalLatitude,
      eventDateTime:
          DateTime.fromMillisecondsSinceEpoch(eventDateTimeMilliseconds),
      eventRemarks: eventRemarks,
      conservationArea: conservationArea,
      ratePerHour: ratePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locality': locality,
      'decimalLongitude': decimalLongitude,
      'decimalLatitude': decimalLatitude,
      'eventDateTime': eventDateTime.millisecondsSinceEpoch,
      'eventRemarks': eventRemarks,
      'conservationArea': conservationArea,
      'ratePerHour': ratePerHour,
    };
  }
}
