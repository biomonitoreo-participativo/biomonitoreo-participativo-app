import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String locality;
  final double decimalLongitude;
  final double decimalLatitude;
  final DateTime eventDate;
  final String eventRemarks;
  final String conservationArea;

  Event({
    @required this.id,
    @required this.locality,
    @required this.decimalLongitude,
    @required this.decimalLatitude,
    @required this.eventDate,
    this.eventRemarks = '',
    this.conservationArea = 'ACLAP',
  });

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String locality = data['locality'];
    final double decimalLongitude = data['decimalLongitude'];
    final double decimalLatitude = data['decimalLatitude'];
    final int eventDateMilliseconds = data['eventDate'];
    final String eventRemarks = data['eventRemarks'];
    final String conservationArea = data['conservationArea'];
    return Event(
      id: documentId,
      locality: locality,
      decimalLongitude: decimalLongitude,
      decimalLatitude: decimalLatitude,
      eventDate: DateTime.fromMillisecondsSinceEpoch(eventDateMilliseconds),
      eventRemarks: eventRemarks,
      conservationArea: conservationArea,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locality': locality,
      'decimalLongitude': decimalLongitude,
      'decimalLatitude': decimalLatitude,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'eventRemarks': eventRemarks,
      'conservationArea': conservationArea,
    };
  }
}
