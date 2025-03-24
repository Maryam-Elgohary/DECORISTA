import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';

void navigateToHome(BuildContext context) {
  naviagteTo(
    context,
    MainHomeView(
      userDataModel: context.read<AuthenticationCubit>().userDataModel!,
    ),
  );
}
