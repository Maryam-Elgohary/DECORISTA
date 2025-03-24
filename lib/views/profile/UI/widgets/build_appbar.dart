import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildProfileAppBar() {
  return AppBar(
    title: Text(
      "My Profile",
      style: GoogleFonts.poppins(
        color: AppColors.darkBrown,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );
}
