import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/reading_progress_entity.dart';

class ContinueReadingCard extends StatelessWidget {
  final BookEntity? book;
  final ReadingProgressEntity? progress;
  final VoidCallback? onListen;

  const ContinueReadingCard({
    super.key,
    required this.book,
    required this.progress,
    this.onListen,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String bookTitle = book?.title ?? 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ';
    final int verseNum = progress?.lastVerseOrPage ?? 1;
    final int totalVerses = (book != null && book!.totalVerses > 0) ? book!.totalVerses : 700;
    final double percent = (verseNum / totalVerses).clamp(0.02, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.saffronPrimary.withAlpha(60),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.saffronPrimary.withAlpha(25),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _resumeReading(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header badge + Listen Quick Action
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.saffronPrimary.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.auto_stories_rounded,
                            size: 13,
                            color: AppColors.saffronDeep,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'CONTINUE READING / LISTENING',
                            style: TextStyle(
                              color: AppColors.saffronDeep,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Audio Listen Button
                    IconButton(
                      icon: const Icon(Icons.volume_up_rounded, color: AppColors.saffronPrimary, size: 20),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Listen to this scripture',
                      onPressed: onListen ?? () => _listenAudio(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Scripture Title & Subtitle
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 46,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[AppColors.saffronDeep, AppColors.rudrakshaMaroon],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'ॐ',
                          style: AppTypography.bengaliDisplay(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bookTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'অধ্যায় ১: অর্জুনবিষাদ যোগ • শ্লোক $verseNum',
                            style: AppTypography.bengaliVerse(
                              fontSize: 13,
                              color: AppColors.saffronDeep,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Quick Resume Pill
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.saffronPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => _resumeReading(context),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Resume', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Progress Indicator
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor: theme.dividerColor.withAlpha(60),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.saffronPrimary),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(percent * 100).toInt()}% completed',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resumeReading(BuildContext context) {
    final String bookId = book?.id ?? 'gita-as-it-is';
    if (book?.format == BookFormat.pdf) {
      context.push('/reader/pdf/$bookId');
    } else {
      context.push('/reader/structured/$bookId');
    }
  }

  void _listenAudio(BuildContext context) {
    final String bookId = book?.id ?? 'gita-as-it-is';
    context.push('/reader/structured/$bookId');
  }
}
