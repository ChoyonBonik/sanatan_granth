import 'package:equatable/equatable.dart';
import '../../domain/entities/contribution_entity.dart';

abstract class ContributeEvent extends Equatable {
  const ContributeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadMyContributionsEvent extends ContributeEvent {}

class SubmitDocumentContributionEvent extends ContributeEvent {
  final String title;
  final String author;
  final String category;
  final String filePath;
  final ContributionType type;

  const SubmitDocumentContributionEvent({
    required this.title,
    required this.author,
    required this.category,
    required this.filePath,
    required this.type,
  });

  @override
  List<Object?> get props => <Object?>[title, author, category, filePath, type];
}

class SubmitCsvContributionEvent extends ContributeEvent {
  final String scriptureTitle;
  final String csvContent;

  const SubmitCsvContributionEvent({
    required this.scriptureTitle,
    required this.csvContent,
  });

  @override
  List<Object?> get props => <Object?>[scriptureTitle, csvContent];
}
