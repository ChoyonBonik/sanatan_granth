import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/download_task_entity.dart';
import '../../domain/repositories/offline_repository.dart';
import 'offline_event.dart';
import 'offline_state.dart';

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  final OfflineRepository repository;
  StreamSubscription<List<DownloadTaskEntity>>? _downloadSubscription;

  OfflineBloc({required this.repository}) : super(const OfflineState()) {
    on<LoadOfflineDataEvent>(_onLoadOfflineData);
    on<EnqueueDownloadEvent>(_onEnqueueDownload);
    on<CancelDownloadEvent>(_onCancelDownload);
    on<DeleteCachedBookEvent>(_onDeleteCachedBook);

    _downloadSubscription = repository.watchDownloads().listen((downloads) {
      add(LoadOfflineDataEvent());
    });
  }

  Future<void> _onLoadOfflineData(
    LoadOfflineDataEvent event,
    Emitter<OfflineState> emit,
  ) async {
    emit(state.copyWith(status: OfflineStatus.loading));
    final booksResult = await repository.getCachedBooks();
    booksResult.fold(
      (failure) => emit(state.copyWith(
        status: OfflineStatus.error,
        errorMessage: failure.message,
      )),
      (books) => emit(state.copyWith(
        status: OfflineStatus.loaded,
        cachedBooks: books,
      )),
    );
  }

  Future<void> _onEnqueueDownload(
    EnqueueDownloadEvent event,
    Emitter<OfflineState> emit,
  ) async {
    await repository.enqueueDownload(event.bookId, event.title, event.fileUrl);
    add(LoadOfflineDataEvent());
  }

  Future<void> _onCancelDownload(
    CancelDownloadEvent event,
    Emitter<OfflineState> emit,
  ) async {
    await repository.cancelDownload(event.taskId);
    add(LoadOfflineDataEvent());
  }

  Future<void> _onDeleteCachedBook(
    DeleteCachedBookEvent event,
    Emitter<OfflineState> emit,
  ) async {
    await repository.removeCachedBook(event.bookId);
    add(LoadOfflineDataEvent());
  }

  @override
  Future<void> close() {
    _downloadSubscription?.cancel();
    return super.close();
  }
}
