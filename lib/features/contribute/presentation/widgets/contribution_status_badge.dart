import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/contribution_entity.dart';

class ContributionStatusBadge extends StatelessWidget {
  final ContributionStatus status;

  const ContributionStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case ContributionStatus.pending:
        bg = Colors.amber.withAlpha(40);
        fg = Colors.orange[800]!;
        label = 'PENDING REVIEW';
        break;
      case ContributionStatus.underReview:
        bg = Colors.blue.withAlpha(40);
        fg = Colors.blue[700]!;
        label = 'UNDER REVIEW';
        break;
      case ContributionStatus.approved:
        bg = AppColors.tulsiGreen.withAlpha(40);
        fg = AppColors.tulsiGreen;
        label = 'APPROVED & PUBLISHED';
        break;
      case ContributionStatus.rejected:
        bg = Colors.red.withAlpha(40);
        fg = Colors.red[700]!;
        label = 'CHANGES REQUESTED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
