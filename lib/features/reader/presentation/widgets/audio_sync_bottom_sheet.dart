import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AudioSyncBottomSheet extends StatelessWidget {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String title;
  final VoidCallback onPlayPause;
  final ValueChanged<Duration> onSeek;

  const AudioSyncBottomSheet({
    super.key,
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.title,
    required this.onPlayPause,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(color: theme.dividerColor, width: 0.8),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.saffronPrimary.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.audiotrack_rounded,
                    color: AppColors.saffronPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${_formatDuration(position)} / ${_formatDuration(duration)}',
                        style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10_rounded),
                  onPressed: () {
                    final newPos = position - const Duration(seconds: 10);
                    onSeek(newPos < Duration.zero ? Duration.zero : newPos);
                  },
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                    size: 40,
                    color: AppColors.saffronPrimary,
                  ),
                  onPressed: onPlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10_rounded),
                  onPressed: () {
                    final newPos = position + const Duration(seconds: 10);
                    onSeek(newPos > duration ? duration : newPos);
                  },
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                activeTrackColor: AppColors.saffronPrimary,
                thumbColor: AppColors.saffronPrimary,
              ),
              child: Slider(
                value: position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble(),
                max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1.0,
                onChanged: (double val) => onSeek(Duration(milliseconds: val.toInt())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
