import '../../domain/entities/contribution_entity.dart';

class ContributionModel extends ContributionEntity {
  const ContributionModel({
    required super.id,
    required super.title,
    required super.type,
    required super.status,
    required super.submissionDate,
    required super.category,
    super.fileUrl,
    super.reviewerNotes,
    super.totalItemsCount = 0,
  });

  factory ContributionModel.fromJson(Map<String, dynamic> json) {
    ContributionType type = ContributionType.bookPdf;
    if (json['type'] == 'verse_csv') {
      type = ContributionType.verseCsv;
    } else if (json['type'] == 'verse_json') {
      type = ContributionType.verseJson;
    } else if (json['type'] == 'book_epub') {
      type = ContributionType.bookEpub;
    }

    ContributionStatus status = ContributionStatus.pending;
    if (json['status'] == 'under_review') {
      status = ContributionStatus.underReview;
    } else if (json['status'] == 'approved') {
      status = ContributionStatus.approved;
    } else if (json['status'] == 'rejected') {
      status = ContributionStatus.rejected;
    }

    return ContributionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: type,
      status: status,
      submissionDate: DateTime.parse(json['submission_date'] as String),
      category: json['category'] as String? ?? 'General',
      fileUrl: json['file_url'] as String?,
      reviewerNotes: json['reviewer_notes'] as String?,
      totalItemsCount: (json['total_items_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type.name,
      'status': status.name,
      'submission_date': submissionDate.toIso8601String(),
      'category': category,
      'file_url': fileUrl,
      'reviewer_notes': reviewerNotes,
      'total_items_count': totalItemsCount,
    };
  }
}
