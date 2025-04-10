import 'package:flutter/material.dart';

Widget buildQuantityButton({
  required IconData icon,
  required Color color,
  required Color iconColor,
  required VoidCallback onTap,
}) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: iconColor, size: 20),
        onPressed: onTap,
      ),
    ),
  );
}
