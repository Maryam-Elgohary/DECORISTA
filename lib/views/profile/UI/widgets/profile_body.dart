import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_circle_avatar.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_email.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_list_content_class.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_listview.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_name.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class profile_body extends StatelessWidget {
  const profile_body(
      {super.key, required this.user, required this.profileListContent});

  final UserDataModel? user;
  final List<ProfileListContent> profileListContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profile_circle_avatar(user: user),
            const SizedBox(height: 15),
            profile_name(user: user),
            const SizedBox(height: 5),
            profile_email(user: user),
            const SizedBox(height: 10),
            Expanded(
              child: profile_listview(
                profileListContent: profileListContent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
