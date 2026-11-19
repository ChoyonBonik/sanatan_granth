import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sanatan_granth/core/theme/app_colors.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          onChanged: (String query) {
            context.read<LibraryBloc>().add(SearchQueryChangedEvent(query));
          },
        ),
        actions: <Widget>[
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<LibraryBloc>().add(ClearSearchEvent());
              },
            ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (BuildContext context, LibraryState state) {
          if (state.status == LibraryStatus.searching) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          }

          if (state.searchQuery.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search_rounded,
                    size: 64,
                    color: theme.disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search across the sacred Vedic scriptures & commentaries',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          if (state.searchResults.isEmpty) {
            return Center(
              child: Text(
                'No scriptures found matching "${state.searchQuery}"',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.searchResults.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final BookEntity book = state.searchResults[index];
              return ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.saffronPrimary.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('ॐ', style: TextStyle(fontSize: 22)),
                  ),
                ),
                title: Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${book.author} • ${book.category}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/book/${book.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
