import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/auth_repository.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<String> textList = [
    "Settings",
    "Older History",
    "Privacy & Policy",
    "Terms & Conditions",
    "Log Out"
  ];
  List<Icon> IconList = [
    const Icon(
      Icons.settings,
      color: Color(0xff493628),
    ),
    const Icon(
      Icons.schedule,
      color: Color(0xffFD9F12),
    ),
    const Icon(
      Icons.lock_outline,
      color: Color(0xff008BD9),
    ),
    const Icon(
      Icons.report_gmailerrorred_outlined,
      color: Color(0xffFFCC47),
    ),
    const Icon(
      Icons.logout_outlined,
      color: Color(0xffF44545),
    )
  ];
  List<Color> iconColors = [
    const Color.fromRGBO(217, 217, 217, 0.1),
    const Color.fromRGBO(159, 18, 26, 0.1),
    const Color.fromRGBO(139, 217, 26, 0.1),
    const Color.fromRGBO(204, 71, 26, 0.1),
    const Color.fromRGBO(69, 69, 26, 0.1)
  ];
  @override
  Widget build(BuildContext context) {
    Color getRandomColor() {
      Random random = Random();
      return Color.fromARGB(
        100, // Alpha (fully opaque)
        random.nextInt(256), // Red
        random.nextInt(256), // Green
        random.nextInt(256), // Blue
      );
    }

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
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: getRandomColor(),
                            radius: 50,
                            child: Text(
                              user!.firstName[0],
                              style: const TextStyle(fontSize: 50),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "${user?.firstName} ${user?.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.darkBrown),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.email ?? "email",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xffAB886D),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: IconList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: iconColors[index],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconList[index],
                                  ),
                                  title: Text(
                                    "${textList[index]}",
                                    style: TextStyle(
                                        color: Color(0xffAB886D),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.darkBrown,
                                  ),
                                  onTap: () async {
                                    if (index == 4) {
                                      await context
                                          .read<AuthenticationCubit>()
                                          .signOut();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Screen"),
    );
  }
}

class OlderHistory extends StatelessWidget {
  const OlderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Older History Screen"),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Privacy & Policy Screen"),
    );
  }
}

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Terms & Conditions Screen"),
    );
  }
}
