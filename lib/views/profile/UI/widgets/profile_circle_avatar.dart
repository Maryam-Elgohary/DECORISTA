import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class profile_circle_avatar extends StatelessWidget {
  const profile_circle_avatar({super.key, required this.user});

  final UserDataModel? user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: getRandomColor(),
      radius: 50,
      child: Text(
        user?.firstName[0] != null ? user!.firstName[0] : " ",
        style: const TextStyle(fontSize: 50),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      100, // Alpha (fully opaque)
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }
}
