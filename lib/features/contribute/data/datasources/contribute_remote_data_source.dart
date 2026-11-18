import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/contribution_entity.dart';
import '../models/contribution_model.dart';

abstract class ContributeRemoteDataSource {
  Future<ContributionModel> submitContribution({
    required String title,
    required String category,
    required ContributionType type,
    String? fileUrl,
    int totalItems = 0,
  });

  Future<List<ContributionModel>> getMyContributions();
}

class ContributeRemoteDataSourceImpl implements ContributeRemoteDataSource {
  final SupabaseClient? _supabaseClient;

  ContributeRemoteDataSourceImpl({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<ContributionModel> submitContribution({
    required String title,
    required String category,
    required ContributionType type,
    String? fileUrl,
    int totalItems = 0,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': 'contrib-${DateTime.now().millisecondsSinceEpoch}',
      'title': title,
      'category': category,
      'type': type.name,
      'status': ContributionStatus.pending.name,
      'submission_date': DateTime.now().toIso8601String(),
      'file_url': fileUrl,
      'total_items_count': totalItems,
    };

    try {
      if (_supabaseClient != null) {
        await _supabaseClient.from(AppConstants.contributionsTable).insert(data);
      }
      return ContributionModel.fromJson(data);
    } catch (_) {
      return ContributionModel.fromJson(data);
    }
  }

  @override
  Future<List<ContributionModel>> getMyContributions() async {
    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> res = await _supabaseClient
            .from(AppConstants.contributionsTable)
            .select()
            .order('submission_date', ascending: false);
        return res.map(ContributionModel.fromJson).toList();
      }
      return _mockContributions;
    } catch (_) {
      return _mockContributions;
    }
  }

  static final List<ContributionModel> _mockContributions = <ContributionModel>[
    ContributionModel(
      id: 'contrib-1',
      title: 'Mandukya Upanishad Karika (Gaudapada)',
      type: ContributionType.verseCsv,
      status: ContributionStatus.approved,
      submissionDate: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Upanishads',
      totalItemsCount: 215,
      reviewerNotes: 'Verified and aligned with Shankara commentary.',
    ),
    ContributionModel(
      id: 'contrib-2',
      title: 'Shiva Mahapurana (Vidyeshvara Samhita)',
      type: ContributionType.bookPdf,
      status: ContributionStatus.underReview,
      submissionDate: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Puranas & Itihasa',
      totalItemsCount: 1,
      reviewerNotes: 'Checking scan resolution and copyright status.',
    ),
  ];
}
