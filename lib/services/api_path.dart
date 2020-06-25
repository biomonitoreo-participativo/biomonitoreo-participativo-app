class APIPath {
  static String event(String uid, String eventId) =>
      'users/$uid/events/$eventId';
  static String events(String uid) => 'users/$uid/events';
  static String occurrence(String uid, String occurrenceId) =>
      'users/$uid/occurrences/$occurrenceId';
  static String occurrences(String uid) => 'users/$uid/occurrences';

  /* static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';

  static String event(String uid, String eventId) =>
      'users/$uid/events/$eventId';
  static String events(String uid) => 'users/$uid/events';
  static String occurrence(String uid, String occurrenceId) =>
      'users/$uid/occurrences/$occurrenceId';
  static String occurrences(String uid) => 'users/$uid/occurrences';*/
}
