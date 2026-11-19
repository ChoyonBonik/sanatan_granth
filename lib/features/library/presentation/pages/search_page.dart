import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sanatan_granth/core/theme/app_colors.dart';
import 'package:sanatan_granth/core/theme/app_typography.dart';
import '../../domain/entities/book_entity.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  String _selectedLanguage = 'All';
  BookFormatType? _selectedFormat;

  static const List<String> _languages = <String>[
    'All',
    'Sanskrit & Bengali',
    'Bengali',
    'English',
  ];

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<LibraryBloc>().add(
            SearchQueryChangedEvent(
              query,
              language: _selectedLanguage,
              format: _selectedFormat,
            ),
          );
    });
  }

  void _onFilterChanged({String? language, BookFormatType? format, bool clearFormat = false}) {
    setState(() {
      if (language != null) _selectedLanguage = language;
      if (clearFormat) {
        _selectedFormat = null;
      } else if (format != null) {
        _selectedFormat = format;
      }
    });

    context.read<LibraryBloc>().add(
          SearchQueryChangedEvent(
            _searchController.text,
            language: _selectedLanguage,
            format: _selectedFormat,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search scriptures, slokas, authors...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
          ),
          onChanged: _onSearchChanged,
        ),
        actions: <Widget>[
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _debounceTimer?.cancel();
                context.read<LibraryBloc>().add(ClearSearchEvent());
              },
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _buildFilterBar(theme),
        ),
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (BuildContext context, LibraryState state) {
          if (state.status == LibraryStatus.searching) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          }

          if (state.searchQuery.isEmpty &&
              _selectedLanguage == 'All' &&
              _selectedFormat == null) {
            return _buildSearchSuggestions(theme);
          }

          if (state.searchResults.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search_off_rounded, size: 60, color: theme.disabledColor),
                    const SizedBox(height: 14),
                    Text(
                      'No scriptures found matching "${state.searchQuery}"',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try searching for "Gita", "Upanishad", "ধর্মক্ষেত্রে", "নচিকেতা", or adjust active filters.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            itemCount: state.searchResults.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 16),
            itemBuilder: (BuildContext context, int index) {
              final BookEntity book = state.searchResults[index];
              final bool isStructured = book.format == BookFormatType.structured;

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => context.push('/book/${book.id}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 48,
                        height: 56,
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
                            if (book.sanskritTitle != null)
                              Text(
                                book.sanskritTitle!,
                                style: AppTypography.bengaliVerse(
                                  fontSize: 12,
                                  color: AppColors.saffronDeep,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            Text(
                              book.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${book.author} • ${book.category}',
                              style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (isStructured ? AppColors.saffronPrimary : Colors.teal)
                                        .withAlpha(25),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isStructured ? 'Structured Verse' : 'PDF / EPUB',
                                    style: TextStyle(
                                      color: isStructured ? AppColors.saffronDeep : Colors.teal,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  book.language,
                                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterBar(ThemeData theme) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor, width: 0.6)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Format filter: All
          _filterChip(
            label: 'All Formats',
            isSelected: _selectedFormat == null,
            onSelected: (_) => _onFilterChanged(clearFormat: true),
          ),
          const SizedBox(width: 6),

          // Format: Structured Verse
          _filterChip(
            label: 'Structured Verse',
            isSelected: _selectedFormat == BookFormatType.structured,
            onSelected: (_) => _onFilterChanged(
              format: _selectedFormat == BookFormatType.structured ? null : BookFormatType.structured,
              clearFormat: _selectedFormat == BookFormatType.structured,
            ),
          ),
          const SizedBox(width: 6),

          // Format: PDF / EPUB
          _filterChip(
            label: 'PDF / EPUB',
            isSelected: _selectedFormat == BookFormatType.pdf,
            onSelected: (_) => _onFilterChanged(
              format: _selectedFormat == BookFormatType.pdf ? null : BookFormatType.pdf,
              clearFormat: _selectedFormat == BookFormatType.pdf,
            ),
          ),
          const SizedBox(width: 12),
          VerticalDivider(color: theme.dividerColor, indent: 8, endIndent: 8),
          const SizedBox(width: 12),

          // Language chips
          ..._languages.map((String lang) {
            final bool isSelected = _selectedLanguage == lang;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: _filterChip(
                label: lang,
                isSelected: isSelected,
                onSelected: (_) => _onFilterChanged(language: lang),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      showCheckmark: false,
      selectedColor: AppColors.saffronPrimary,
      labelStyle: TextStyle(
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.white : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildSearchSuggestions(ThemeData theme) {
    const List<String> popularSearches = <String>[
      'শ্রীমদ্ভগবদ্গীতা',
      'ঈশোপনিষদ',
      'ঋগ্বেদ সংহিতা',
      'বাল্মীকি রামায়ণ',
      'শ্রীমদ্ভাগবতম্',
      'শ্রীবিষ্ণুসহস্রনাম',
      'কর্মণ্যেবাধিকারস্তে',
      'সাংখ্য যোগ',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.trending_up_rounded, color: AppColors.saffronPrimary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Popular Vedic Scriptures & Verses',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: popularSearches.map((String term) {
              return ActionChip(
                label: Text(term),
                backgroundColor: theme.cardColor,
                side: BorderSide(color: theme.dividerColor, width: 0.8),
                labelStyle: const TextStyle(fontSize: 12),
                onPressed: () {
                  _searchController.text = term;
                  _onSearchChanged(term);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.saffronPrimary.withAlpha(20),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.lightbulb_outline_rounded, color: AppColors.saffronDeep),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search across book titles, authors, and Sanskrit/Bengali verse text with real-time debounced search.',
                    style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
