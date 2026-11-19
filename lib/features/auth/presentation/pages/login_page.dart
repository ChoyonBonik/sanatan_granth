import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/saffron_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignInEvent(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/');
        } else if (state.status == AuthStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'ॐ',
                          style: AppTypography.bengaliDisplay(
                            fontSize: 72,
                            color: AppColors.saffronPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'সনাতন গ্রন্থ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'পাঠের অগ্রগতি, বুকমার্ক ও শাস্ত্রীয় সেবায় যুক্ত হতে প্রবেশ করুন।',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),

                      AuthTextField(
                        controller: _emailController,
                        label: 'ইমেইল ঠিকানা',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? val) {
                          if (val == null || !val.contains('@')) {
                            return 'সঠিক ইমেইল ঠিকানা লিখুন';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _passwordController,
                        label: 'পাসওয়ার্ড',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                        validator: (String? val) {
                          if (val == null || val.length < 6) {
                            return 'পাসওয়ার্ড অন্তত ৬ অক্ষরের হতে হবে';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      SaffronButton(
                        text: 'প্রবেশ করুন',
                        isLoading: state.status == AuthStatus.loading,
                        onPressed: _onLogin,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('কোনো অ্যাকাউন্ট নেই?'),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text(
                              'নিবন্ধন করুন',
                              style: TextStyle(color: AppColors.saffronPrimary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
