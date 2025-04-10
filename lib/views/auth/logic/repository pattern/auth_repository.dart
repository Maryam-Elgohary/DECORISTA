// auth_repository.dart
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// auth_repository.dart
abstract class AuthRepository {
  Future<AuthResponse> signInWithEmail(String email, String password);
  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signUp(String email, String password, String fullName);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<void> addUserData(String userId, String name, String email);
  Future<UserDataModel?> getUserData(String userId);
  String? getCurrentUserId(); // Add this method
}

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseManager _supabaseManager;

  SupabaseAuthRepository(this._supabaseManager);

  @override
  String? getCurrentUserId() => _supabaseManager.client.auth.currentUser?.id;

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabaseManager.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    const webClientId =
        '949147877665-fhl29svqv457c3t4d4sqdqdphojopn71.apps.googleusercontent.com';
    final googleSignIn = GoogleSignIn(clientId: webClientId);
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) throw Exception('Google Sign-In cancelled');

    final googleAuth = await googleUser.authentication;
    return await _supabaseManager.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken!,
    );
  }

  @override
  Future<AuthResponse> signUp(
      String email, String password, String fullName) async {
    return await _supabaseManager.client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseManager.client.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabaseManager.client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> addUserData(String userId, String name, String email) async {
    await _supabaseManager.client.from('users').upsert({
      'user_id': userId,
      'name': name,
      'email': email,
    });
  }

  @override
  Future<UserDataModel?> getUserData(String userId) async {
    final data = await _supabaseManager.client
        .from('users')
        .select()
        .eq('user_id', userId);
    if (data.isEmpty) return null;

    final nameParts = (data[0]['name'] as String).split(' ');
    return UserDataModel(
      email: data[0]['email'],
      firstName: nameParts[0],
      lastName: nameParts.length > 1 ? nameParts[1] : '',
      userId: data[0]['user_id'],
    );
  }
}
