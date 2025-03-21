import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/my_observer.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/cubit/authentication_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '$url_supabase',
    anonKey: anonKey_supabase,
  );
  Bloc.observer = MyObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthenticationCubit()..getUserData(),
      ),
      BlocProvider(
        create: (context) => HomeCubit(),
      )
    ],
    child: MyApp(),
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
            scaffoldBackgroundColor: Color(0xfff4f4f4),
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
                              .userDataModel!) // ✅ No null issue
                      : const SignIn() // ✅ Redirect to login if user data is null
                  )
              : const SignIn(),
        );
      },
    );
  }
}
