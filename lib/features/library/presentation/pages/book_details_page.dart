import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sanatan_granth/core/theme/app_colors.dart';
import 'package:sanatan_granth/core/theme/app_typography.dart';
import '../../domain/entities/book_entity.dart';
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
            tooltip: 'Bookmark',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book added to bookmarks')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share',
            onPressed: () {},
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

          String formatLabel = 'Verse Reader';
          if (book.format == BookFormat.pdf) {
            formatLabel = 'PDF Document';
          } else if (book.format == BookFormat.epub) {
            formatLabel = 'EPUB';
          }

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
                          colors: <Color>[
                            AppColors.saffronDeep,
                            AppColors.rudrakshaMaroon
                          ],
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
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Author: ${book.author}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.saffronPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Action Buttons (Read / Listen / Offline Download)
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.menu_book_rounded),
                        label: Text(book.format == BookFormat.pdf
                            ? 'Read PDF'
                            : 'Read Verses'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.saffronPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (book.format == BookFormat.pdf) {
                            context.push('/reader/pdf/${book.id}');
                          } else {
                            context.push('/reader/structured/${book.id}');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.download_rounded),
                      label: const Text('Download'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
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

                const SizedBox(height: 28),

                // Description
                Text(
                  'Overview & Spiritual Significance',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  book.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 24),

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
                      const Divider(height: 20),
                      _metaRow('Total Verses', book.totalVerses > 0 ? '${book.totalVerses}' : 'N/A'),
                      const Divider(height: 20),
                      _metaRow('Format', formatLabel),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
