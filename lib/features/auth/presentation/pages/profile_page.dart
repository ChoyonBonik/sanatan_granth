import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('ভক্ত প্রোফাইল ও সেটিংস')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState authState) {
          final user = authState.user;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              // User Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor, width: 0.8),
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.saffronPrimary,
                      child: Text(
                        user != null && user.displayName.isNotEmpty
                            ? user.displayName[0].toUpperCase()
                            : 'ॐ',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user?.displayName ?? 'সনাতন পাঠক',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'devotee@sanatan.org',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'পঠন ও প্রদর্শন',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (BuildContext context, ThemeState themeState) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.palette_outlined, color: AppColors.saffronPrimary),
                          title: const Text('থিম রূপরেখা'),
                          subtitle: Text(_getThemeName(themeState.themeMode)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _pickTheme(context),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.format_size_rounded, color: AppColors.saffronPrimary),
                          title: const Text('অক্ষরের মাপ'),
                          subtitle: Text('${(themeState.fontScale * 100).toInt()}%'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showFontScaleDialog(context, themeState.fontScale),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              Text(
                'অ্যাকাউন্ট',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.favorite_border, color: AppColors.saffronPrimary),
                      title: const Text('বুকমার্ক ও প্রিয় শ্লোকাবলী'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded, color: Colors.red),
                      title: const Text('লগআউট', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        context.read<AuthBloc>().add(SignOutEvent());
                        context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.sepia:
        return 'সেপিয়া';
      case AppThemeMode.light:
        return 'উজ্জ্বল';
      case AppThemeMode.amoledDark:
        return 'অ্যামোলেড ডার্ক';
      case AppThemeMode.system:
        return 'সিস্টেম ডিফল্ট';
    }
  }

  void _pickTheme(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('উষ্ণ সেপিয়া (বৈদিক পত্র)'),
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(AppThemeMode.sepia);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('উজ্জ্বল শুভ্র (লাইট)'),
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(AppThemeMode.light);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('অ্যামোলেড ডার্ক (গভীর কৃষ্ণ)'),
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(AppThemeMode.amoledDark);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFontScaleDialog(BuildContext context, double currentScale) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        double val = currentScale;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('অক্ষরের মাপ নির্ধারণ'),
              content: Slider(
                value: val,
                min: 0.8,
                max: 1.6,
                divisions: 8,
                activeColor: AppColors.saffronPrimary,
                onChanged: (double newV) {
                  setState(() => val = newV);
                  context.read<ThemeCubit>().setFontScale(newV);
                },
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('সম্পন্ন'),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
