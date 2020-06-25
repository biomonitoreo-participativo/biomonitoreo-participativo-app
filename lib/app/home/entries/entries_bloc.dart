import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:biomonitoreoparticipativoapp/app/home/entries/daily_jobs_details.dart';
import 'package:biomonitoreoparticipativoapp/app/home/entries/entries_list_tile.dart';
import 'package:biomonitoreoparticipativoapp/app/home/entries/entry_job.dart';
import 'package:biomonitoreoparticipativoapp/app/home/event_occurrences/format.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/occurrence.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/event.dart';
import 'package:biomonitoreoparticipativoapp/services/database.dart';

class EntriesBloc {
  EntriesBloc({@required this.database});
  final Database database;

  /// combine List<Job>, List<Entry> into List<EntryJob>
  Stream<List<EntryJob>> get _allEntriesStream => Observable.combineLatest2(
        database.occurrencesStream(),
        database.eventsStream(),
        _entriesJobsCombiner,
      );

  static List<EntryJob> _entriesJobsCombiner(
      List<Occurrence> entries, List<Event> jobs) {
    return entries.map((entry) {
      final job = jobs.firstWhere((job) => job.id == entry.eventId);
      return EntryJob(entry, job);
    }).toList();
  }

  /// Output stream
  Stream<List<EntriesListTileModel>> get entriesTileModelStream =>
      _allEntriesStream.map(_createModels);

  static List<EntriesListTileModel> _createModels(List<EntryJob> allEntries) {
    if (allEntries.isEmpty) {
      return [];
    }

    final allDailyJobsDetails = DailyJobsDetails.all(allEntries);

    // total duration across all jobs
    final totalDuration = allDailyJobsDetails
        .map((dateJobsDuration) => dateJobsDuration.duration)
        .reduce((value, element) => value + element);

    // total pay across all jobs
    final totalPay = allDailyJobsDetails
        .map((dateJobsDuration) => dateJobsDuration.pay)
        .reduce((value, element) => value + element);

    return <EntriesListTileModel>[
      EntriesListTileModel(
        leadingText: 'Todos los eventos',
        middleText: Format.currency(totalPay),
        //trailingText: Format.hours(totalDuration),
        trailingText: '',
      ),
      for (DailyJobsDetails dailyJobsDetails in allDailyJobsDetails) ...[
        EntriesListTileModel(
          isHeader: true,
          leadingText: Format.date(dailyJobsDetails.date),
          middleText: Format.currency(dailyJobsDetails.pay),
          //trailingText: Format.hours(dailyJobsDetails.duration),
          trailingText: '',
        ),
        for (JobDetails jobDuration in dailyJobsDetails.jobsDetails)
          EntriesListTileModel(
            leadingText: jobDuration.name,
            middleText: Format.currency(jobDuration.pay),
            //trailingText: Format.hours(jobDuration.durationInHours),
            trailingText: '',
          ),
      ]
    ];
  }
}
