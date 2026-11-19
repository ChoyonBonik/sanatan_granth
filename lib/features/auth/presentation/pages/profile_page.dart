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
      appBar: AppBar(title: const Text('Devotee Profile & Settings')),
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
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.saffronPrimary,
                          child: Text(
                            user != null && !user.isGuest && user.displayName.isNotEmpty
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
                                user?.isGuest == true || user == null
                                    ? 'Guest Devotee'
                                    : user.displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user?.isGuest == true || user == null
                                    ? 'Guest Mode • Read offline & canonical scriptures'
                                    : (user.email.isNotEmpty ? user.email : 'devotee@sanatan.org'),
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (user == null || user.isGuest) ...<Widget>[
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            child: Text(
                              'Sign in to sync your bookmarks across devices and contribute scriptures.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.saffronPrimary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => context.push('/login'),
                            child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Reading & Display',
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
                          title: const Text('Theme Mode'),
                          subtitle: Text(_getThemeName(themeState.themeMode)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _pickTheme(context),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.format_size_rounded, color: AppColors.saffronPrimary),
                          title: const Text('Font Scale Factor'),
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
                'Account',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.favorite_border, color: AppColors.saffronPrimary),
                      title: const Text('Bookmarks & Favorite Verses'),
                      subtitle: (user == null || user.isGuest)
                          ? const Text('Sign in to sync across devices', style: TextStyle(fontSize: 11))
                          : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (user == null || user.isGuest) {
                          _showSyncBookmarkPrompt(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All bookmarks are synced with cloud.')),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                    if (user == null || user.isGuest)
                      ListTile(
                        leading: const Icon(Icons.login_rounded, color: AppColors.saffronPrimary),
                        title: const Text('Sign In / Register', style: TextStyle(color: AppColors.saffronPrimary, fontWeight: FontWeight.bold)),
                        onTap: () => context.push('/login'),
                      )
                    else
                      ListTile(
                        leading: const Icon(Icons.logout_rounded, color: Colors.red),
                        title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
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
        return 'Warm Sepia';
      case AppThemeMode.light:
        return 'Pure Light';
      case AppThemeMode.amoledDark:
        return 'AMOLED Dark';
      case AppThemeMode.system:
        return 'System Default';
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
                title: const Text('Warm Sepia (Vedic Parchment)'),
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(AppThemeMode.sepia);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Pure Light'),
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(AppThemeMode.light);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('AMOLED Dark (Pure Black)'),
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
              title: const Text('Adjust Font Scale'),
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
                  child: const Text('Done'),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSyncBookmarkPrompt(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Row(
            children: <Widget>[
              Icon(Icons.sync_rounded, color: AppColors.saffronPrimary),
              SizedBox(width: 8),
              Text('Sync Bookmarks'),
            ],
          ),
          content: const Text(
            'You are currently reading as a Guest. Bookmarks are saved on this device only.\n\nSign in to sync your bookmarks, notes, and reading progress across all devices.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Later'),
              onPressed: () => Navigator.pop(ctx),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.saffronPrimary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sign In Now'),
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/login');
              },
            ),
          ],
        );
      },
    );
  }
}
