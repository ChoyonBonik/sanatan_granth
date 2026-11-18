import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../domain/entities/book_entity.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/book_card.dart';
import '../widgets/category_chip_bar.dart';
import '../widgets/scriptural_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LoadLibraryCatalogEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('सनातन ग्रन्थ'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search Scriptures',
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Theme Settings',
            onPressed: () => _showThemePicker(context),
          ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (BuildContext context, LibraryState state) {
          if (state.status == LibraryStatus.loading && state.books.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          }

          return RefreshIndicator(
            color: AppColors.saffronPrimary,
            onRefresh: () async {
              context.read<LibraryBloc>().add(const LoadLibraryCatalogEvent());
            },
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                // Daily Shloka Banner
                SliverToBoxAdapter(
                  child: ScripturalBanner(
                    onExplore: () => context.push('/reader/structured/gita-as-it-is'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // Category Filter Bar
                if (state.categories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: CategoryChipBar(
                      categories: state.categories,
                      selectedCategory: state.selectedCategory,
                      onSelected: (String category) {
                        context
                            .read<LibraryBloc>()
                            .add(SelectCategoryFilterEvent(category));
                      },
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Section Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          state.selectedCategory == 'All'
                              ? 'Sacred Canons'
                              : state.selectedCategory,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${state.books.length} Books',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                // Book Grid
                if (state.books.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('No books found for this category.'),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final BookEntity book = state.books[index];
                          return BookCard(
                            book: book,
                            onTap: () => context.push('/book/${book.id}'),
                          );
                        },
                        childCount: state.books.length,
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (BuildContext context, ThemeState themeState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Reading Themes',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _buildThemeTile(
                      ctx,
                      title: 'Warm Sepia (Vedic Parchment)',
                      subtitle: 'Palm-leaf tone for comfortable reading',
                      mode: AppThemeMode.sepia,
                      current: themeState.themeMode,
                      color: AppColors.sepiaBackground,
                    ),
                    _buildThemeTile(
                      ctx,
                      title: 'Pure Light',
                      subtitle: 'Crisp high-contrast day palette',
                      mode: AppThemeMode.light,
                      current: themeState.themeMode,
                      color: AppColors.lightBackground,
                    ),
                    _buildThemeTile(
                      ctx,
                      title: 'AMOLED Dark',
                      subtitle: 'True black 0-nit display for night reading',
                      mode: AppThemeMode.amoledDark,
                      current: themeState.themeMode,
                      color: AppColors.amoledBackground,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required AppThemeMode mode,
    required AppThemeMode current,
    required Color color,
  }) {
    final bool isSelected = mode == current;
    return ListTile(
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.saffronPrimary, width: 1.5),
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.saffronPrimary)
          : null,
      onTap: () {
        context.read<ThemeCubit>().setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }
}
