import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_list_content_class.dart';

class profile_listtile_title extends StatelessWidget {
  const profile_listtile_title(
      {super.key, required this.profileListContent, required this.index});

  final List<ProfileListContent> profileListContent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${profileListContent[index].text}",
      style: TextStyle(
          color: Color(0xffAB886D), fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}
