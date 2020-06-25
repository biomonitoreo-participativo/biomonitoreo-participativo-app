import 'dart:async';

import 'package:meta/meta.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/services/api_path.dart';
import 'package:biomonitoreoparticipativoapp/services/firestore_service.dart';

abstract class Database {
  Future<void> setEvent(Event event);
  Future<void> deleteEvent(Event event);
  Stream<Event> eventStream({@required String eventId});
  Stream<List<Event>> eventsStream();

  Future<void> setOccurrence(Occurrence occurrence);
  Future<void> deleteOccurrence(Occurrence occurrence);
  Stream<List<Occurrence>> occurrencesStream({Event event});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setEvent(Event event) async => await _service.setData(
        path: APIPath.event(uid, event.id),
        data: event.toMap(),
      );

  @override
  Future<void> deleteEvent(Event event) async {
    // delete where occurrence.eventId == event.eventId
    final allOccurrences = await occurrencesStream(event: event).first;
    for (Occurrence occurrence in allOccurrences) {
      if (occurrence.eventId == event.id) {
        await deleteOccurrence(occurrence);
      }
    }
    // delete event
    await _service.deleteData(path: APIPath.event(uid, event.id));
  }

  @override
  Stream<Event> eventStream({@required String eventId}) =>
      _service.documentStream(
        path: APIPath.event(uid, eventId),
        builder: (data, documentId) => Event.fromMap(data, documentId),
      );

  @override
  Stream<List<Event>> eventsStream() => _service.collectionStream(
        path: APIPath.events(uid),
        builder: (data, documentId) => Event.fromMap(data, documentId),
      );

  @override
  Future<void> setOccurrence(Occurrence occurrence) async =>
      await _service.setData(
        path: APIPath.occurrence(uid, occurrence.id),
        data: occurrence.toMap(),
      );

  @override
  Future<void> deleteOccurrence(Occurrence occurrence) async =>
      await _service.deleteData(path: APIPath.occurrence(uid, occurrence.id));

  @override
  Stream<List<Occurrence>> occurrencesStream({Event event}) =>
      _service.collectionStream<Occurrence>(
        path: APIPath.occurrences(uid),
        queryBuilder: event != null
            ? (query) => query.where('eventId', isEqualTo: event.id)
            : null,
        builder: (data, documentID) => Occurrence.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
