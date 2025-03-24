import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

Widget buildUserAvatar(UserDataModel? user) {
  return CircleAvatar(
    backgroundColor: generatePastelColor(user?.email.hashCode ?? 0),
    radius: 50,
    child: Text(
      user?.firstName[0] ?? '?',
      style: const TextStyle(fontSize: 50),
    ),
  );
}

Color generatePastelColor(int seed) {
  final random = Random(seed);
  return Color.fromRGBO(
    150 + random.nextInt(106), // Pastel range (150-255)
    150 + random.nextInt(106),
    150 + random.nextInt(106),
    1.0,
  );
}
