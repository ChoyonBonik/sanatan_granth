import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sanatan_granth/core/theme/app_colors.dart';
import 'package:sanatan_granth/core/theme/app_typography.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/chapter_entity.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  const BookDetailsPage({super.key, required this.bookId});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(LoadBookDetailsEvent(widget.bookId));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            tooltip: 'Bookmark Scripture',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scripture added to your bookmarks.')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied to share with devotees.')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (BuildContext context, LibraryState state) {
          final BookEntity? book = state.selectedBook;

          if (book == null && state.status == LibraryStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          }

          if (book == null) {
            return const Center(child: Text('Scripture not found.'));
          }

          String formatLabel = 'Structured Verse Reader';
          if (book.format == BookFormatType.pdf) {
            formatLabel = 'PDF Document';
          } else if (book.format == BookFormatType.epub) {
            formatLabel = 'EPUB';
          }

          final String contributor = book.contributorId ?? 'Sanatan Dharma Seva Academy';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header Cover & Primary Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: <Color>[AppColors.saffronDeep, AppColors.rudrakshaMaroon],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'ॐ',
                          style: AppTypography.bengaliDisplay(
                            fontSize: 56,
                            color: Colors.white.withAlpha(90),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (book.sanskritTitle != null)
                            Text(
                              book.sanskritTitle!,
                              style: AppTypography.bengaliVerse(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.saffronDeep,
                              ),
                            ),
                          Text(
                            book.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Author / Rishi: ${book.author}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.saffronPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.dividerColor,
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  book.category,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.star_rounded, size: 16, color: AppColors.vedicGold),
                                  const SizedBox(width: 2),
                                  Text(
                                    book.rating.toStringAsFixed(1),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Contributor Credit Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.saffronPrimary.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.saffronPrimary.withAlpha(50), width: 0.8),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.verified_rounded, color: AppColors.saffronDeep, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Contributed & Curated by: $contributor',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.saffronDeep,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons: Read Now, Listen, Download Offline
                Row(
                  children: <Widget>[
                    // Read Now
                    Expanded(
                      flex: 4,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.menu_book_rounded, size: 18),
                        label: const Text('Read Now', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.saffronPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => _openReader(context, book),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Listen
                    Expanded(
                      flex: 3,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.headphones_rounded, size: 18, color: AppColors.saffronPrimary),
                        label: const Text('Listen', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.saffronPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: const BorderSide(color: AppColors.saffronPrimary, width: 1.2),
                        ),
                        onPressed: () {
                          _openReader(context, book);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Download Offline
                    IconButton(
                      icon: const Icon(Icons.download_rounded),
                      tooltip: 'Download Offline',
                      style: IconButton.styleFrom(
                        backgroundColor: theme.cardColor,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: theme.dividerColor, width: 0.8),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Downloading "${book.title}" for offline reading...'),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Description
                Text(
                  'Overview & Spiritual Significance',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 20),

                // Metadata cards
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.dividerColor, width: 0.8),
                  ),
                  child: Column(
                    children: <Widget>[
                      _metaRow('Language', book.language),
                      const Divider(height: 18),
                      _metaRow('Total Verses', book.totalVerses > 0 ? '${book.totalVerses}' : 'N/A'),
                      const Divider(height: 18),
                      _metaRow('Format', formatLabel),
                      const Divider(height: 18),
                      _metaRow('Canonical Status', 'Approved Scholarly Scripture'),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Chapter List Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Chapters & Cantos',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${state.bookChapters.length} Chapters',
                      style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Chapter List
                if (state.bookChapters.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text('Chapters are being verified by scholars.'),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.bookChapters.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      final ChapterEntity chapter = state.bookChapters[index];
                      final int durationMins = chapter.durationSeconds > 0
                          ? (chapter.durationSeconds / 60).round()
                          : 0;

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.saffronPrimary.withAlpha(30),
                          child: Text(
                            '${chapter.chapterNumber}',
                            style: const TextStyle(
                              color: AppColors.saffronDeep,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        title: Text(
                          chapter.title,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        subtitle: durationMins > 0
                            ? Text('Audio: $durationMins min', style: const TextStyle(fontSize: 11))
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.saffronPrimary, size: 24),
                              tooltip: 'Listen to chapter',
                              onPressed: () => _openReader(context, book),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                              tooltip: 'Read chapter',
                              onPressed: () => _openReader(context, book),
                            ),
                          ],
                        ),
                        onTap: () => _openReader(context, book),
                      );
                    },
                  ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openReader(BuildContext context, BookEntity book) {
    if (book.format == BookFormatType.pdf) {
      context.push('/reader/pdf/${book.id}');
    } else {
      context.push('/reader/structured/${book.id}');
    }
  }

  Widget _metaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
