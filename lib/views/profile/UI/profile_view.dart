import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/cubit/authentication_state.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..getUserData(),
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
              : Center(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(24),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 55,
                                backgroundColor: AppColors.darkBrown,
                                // foregroundColor: AppColors.kWhiteColor,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${user?.firstName} ${user?.lastName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(user?.email ?? "email"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () async {
                                    await context
                                        .read<AuthenticationCubit>()
                                        .signOut();
                                  },
                                  child: Text("Log out"))
                            ],
                          )),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
