import 'package:equatable/equatable.dart';
import '../../domain/entities/contribution_entity.dart';

enum ContributeStatus { initial, loading, success, error }

class ContributeState extends Equatable {
  final ContributeStatus status;
  final List<ContributionEntity> contributions;
  final String? message;
  final String? errorMessage;

  const ContributeState({
    this.status = ContributeStatus.initial,
    this.contributions = const <ContributionEntity>[],
    this.message,
    this.errorMessage,
  });

  ContributeState copyWith({
    ContributeStatus? status,
    List<ContributionEntity>? contributions,
    String? message,
    String? errorMessage,
  }) {
    return ContributeState(
      status: status ?? this.status,
      contributions: contributions ?? this.contributions,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        contributions,
        message,
        errorMessage,
      ];
}
