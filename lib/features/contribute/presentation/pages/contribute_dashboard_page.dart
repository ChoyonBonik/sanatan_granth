import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ContributeDashboardPage extends StatelessWidget {
  const ContributeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seva & Contribution Portal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[AppColors.saffronDeep, AppColors.saffronPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'विद्यादानं महत्पुण्यम्',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Share and preserve rare Hindu manuscripts, digital PDF/EPUB scriptures, and structured translations for global devotees.',
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.push('/contribute/tracker'),
                  icon: const Icon(Icons.history_rounded, size: 18),
                  label: const Text('My Submissions & Status'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.saffronDeep,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Ways to Contribute',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          _buildActionCard(
            context,
            icon: Icons.picture_as_pdf_rounded,
            title: 'Upload Book (PDF / EPUB)',
            subtitle:
                'Submit high-quality scanned scriptures, rare commentaries, or authentic digital books.',
            onTap: () => context.push('/contribute/upload-document'),
          ),

          const SizedBox(height: 14),

          _buildActionCard(
            context,
            icon: Icons.table_chart_rounded,
            title: 'Structured Verse CSV / JSON Uploader',
            subtitle:
                'Upload bulk slokas, word-for-word synonyms, Roman IAST, and commentaries via CSV or JSON.',
            onTap: () => context.push('/contribute/upload-csv'),
          ),

          const SizedBox(height: 14),

          _buildActionCard(
            context,
            icon: Icons.track_changes_rounded,
            title: 'Pending Status Tracker',
            subtitle:
                'Monitor verification progress by our scholarly review committee and editorial team.',
            onTap: () => context.push('/contribute/tracker'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor, width: 0.8),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.saffronPrimary.withAlpha(25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.saffronDeep, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}
