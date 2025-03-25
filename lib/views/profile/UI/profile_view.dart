import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_body.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_list_content_class.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<ProfileListContent> profileListContent = [
    ProfileListContent(
      text: "Settings",
      icon: const Icon(
        Icons.settings,
        color: Color(0xff493628),
      ),
      containerColor: const Color.fromRGBO(217, 217, 217, 0.1),
    ),
    ProfileListContent(
      text: "Older History",
      icon: const Icon(
        Icons.schedule,
        color: Color(0xffFD9F12),
      ),
      containerColor: const Color.fromRGBO(159, 18, 26, 0.1),
    ),
    ProfileListContent(
      text: "Privacy & Policy",
      icon: const Icon(
        Icons.lock_outline,
        color: Color(0xff008BD9),
      ),
      containerColor: const Color.fromRGBO(139, 217, 26, 0.1),
    ),
    ProfileListContent(
      text: "Terms & Conditions",
      icon: const Icon(
        Icons.report_gmailerrorred_outlined,
        color: Color(0xffFFCC47),
      ),
      containerColor: const Color.fromRGBO(204, 71, 26, 0.1),
    ),
    ProfileListContent(
        text: "Log Out",
        icon: const Icon(
          Icons.logout_outlined,
          color: Color(0xffF44545),
        ),
        containerColor: const Color.fromRGBO(69, 69, 26, 0.1))
  ];

  @override
  Widget build(BuildContext context) {
    final authRepository = SupabaseAuthRepository(Supabase.instance.client);
    return BlocProvider(
      create: (context) =>
          AuthenticationCubit(authRepository: authRepository)..getUserData(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            navigateWithoutBack(context, const SignIn());
          }
        },
        builder: (context, state) {
          UserDataModel? user =
              context.read<AuthenticationCubit>().userDataModel;
          return state is GetUserDataLoading
              ? const CustomCircleProIndicator()
              : Scaffold(
                  backgroundColor: const Color(0xffffffff),
                  appBar: AppBar(
                    title: Text(
                      "My Profile",
                      style: GoogleFonts.poppins(
                          color: AppColors.darkBrown,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                  ),
                  body: profile_body(
                    user: user,
                    profileListContent: profileListContent,
                  ),
                );
        },
      ),
    );
  }
}
