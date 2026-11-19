import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/download_task_entity.dart';
import '../../../library/domain/entities/book_entity.dart';
import '../bloc/offline_bloc.dart';
import '../bloc/offline_event.dart';
import '../bloc/offline_state.dart';
import '../widgets/download_progress_card.dart';

class DownloadManagerPage extends StatefulWidget {
  const DownloadManagerPage({super.key});

  @override
  State<DownloadManagerPage> createState() => _DownloadManagerPageState();
}

class _DownloadManagerPageState extends State<DownloadManagerPage> {
  @override
  void initState() {
    super.initState();
    context.read<OfflineBloc>().add(LoadOfflineDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('অফলাইন ভাণ্ডার ও ডাউনলোড'),
      ),
      body: BlocBuilder<OfflineBloc, OfflineState>(
        builder: (BuildContext context, OfflineState state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              // Storage Stats Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor, width: 0.8),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.saffronPrimary.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.offline_pin_rounded,
                        color: AppColors.saffronDeep,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'স্থানীয় অফলাইন সংগ্রহাগার',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${state.cachedBooks.length}টি গ্রন্থ সংরক্ষিত • ইন্টারনেট ছাড়াই দ্রুত পাঠযোগ্য',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Active Downloads Section
              if (state.activeDownloads.isNotEmpty) ...<Widget>[
                Text(
                  'চলতি ডাউনলোড',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...state.activeDownloads.map(
                  (DownloadTaskEntity task) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DownloadProgressCard(
                      task: task,
                      onCancel: () {
                        context.read<OfflineBloc>().add(CancelDownloadEvent(task.id));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Cached Books
              Text(
                'সংরক্ষিত শাস্ত্রসমূহ',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              if (state.cachedBooks.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.cloud_off_rounded, size: 56, color: theme.disabledColor),
                        const SizedBox(height: 12),
                        const Text('এখনও কোনো শাস্ত্র অফলাইনে সংরক্ষিত নেই।'),
                        const SizedBox(height: 4),
                        Text(
                          'ইন্টারনেট ছাড়াই পড়তে গ্রন্থাগার থেকে শাস্ত্র ডাউনলোড করে রাখুন।',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...state.cachedBooks.map(
                  (BookEntity book) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.menu_book, color: AppColors.saffronPrimary),
                      title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${book.author} • ${book.category}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          context.read<OfflineBloc>().add(DeleteCachedBookEvent(book.id));
                        },
                      ),
                      onTap: () => context.push('/reader/structured/${book.id}'),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
