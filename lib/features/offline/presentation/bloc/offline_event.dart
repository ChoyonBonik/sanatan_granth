import 'package:equatable/equatable.dart';

abstract class OfflineEvent extends Equatable {
  const OfflineEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadOfflineDataEvent extends OfflineEvent {}

class EnqueueDownloadEvent extends OfflineEvent {
  final String bookId;
  final String title;
  final String fileUrl;

  const EnqueueDownloadEvent({
    required this.bookId,
    required this.title,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => <Object?>[bookId, title, fileUrl];
}

class CancelDownloadEvent extends OfflineEvent {
  final String taskId;

  const CancelDownloadEvent(this.taskId);

  @override
  List<Object?> get props => <Object?>[taskId];
}

class DeleteCachedBookEvent extends OfflineEvent {
  final String bookId;

  const DeleteCachedBookEvent(this.bookId);

  @override
  List<Object?> get props => <Object?>[bookId];
}
