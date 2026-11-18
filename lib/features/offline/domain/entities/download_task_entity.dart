import 'package:equatable/equatable.dart';

enum DownloadStatus { pending, downloading, completed, failed }

class DownloadTaskEntity extends Equatable {
  final String id;
  final String bookId;
  final String title;
  final String fileUrl;
  final String localPath;
  final double progress;
  final DownloadStatus status;
  final int totalBytes;
  final int downloadedBytes;
  final DateTime createdAt;

  const DownloadTaskEntity({
    required this.id,
    required this.bookId,
    required this.title,
    required this.fileUrl,
    required this.localPath,
    required this.progress,
    required this.status,
    required this.totalBytes,
    required this.downloadedBytes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        bookId,
        title,
        fileUrl,
        localPath,
        progress,
        status,
        totalBytes,
        downloadedBytes,
        createdAt,
      ];
}
