import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart' as app_exc;
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> get onAuthStateChanged;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient? _supabaseClient;

  AuthRemoteDataSourceImpl({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (_supabaseClient != null) {
        final AuthResponse response =
            await _supabaseClient.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (response.user != null) {
          return UserModel.fromSupabaseUser(response.user!);
        }
      }
      return UserModel(
        id: 'usr-${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: email.split('@').first,
        createdAt: DateTime.now(),
      );
    } on AuthException catch (e) {
      throw app_exc.AuthException(message: e.message);
    } catch (e) {
      throw app_exc.AuthException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (_supabaseClient != null) {
        final AuthResponse response = await _supabaseClient.auth.signUp(
          email: email,
          password: password,
          data: <String, dynamic>{'display_name': displayName},
        );
        if (response.user != null) {
          return UserModel.fromSupabaseUser(response.user!);
        }
      }
      return UserModel(
        id: 'usr-${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
      );
    } on AuthException catch (e) {
      throw app_exc.AuthException(message: e.message);
    } catch (e) {
      throw app_exc.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (_supabaseClient != null) {
        await _supabaseClient.auth.signOut();
      }
    } catch (e) {
      throw app_exc.AuthException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (_supabaseClient != null) {
        final User? user = _supabaseClient.auth.currentUser;
        if (user != null) {
          return UserModel.fromSupabaseUser(user);
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<UserModel?> get onAuthStateChanged {
    if (_supabaseClient == null) {
      return Stream<UserModel?>.value(null);
    }
    return _supabaseClient.auth.onAuthStateChange.map((AuthState state) {
      final User? user = state.session?.user;
      return user != null ? UserModel.fromSupabaseUser(user) : null;
    });
  }
}
