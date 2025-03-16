import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url_supabase, anonKey: anonKey_supabase);
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
          title: 'Our Market',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.lightBeige,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SignIn(),
        ));
  }
}

class MainHomeView extends StatefulWidget {
  MainHomeView({super.key});
  //final UserDataModel userDataModel;

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  late List<Widget> views;
  @override
  void initState() {
    views = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
