import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class profile_email extends StatelessWidget {
  const profile_email({
    super.key,
    required this.user,
  });

  final UserDataModel? user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user?.email ?? "email",
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xffAB886D),
      ),
    );
  }
}
