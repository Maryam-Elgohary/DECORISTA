import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_list_content_class.dart';

class profile_listtile_leading extends StatelessWidget {
  const profile_listtile_leading(
      {super.key, required this.profileListContent, required this.index});

  final List<ProfileListContent> profileListContent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          color: profileListContent[index].containerColor,
          borderRadius: BorderRadius.circular(10)),
      child: profileListContent[index].icon,
    );
  }
}
