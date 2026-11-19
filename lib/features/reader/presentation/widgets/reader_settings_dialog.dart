import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/theme/bloc/theme_state.dart';

class ReaderSettingsDialog extends StatelessWidget {
  const ReaderSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return AlertDialog(
          title: const Text('পঠন পছন্দসমূহ'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'থিম রূপরেখা',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _buildThemeChip(
                      context,
                      label: 'সেপিয়া',
                      mode: AppThemeMode.sepia,
                      current: state.themeMode,
                    ),
                    const SizedBox(width: 8),
                    _buildThemeChip(
                      context,
                      label: 'উজ্জ্বল',
                      mode: AppThemeMode.light,
                      current: state.themeMode,
                    ),
                    const SizedBox(width: 8),
                    _buildThemeChip(
                      context,
                      label: 'অ্যামোলেড',
                      mode: AppThemeMode.amoledDark,
                      current: state.themeMode,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'অক্ষরের আকার',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    const Text('অ', style: TextStyle(fontSize: 14)),
                    Expanded(
                      child: Slider(
                        value: state.fontScale,
                        min: 0.8,
                        max: 1.6,
                        divisions: 8,
                        activeColor: AppColors.saffronPrimary,
                        onChanged: (double val) {
                          context.read<ThemeCubit>().setFontScale(val);
                        },
                      ),
                    ),
                    const Text('অ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('উচ্চারণ ও অন্বয় (লিপ্যন্তর)'),
                  value: state.showTransliteration,
                  activeColor: AppColors.saffronPrimary,
                  onChanged: (bool val) {
                    context.read<ThemeCubit>().toggleTransliteration();
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('তাৎপর্য ও ব্যাখ্যা'),
                  value: state.showCommentary,
                  activeColor: AppColors.saffronPrimary,
                  onChanged: (bool val) {
                    context.read<ThemeCubit>().toggleCommentary();
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('অডিও শ্লোক স্বয়ংক্রিয় হাইলাইট'),
                  value: state.autoHighlightAudio,
                  activeColor: AppColors.saffronPrimary,
                  onChanged: (bool val) {
                    context.read<ThemeCubit>().toggleAudioHighlight();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('সম্পন্ন'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeChip(
    BuildContext context, {
    required String label,
    required AppThemeMode mode,
    required AppThemeMode current,
  }) {
    final bool isSelected = mode == current;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.saffronPrimary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (_) {
        context.read<ThemeCubit>().setThemeMode(mode);
      },
    );
  }
}
