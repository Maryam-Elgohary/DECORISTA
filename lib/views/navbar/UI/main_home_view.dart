import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/navbar/UI/widgets/MainHomeViewContent.dart';
import 'package:furniture_app/views/navbar/cubit/cubit/nav_bar_cubit.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class MainHomeView extends StatelessWidget {
  final UserDataModel userDataModel;

  const MainHomeView({
    super.key,
    required this.userDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: const MainHomeViewContent(),
    );
  }
}
