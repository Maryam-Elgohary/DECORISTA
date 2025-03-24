import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/UI/widgets/build_appbar.dart';
import 'package:furniture_app/views/profile/UI/widgets/build_profile_options.dart';
import 'package:furniture_app/views/profile/UI/widgets/build_user_avatar.dart';
import 'package:furniture_app/views/profile/UI/widgets/build_user_email.dart';
import 'package:furniture_app/views/profile/UI/widgets/build_user_name.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserDataModel? user;

  const ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildProfileAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildUserAvatar(user),
              const SizedBox(height: 15),
              buildUserName(user),
              const SizedBox(height: 5),
              buildUserEmail(user),
              const SizedBox(height: 10),
              buildProfileOptions(context),
            ],
          ),
        ),
      ),
    );
  }
}
