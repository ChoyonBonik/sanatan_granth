import 'package:flutter/material.dart';
import 'package:sanatan_granth/core/theme/app_colors.dart';
import 'package:sanatan_granth/core/theme/app_typography.dart';
import '../../domain/entities/book_entity.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    String formatLabel = 'VERSE';
    if (book.format == BookFormat.pdf) {
      formatLabel = 'PDF';
    } else if (book.format == BookFormat.epub) {
      formatLabel = 'EPUB';
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.dividerColor,
            width: 0.8,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(theme.brightness == Brightness.dark ? 30 : 10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Cover placeholder / format badge
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: <Color>[AppColors.saffronDeep, AppColors.rudrakshaMaroon],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      'ॐ',
                      style: AppTypography.bengaliDisplay(
                        fontSize: 44,
                        color: Colors.white.withAlpha(85),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        formatLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Sanskrit / Classical Title (if available)
            if (book.sanskritTitle != null) ...<Widget>[
              Text(
                book.sanskritTitle!,
                style: AppTypography.bengaliVerse(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.saffronDeep,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
            ],

            // Main Title
            Text(
              book.title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),

            // Author
            Text(
              book.author,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),

            // Footer: Total verses or rating (with Expanded to prevent horizontal overflow)
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    book.totalVerses > 0 ? '${book.totalVerses} verses' : book.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.saffronPrimary,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.star_rounded, size: 14, color: AppColors.vedicGold),
                    const SizedBox(width: 2),
                    Text(
                      book.rating.toStringAsFixed(1),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
