import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/contribution_entity.dart';
import '../bloc/contribute_bloc.dart';
import '../bloc/contribute_event.dart';
import '../bloc/contribute_state.dart';
import '../widgets/contribution_status_badge.dart';

class ContributionStatusTrackerPage extends StatefulWidget {
  const ContributionStatusTrackerPage({super.key});

  @override
  State<ContributionStatusTrackerPage> createState() =>
      _ContributionStatusTrackerPageState();
}

class _ContributionStatusTrackerPageState
    extends State<ContributionStatusTrackerPage> {
  @override
  void initState() {
    super.initState();
    context.read<ContributeBloc>().add(LoadMyContributionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contribution Tracker')),
      body: BlocBuilder<ContributeBloc, ContributeState>(
        builder: (BuildContext context, ContributeState state) {
          if (state.status == ContributeStatus.loading &&
              state.contributions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          }

          if (state.contributions.isEmpty) {
            return const Center(
              child: Text('No contributions submitted yet.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.contributions.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
            itemBuilder: (BuildContext context, int index) {
              final ContributionEntity contrib = state.contributions[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 0.8,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ContributionStatusBadge(status: contrib.status),
                        Text(
                          _formatDate(contrib.submissionDate),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      contrib.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${contrib.category} • ${contrib.type.name.toUpperCase()} • ${contrib.totalItemsCount} items',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (contrib.reviewerNotes != null) ...<Widget>[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.rate_review_outlined,
                              size: 16,
                              color: AppColors.saffronPrimary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                contrib.reviewerNotes!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
