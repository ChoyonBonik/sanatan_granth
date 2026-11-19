import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/reader_theme_extension.dart';
import '../../domain/entities/verse_entity.dart';

class VerseViewCard extends StatelessWidget {
  final VerseEntity verse;
  final bool isActive;
  final bool isSpeaking;
  final double fontScale;
  final bool showTransliteration;
  final bool showCommentary;
  final VoidCallback onPlayTts;
  final VoidCallback onSelect;

  const VerseViewCard({
    super.key,
    required this.verse,
    required this.isActive,
    required this.isSpeaking,
    this.fontScale = 1.0,
    this.showTransliteration = true,
    this.showCommentary = true,
    required this.onPlayTts,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ReaderThemeExtension? readerTheme =
        theme.extension<ReaderThemeExtension>();

    final Color verseColor =
        readerTheme?.verseTextColor ?? AppColors.saffronDeep;
    final Color translationColor =
        readerTheme?.translationColor ?? theme.textTheme.bodyLarge!.color!;
    final Color activeBg = readerTheme?.activeAudioHighlightColor ??
        AppColors.sepiaActiveAudioHighlight;

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isActive ? activeBg : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? AppColors.saffronPrimary
                : (readerTheme?.cardBorderColor ?? theme.dividerColor),
            width: isActive ? 1.5 : 0.8,
          ),
          boxShadow: <BoxShadow>[
            if (isActive)
              BoxShadow(
                color: AppColors.saffronPrimary.withAlpha(30),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header with Verse Reference and Action Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.saffronPrimary.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'শ্লোক ${verse.chapterNumber}.${verse.verseNumber}',
                    style: const TextStyle(
                      color: AppColors.saffronDeep,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        isSpeaking
                            ? Icons.volume_up_rounded
                            : Icons.volume_down_outlined,
                        color: isSpeaking
                            ? AppColors.saffronPrimary
                            : theme.iconTheme.color,
                        size: 22,
                      ),
                      tooltip: 'শ্লোক উচ্চারণ শুনুন (টিটিএস)',
                      onPressed: onPlayTts,
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_add_outlined, size: 20),
                      tooltip: 'বুকমার্কে সংরক্ষণ',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Original Script (Devanagari / Bengali / etc.)
            Text(
              verse.originalScriptText,
              textAlign: TextAlign.center,
              style: AppTypography.forText(
                verse.originalScriptText,
                fontSize: 22.0 * fontScale,
                fontWeight: FontWeight.w600,
                color: verseColor,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 14),

            // Roman IAST Transliteration (with accents)
            if (showTransliteration && verse.transliteration != null) ...<Widget>[
              Text(
                verse.transliteration!,
                textAlign: TextAlign.center,
                style: AppTypography.englishBody.copyWith(
                  fontSize: 15.0 * fontScale,
                  fontStyle: FontStyle.italic,
                  color: readerTheme?.transliterationColor ??
                      theme.textTheme.bodyMedium?.color,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Decorative Divider
            Center(
              child: Container(
                width: 60,
                height: 1.5,
                color: readerTheme?.ornamentalDividerColor ??
                    AppColors.vedicGold.withAlpha(100),
              ),
            ),
            const SizedBox(height: 14),

            // Word-for-Word Meanings (if present)
            if (verse.wordMeanings != null) ...<Widget>[
              Text(
                'শব্দার্থ ও অন্বয়',
                style: TextStyle(
                  fontSize: 12 * fontScale,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.saffronDeep,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                verse.wordMeanings!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13.0 * fontScale,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Vernacular / English Translation
            Text(
              'অনুবাদ',
              style: TextStyle(
                fontSize: 12 * fontScale,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: AppColors.saffronDeep,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              verse.translation,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16.0 * fontScale,
                height: 1.6,
                color: translationColor,
              ),
            ),

            // Commentary / Purport
            if (showCommentary && verse.commentary != null) ...<Widget>[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(120),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.dividerColor.withAlpha(80),
                    width: 0.6,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'তাৎপর্য ও ভাবার্থ',
                      style: TextStyle(
                        fontSize: 12 * fontScale,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: AppColors.saffronPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      verse.commentary!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.0 * fontScale,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
