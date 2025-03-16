import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/my_observer.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/onboarding_screens/onboarding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url_supabase, anonKey: anonKey_supabase);
  Bloc.observer = MyObserver();
  runApp(BlocProvider(
    create: (context) => AuthenticationCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SupabaseClient client = Supabase.instance.client;
    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Decorista',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:
                //client.auth.currentUser != null ? MainHomeView() :
                const OnBoarding()));
  }
}
