import 'package:flutter/foundation.dart';

class Occurrence {
  String id;
  String eventId;
  String scientificName;
  int quantity;
  String occurrenceRemarks;
  DateTime start;
  DateTime end;

  Occurrence({
    @required this.id,
    @required this.eventId,
    @required this.scientificName,
    @required this.quantity,
    this.occurrenceRemarks = '',
    @required this.start,
    @required this.end,
  });

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Occurrence.fromMap(Map<dynamic, dynamic> value, String id) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Occurrence(
      id: id,
      eventId: value['eventId'],
      scientificName: value['scientificName'],
      quantity: value['quantity'],
      occurrenceRemarks: value['occurrenceRemarks'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'scientificName': scientificName,
      'quantity': quantity,
      'occurrenceRemarks': occurrenceRemarks,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
    };
  }
}
