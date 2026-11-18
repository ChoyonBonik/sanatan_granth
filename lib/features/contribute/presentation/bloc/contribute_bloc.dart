import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/contribute_repository.dart';
import '../../domain/usecases/submit_contribution_usecase.dart';
import 'contribute_event.dart';
import 'contribute_state.dart';

class ContributeBloc extends Bloc<ContributeEvent, ContributeState> {
  final SubmitContributionUseCase submitUseCase;
  final ContributeRepository repository;

  ContributeBloc({
    required this.submitUseCase,
    required this.repository,
  }) : super(const ContributeState()) {
    on<LoadMyContributionsEvent>(_onLoadContributions);
    on<SubmitDocumentContributionEvent>(_onSubmitDocument);
    on<SubmitCsvContributionEvent>(_onSubmitCsv);
  }

  Future<void> _onLoadContributions(
    LoadMyContributionsEvent event,
    Emitter<ContributeState> emit,
  ) async {
    emit(state.copyWith(status: ContributeStatus.loading));
    final result = await repository.getMyContributions();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ContributeStatus.error,
        errorMessage: failure.message,
      )),
      (list) => emit(state.copyWith(
        status: ContributeStatus.success,
        contributions: list,
      )),
    );
  }

  Future<void> _onSubmitDocument(
    SubmitDocumentContributionEvent event,
    Emitter<ContributeState> emit,
  ) async {
    emit(state.copyWith(status: ContributeStatus.loading));
    final result = await submitUseCase.submitDocument(
      title: event.title,
      author: event.author,
      category: event.category,
      filePath: event.filePath,
      type: event.type,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ContributeStatus.error,
        errorMessage: failure.message,
      )),
      (contrib) {
        final updatedList = [contrib, ...state.contributions];
        emit(state.copyWith(
          status: ContributeStatus.success,
          contributions: updatedList,
          message: 'Document submitted for editorial review successfully.',
        ));
      },
    );
  }

  Future<void> _onSubmitCsv(
    SubmitCsvContributionEvent event,
    Emitter<ContributeState> emit,
  ) async {
    emit(state.copyWith(status: ContributeStatus.loading));
    final result = await submitUseCase.submitCsv(
      scriptureTitle: event.scriptureTitle,
      csvContent: event.csvContent,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ContributeStatus.error,
        errorMessage: failure.message,
      )),
      (contrib) {
        final updatedList = [contrib, ...state.contributions];
        emit(state.copyWith(
          status: ContributeStatus.success,
          contributions: updatedList,
          message: 'Structured CSV verses submitted for review successfully.',
        ));
      },
    );
  }
}
