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
        label = 'অপেক্ষমাণ';
        break;
      case ContributionStatus.underReview:
        bg = Colors.blue.withAlpha(40);
        fg = Colors.blue[700]!;
        label = 'পর্যালোচনাধীন';
        break;
      case ContributionStatus.approved:
        bg = AppColors.tulsiGreen.withAlpha(40);
        fg = AppColors.tulsiGreen;
        label = 'অনুমোদিত ও প্রকাশিত';
        break;
      case ContributionStatus.rejected:
        bg = Colors.red.withAlpha(40);
        fg = Colors.red[700]!;
        label = 'সংশোধন প্রয়োজন';
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
