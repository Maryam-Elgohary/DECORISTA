import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class BackToHomeButton extends StatelessWidget {
  final UserDataModel? userDataModel;

  const BackToHomeButton({required this.userDataModel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToHome(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.darkBrown,
        minimumSize: const Size(327, 56),
      ),
      child: const Text(
        "Back To Home",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    if (userDataModel != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainHomeView(userDataModel: userDataModel!),
        ),
      );
    }
  }
}
