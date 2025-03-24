import 'dart:math';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String initial;

  const UserAvatar({required this.initial});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _generatePastelColor(initial.hashCode),
      radius: 30,
      child: Text(
        initial,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }

  Color _generatePastelColor(int seed) {
    final random = Random(seed);
    return Color.fromRGBO(
      150 + random.nextInt(106), // Pastel range (150-255)
      150 + random.nextInt(106),
      150 + random.nextInt(106),
      1.0,
    );
  }
}
