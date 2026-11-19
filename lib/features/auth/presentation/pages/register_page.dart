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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignUpEvent(
              displayName: _nameController.text.trim(),
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
          appBar: AppBar(title: const Text('অ্যাকাউন্ট তৈরি করুন')),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'ॐ',
                          style: AppTypography.bengaliDisplay(
                            fontSize: 56,
                            color: AppColors.saffronPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'সনাতন গ্রন্থে যুক্ত হোন',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 24),

                      AuthTextField(
                        controller: _nameController,
                        label: 'পূর্ণ নাম / ভক্তের নাম',
                        prefixIcon: Icons.person_outline,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'নাম আবশ্যক';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

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
                        text: 'অ্যাকাউন্ট তৈরি করুন',
                        isLoading: state.status == AuthStatus.loading,
                        onPressed: _onRegister,
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
