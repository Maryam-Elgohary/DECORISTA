import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/favorite/UI/favorite_view.dart';
import 'package:furniture_app/views/home/UI/home_view.dart';
import 'package:furniture_app/views/navbar/UI/widgets/bottom_nav_bar_mainhome.dart';
import 'package:furniture_app/views/navbar/cubit/cubit/nav_bar_cubit.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class MainHomeView extends StatelessWidget {
  MainHomeView({super.key, required this.userDataModel});
  final UserDataModel userDataModel;
  final List<Widget> views = [
    HomeView(),
    CartView(),
    FavoriteView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NavBarCubit(),
        child: BlocBuilder<NavBarCubit, NavBarState>(builder: (context, state) {
          NavBarCubit cubit = BlocProvider.of<NavBarCubit>(context);
          return Scaffold(
            body: SafeArea(child: views[cubit.currentIndex]),
            bottomNavigationBar: bottom_nav_bar_mainhome(cubit: cubit),
          );
        }));
  }
}
