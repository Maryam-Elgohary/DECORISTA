import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
