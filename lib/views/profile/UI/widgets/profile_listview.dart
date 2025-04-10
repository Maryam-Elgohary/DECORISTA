import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_list_content_class.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_listtile_leading.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_listtile_title.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_listtile_trailing.dart';

class profile_listview extends StatelessWidget {
  const profile_listview({super.key, required this.profileListContent});

  final List<ProfileListContent> profileListContent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: profileListContent.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: profile_listtile_leading(
            profileListContent: profileListContent,
            index: index,
          ),
          title: profile_listtile_title(
              profileListContent: profileListContent, index: index),
          trailing: profile_listtile_trailing(),
          onTap: () async {
            if (index == 4) {
              await context.read<AuthenticationCubit>().signOut();
            }
          },
        );
      },
    );
  }
}
