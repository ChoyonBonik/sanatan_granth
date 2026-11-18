import 'package:equatable/equatable.dart';
import '../../domain/entities/download_task_entity.dart';
import '../../../library/domain/entities/book_entity.dart';

enum OfflineStatus { initial, loading, loaded, error }

class OfflineState extends Equatable {
  final OfflineStatus status;
  final List<BookEntity> cachedBooks;
  final List<DownloadTaskEntity> activeDownloads;
  final String? errorMessage;

  const OfflineState({
    this.status = OfflineStatus.initial,
    this.cachedBooks = const <BookEntity>[],
    this.activeDownloads = const <DownloadTaskEntity>[],
    this.errorMessage,
  });

  OfflineState copyWith({
    OfflineStatus? status,
    List<BookEntity>? cachedBooks,
    List<DownloadTaskEntity>? activeDownloads,
    String? errorMessage,
  }) {
    return OfflineState(
      status: status ?? this.status,
      cachedBooks: cachedBooks ?? this.cachedBooks,
      activeDownloads: activeDownloads ?? this.activeDownloads,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        cachedBooks,
        activeDownloads,
        errorMessage,
      ];
}
