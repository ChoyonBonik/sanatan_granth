import '../../domain/entities/download_task_entity.dart';
import '../../../library/domain/entities/book_entity.dart';
import '../../../reader/domain/entities/verse_entity.dart';

abstract class OfflineLocalDataSource {
  Future<List<BookEntity>> getCachedBooks();
  Future<BookEntity?> getCachedBookById(String id);
  Future<void> cacheBook(BookEntity book);
  Future<void> removeCachedBook(String id);
  Future<List<VerseEntity>> getCachedVerses(String bookId, int chapter);
  Future<void> cacheVerses(List<VerseEntity> verses);
  Stream<List<DownloadTaskEntity>> watchDownloads();
  Future<void> enqueueDownload(String bookId, String title, String fileUrl);
  Future<void> cancelDownload(String taskId);
}

class OfflineLocalDataSourceImpl implements OfflineLocalDataSource {
  // In-memory simulation and database bridge
  final List<BookEntity> _cachedBooks = <BookEntity>[];
  final List<VerseEntity> _cachedVerses = <VerseEntity>[];
  final List<DownloadTaskEntity> _downloads = <DownloadTaskEntity>[
    DownloadTaskEntity(
      id: 'task-1',
      bookId: 'gita-as-it-is',
      title: 'Srimad Bhagavad Gita (Complete Offline Package)',
      fileUrl: 'https://example.com/gita.zip',
      localPath: '/storage/books/gita-as-it-is',
      progress: 1.0,
      status: DownloadStatus.completed,
      totalBytes: 15400000,
      downloadedBytes: 15400000,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Future<List<BookEntity>> getCachedBooks() async => _cachedBooks;

  @override
  Future<BookEntity?> getCachedBookById(String id) async {
    return _cachedBooks.cast<BookEntity?>().firstWhere(
          (BookEntity? b) => b?.id == id,
          orElse: () => null,
        );
  }

  @override
  Future<void> cacheBook(BookEntity book) async {
    _cachedBooks.removeWhere((BookEntity b) => b.id == book.id);
    _cachedBooks.add(book);
  }

  @override
  Future<void> removeCachedBook(String id) async {
    _cachedBooks.removeWhere((BookEntity b) => b.id == id);
  }

  @override
  Future<List<VerseEntity>> getCachedVerses(String bookId, int chapter) async {
    return _cachedVerses
        .where((VerseEntity v) => v.bookId == bookId && v.chapterNumber == chapter)
        .toList();
  }

  @override
  Future<void> cacheVerses(List<VerseEntity> verses) async {
    _cachedVerses.addAll(verses);
  }

  @override
  Stream<List<DownloadTaskEntity>> watchDownloads() async* {
    yield _downloads;
  }

  @override
  Future<void> enqueueDownload(String bookId, String title, String fileUrl) async {
    _downloads.add(
      DownloadTaskEntity(
        id: 'dl-${DateTime.now().millisecondsSinceEpoch}',
        bookId: bookId,
        title: title,
        fileUrl: fileUrl,
        localPath: '/storage/books/$bookId',
        progress: 0.25,
        status: DownloadStatus.downloading,
        totalBytes: 25000000,
        downloadedBytes: 6250000,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> cancelDownload(String taskId) async {
    _downloads.removeWhere((DownloadTaskEntity t) => t.id == taskId);
  }
}
