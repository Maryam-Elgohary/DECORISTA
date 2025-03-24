import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(
        authRepository: SupabaseAuthRepository(Supabase.instance.client),
      )..getUserData(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          navigateWithoutBack(context, const SignIn());
        }
      },
      builder: (context, state) {
        if (state is GetUserDataLoading) {
          return const CustomCircleProIndicator();
        }

        final user = context.read<AuthenticationCubit>().userDataModel;
        return ProfileScreen(user: user);
      },
    );
  }
}
