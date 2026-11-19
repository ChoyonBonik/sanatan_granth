import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/download_task_entity.dart';

class DownloadProgressCard extends StatelessWidget {
  final DownloadTaskEntity task;
  final VoidCallback onCancel;

  const DownloadProgressCard({
    super.key,
    required this.task,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.downloading_rounded, color: AppColors.saffronPrimary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: onCancel,
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: task.progress,
            backgroundColor: theme.dividerColor,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.saffronPrimary),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${(task.progress * 100).toInt()}% ডাউনলোড সম্পন্ন',
                style: theme.textTheme.bodySmall,
              ),
              Text(
                '${(task.downloadedBytes / 1000000).toStringAsFixed(1)} মেগাবাইট / ${(task.totalBytes / 1000000).toStringAsFixed(1)} মেগাবাইট',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
