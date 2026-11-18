import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// -----------------------------------------------------------------------------
// 1. Tables Definition
// -----------------------------------------------------------------------------

class CachedBooks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get category => text()();
  TextColumn get language => text()();
  TextColumn get description => text()();
  TextColumn get coverUrl => text().nullable()();
  TextColumn get fileUrl => text().nullable()();
  TextColumn get localFilePath => text().nullable()();
  TextColumn get format => text().withDefault(const Constant('structured'))();
  IntColumn get totalVerses => integer().withDefault(const Constant(0))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => <Column>{id};
}

class CachedVerses extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text()();
  IntColumn get chapterNumber => integer()();
  IntColumn get verseNumber => integer()();
  TextColumn get originalScriptText => text()();
  TextColumn get scriptType => text().withDefault(const Constant('devanagari'))();
  TextColumn get transliteration => text().nullable()();
  TextColumn get wordMeanings => text().nullable()();
  TextColumn get translation => text()();
  TextColumn get commentary => text().nullable()();
  IntColumn get audioTimestampStartMs => integer().nullable()();
  IntColumn get audioTimestampEndMs => integer().nullable()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}

class DownloadTasks extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text()();
  TextColumn get title => text()();
  TextColumn get fileUrl => text()();
  TextColumn get localPath => text()();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get totalBytes => integer().withDefault(const Constant(0))();
  IntColumn get downloadedBytes => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => <Column>{id};
}

class Bookmarks extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => <Column>{id};
}

// -----------------------------------------------------------------------------
// 2. Database Class
// -----------------------------------------------------------------------------

@DriftDatabase(tables: <Type>[CachedBooks, CachedVerses, DownloadTasks, Bookmarks])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Custom queries and helper accessors
  Future<List<CachedBook>> getAllCachedBooks() => select(cachedBooks).get();

  Stream<List<CachedBook>> watchAllCachedBooks() => select(cachedBooks).watch();

  Future<CachedBook?> getCachedBookById(String id) {
    return (select(cachedBooks)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertOrUpdateBook(CachedBooksCompanion book) {
    return into(cachedBooks).insertOnConflictUpdate(book);
  }

  Future<int> deleteCachedBook(String id) {
    return (delete(cachedBooks)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CachedVerse>> getVersesForChapter(String bookId, int chapter) {
    return (select(cachedVerses)
          ..where((tbl) => tbl.bookId.equals(bookId) & tbl.chapterNumber.equals(chapter))
          ..orderBy(<OrderingTerm Function(CachedVerses)>[
            (tbl) => OrderingTerm.asc(tbl.verseNumber)
          ]))
        .get();
  }

  Future<void> batchInsertVerses(List<CachedVersesCompanion> verses) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(cachedVerses, verses);
    });
  }

  Stream<List<DownloadTask>> watchActiveDownloads() {
    return (select(downloadTasks)
          ..where((tbl) => tbl.status.isNotIn(const <String>['completed', 'failed'])))
        .watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'sanatan_granth.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
