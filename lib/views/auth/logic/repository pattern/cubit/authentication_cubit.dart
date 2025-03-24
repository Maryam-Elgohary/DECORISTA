// authentication_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _authRepository;
  UserDataModel? userDataModel;

  AuthenticationCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await _authRepository.signInWithEmail(email, password);
      if (response.user == null) throw Exception('Login failed');

      userDataModel = await _authRepository.getUserData(response.user!.id);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    try {
      final response = await _authRepository.signInWithGoogle();
      final user = response.user;
      if (user == null) throw Exception('Google sign-in failed');

      await _authRepository.addUserData(
        user.id,
        user.userMetadata?['full_name'] ?? 'Unknown',
        user.email ?? 'No email',
      );

      userDataModel = await _authRepository.getUserData(user.id);
      emit(GoogleSignInSuccess());
      return response;
    } catch (e) {
      emit(GoogleSignInError());
      return AuthResponse();
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      final fullName = '$firstName $lastName';
      final response = await _authRepository.signUp(email, password, fullName);
      if (response.user?.id == null)
        throw Exception("User ID is null after sign-up");

      await _authRepository.addUserData(response.user!.id, fullName, email);
      userDataModel = await _authRepository.getUserData(response.user!.id);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(LoginLoading());
    try {
      await _authRepository.signOut();
      userDataModel = null;
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError());
    }
  }

  Future<void> resetPasswords({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await _authRepository.resetPassword(email);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(PasswordResetError());
    }
  }

  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final userId = _authRepository.getCurrentUserId();
      if (userId == null) throw Exception('No authenticated user');

      userDataModel = await _authRepository.getUserData(userId);
      if (userDataModel != null) {
        emit(GetUserDataSuccess());
      } else {
        emit(GetUserDataError('User data not found'));
      }
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }
}
