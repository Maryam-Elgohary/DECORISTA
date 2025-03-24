import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

Widget buildUserEmail(UserDataModel? user) {
  return Text(
    user?.email ?? "email",
    style: const TextStyle(
      fontSize: 15,
      color: Color(0xffAB886D),
    ),
  );
}
