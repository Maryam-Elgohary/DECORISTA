import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/home/UI/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/my_observer.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart'; // Import SupabaseManager
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/my_app.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/supabase_cart_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (still required for SupabaseManager to work)
  await Supabase.initialize(
    url: url_supabase,
    anonKey: anonKey_supabase,
  );

  Bloc.observer = MyObserver();

  // Use SupabaseManager to get the Singleton SupabaseClient instance
  final supabase = SupabaseManager();

  // Create repository instances
  final authRepository =
      SupabaseAuthRepository(supabase); // Pass Singleton instance
  final cartRepository = SupabaseCartRepository(
      ApiServices()); // ApiServices is already a Singleton

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            AuthenticationCubit(authRepository: authRepository)..getUserData(),
      ),
      BlocProvider(
        create: (context) => HomeCubit(),
      ),
      BlocProvider(
        create: (context) => CartCubit(
          cartRepository: cartRepository,
          supabaseManager: supabase, // Pass Singleton instance
        ),
      ),
    ],
    child: const MyApp(),
  ));
}
