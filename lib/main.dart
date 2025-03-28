import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/my_observer.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'views/auth/UI/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '$url_supabase',
    anonKey: anonKey_supabase,
  );

  Bloc.observer = MyObserver();
  final supabase = Supabase.instance.client;
  // Create repository instance first
  final authRepository = SupabaseAuthRepository(Supabase.instance.client);
  // Create repository
  final cartRepository = SupabaseCartRepository(ApiServices());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        // Provide the repository when creating the cubit
        create: (context) =>
            AuthenticationCubit(authRepository: authRepository)..getUserData(),
      ),
      BlocProvider(
        create: (context) => HomeCubit(),
      ),
      BlocProvider(
          create: (context) => CartCubit(
                cartRepository: cartRepository,
                supabase: supabase,
              ))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        SupabaseClient client = Supabase.instance.client;

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Decorista',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xffffffff),
              useMaterial3: true,
            ),
            home: client.auth.currentUser != null
                ? state is GetUserDataLoading
                    ? const Scaffold(
                        body: Center(
                          child: CustomCircleProIndicator(),
                        ),
                      )
                    : (context.read<AuthenticationCubit>().userDataModel != null
                        ? MainHomeView(
                            userDataModel: context
                                .read<AuthenticationCubit>()
                                .userDataModel!)
                        : const SignIn())
                : const SignIn());
      },
    );
  }
}
