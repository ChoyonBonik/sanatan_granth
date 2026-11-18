import 'package:equatable/equatable.dart';

enum ContributionType { bookPdf, bookEpub, verseCsv, verseJson }
enum ContributionStatus { pending, underReview, approved, rejected }

class ContributionEntity extends Equatable {
  final String id;
  final String title;
  final ContributionType type;
  final ContributionStatus status;
  final DateTime submissionDate;
  final String category;
  final String? fileUrl;
  final String? reviewerNotes;
  final int totalItemsCount;

  const ContributionEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.submissionDate,
    required this.category,
    this.fileUrl,
    this.reviewerNotes,
    this.totalItemsCount = 0,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        type,
        status,
        submissionDate,
        category,
        fileUrl,
        reviewerNotes,
        totalItemsCount,
      ];
}
