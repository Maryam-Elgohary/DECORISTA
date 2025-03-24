import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/home/UI/widgets/UserAvatar.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection();

  @override
  Widget build(BuildContext context) {
    final userInitial = context
            .read<AuthenticationCubit>()
            .userDataModel
            ?.firstName[0]
            .toString() ??
        '?';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Discover The Best\nFurniture.",
          style: TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        UserAvatar(initial: userInitial),
      ],
    );
  }
}
