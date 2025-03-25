import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class profile_name extends StatelessWidget {
  const profile_name({
    super.key,
    required this.user,
  });

  final UserDataModel? user;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${user?.firstName} ${user?.lastName}",
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.darkBrown),
    );
  }
}
