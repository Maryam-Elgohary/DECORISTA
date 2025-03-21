import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final result = await client.auth
          .signInWithPassword(password: password, email: email);
      if (result.user != null) {
        // User is signed in, now fetch their data
        await getUserData();
        emit(LoginSuccess());
      } else {
        log("Login failed: no user returned.");
        emit(LoginError("Login failed"));
      }
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  //GoogleSignInAccount? googleUser;
  Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '949147877665-fhl29svqv457c3t4d4sqdqdphojopn71.apps.googleusercontent.com';

    emit(GoogleSignInLoading());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
          //     serverClientId: webClientId,
          clientId: webClientId);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-In cancelled.');
        return AuthResponse();
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final accessToken = googleAuth.accessToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        throw Exception('Failed to get ID Token');
      }

      final AuthResponse response = await Supabase.instance.client.auth
          .signInWithIdToken(
              provider: OAuthProvider.google,
              idToken: idToken,
              accessToken: accessToken);

      final userId = response.user?.id;
      if (userId == null) {
        throw Exception("User ID is null after sign-up");
      }

      await addUserData(
        userId: userId,
        name: googleUser?.displayName ?? 'Unknown',
        email: googleUser?.email ?? 'No email',
      );

      await getUserData();
      emit(GoogleSignInSuccess());
      return response;
    } catch (e) {
      print("Google Sign-In Error: $e");
      emit(GoogleSignInError());
      return AuthResponse();
    }
  }

  // Future<void> googleSignIn() async {
  //   emit(GoogleSignInLoading());

  //   try {
  //     await client.auth.signInWithOAuth(OAuthProvider.google,
  //         redirectTo:
  //             "https://wdgpfhefvzknfoeaxizj.supabase.co/auth/v1/callback");

  //     final session = client.auth.currentSession;
  //     final user = session?.user;

  //     if (user == null) {
  //       emit(GoogleSignInError());
  //       return;
  //     }

  //     await addUserData(
  //       userId: user.id,
  //       name: user.userMetadata?['full_name'] ?? 'Unknown',
  //       email: user.email ?? 'No email',
  //     );

  //     await getUserData();
  //     emit(GoogleSignInSuccess());
  //   } catch (e) {
  //     emit(GoogleSignInError());
  //     print("Google Sign-In Error: $e");
  //   }
  // }

  Future<void> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    emit(SignUpLoading());
    try {
      // Sign up the user and get the response
      final authResponse = await client.auth.signUp(
          password: password,
          email: email,
          data: {'full_name': firstName + " " + lastName});

      // Get the user ID from the response
      final userId = authResponse.user?.id;
      if (userId == null) {
        throw Exception("User ID is null after sign-up");
      }

      // Add user data using the userId
      await addUserData(
          userId: userId, name: firstName + " " + lastName, email: email);
      await getUserData();
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> addUserData({
    required String userId,
    required String name,
    required String email,
  }) async {
    emit(UserDataAddedLoading());
    try {
      await client
          .from('users')
          .upsert({'user_id': userId, 'name': name, 'email': email});
      emit(UserDataAddedSuccess());
    } catch (e) {
      log(e.toString());
      emit(UserDataAddedError());
    }
  }

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final userId = client.auth.currentUser!.id;
      final data = await client.from("users").select().eq('user_id', userId);

      log(data.toString());
      if (data.isNotEmpty) {
        userDataModel = UserDataModel(
          email: data[0]['email'],
          firstName: data[0]['name'].split(' ')[0],
          lastName: data[0]['name'].split(' ')[1],
          userId: data[0]['user_id'],
        );
        emit(GetUserDataSuccess());
      }
    } catch (e) {
      log(e.toString());
      emit(GetUserDataError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(LoginLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutError());
    }
  }

  Future<void> resetPasswords({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } catch (e) {
      log(e.toString());
      emit(PasswordResetError());
    }
  }
}
