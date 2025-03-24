import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';

Widget buildGoogleButton(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: () => context.read<AuthenticationCubit>().googleSignIn(),
    icon: const FaIcon(
      FontAwesomeIcons.google,
      size: 25,
      color: Colors.red,
    ),
    label: const Padding(
      padding: EdgeInsets.only(left: 5),
      child: Text(
        "Continue With Google",
        style: TextStyle(
          fontSize: 20,
          color: AppColors.darkBrown,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xfff4f4f4),
      minimumSize: const Size(double.infinity, 50),
    ),
  );
}
