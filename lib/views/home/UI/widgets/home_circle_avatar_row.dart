import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';

class home_circle_avatar_row extends StatelessWidget {
  const home_circle_avatar_row({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Discover The Best\nFurniture.",
          style: TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w600,
            fontSize: pxToSp(context, 20),
          ),
        ),
        CircleAvatar(
          backgroundColor: getRandomColor(),
          radius: 30,
          child: Text(
            "${context.read<AuthenticationCubit>().userDataModel?.firstName[0]}",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    150, // Alpha (fully opaque)
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
  );
}
