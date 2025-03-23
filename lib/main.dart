import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/functions/my_observer.dart';
import 'package:furniture_app/core/functions/stripe_service.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/cubit/authentication_state.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:furniture_app/views/checkout/UI/payment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StripeService.init();
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
      ),
      BlocProvider(
        create: (context) => CartCubit(),
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
            home: PaymentScreen()
            // client.auth.currentUser != null
            //     ? state is GetUserDataLoading
            //         ? const Scaffold(
            //             body: Center(
            //               child: CustomCircleProIndicator(),
            //             ),
            //           )
            //         : (context.read<AuthenticationCubit>().userDataModel != null
            //             ? MainHomeView(
            //                 userDataModel: context
            //                     .read<AuthenticationCubit>()
            //                     .userDataModel!) // ✅ No null issue
            //             : const SignIn() // ✅ Redirect to login if user data is null
            //         )
            //     : const SignIn(),
            );
      },
    );
  }
}
