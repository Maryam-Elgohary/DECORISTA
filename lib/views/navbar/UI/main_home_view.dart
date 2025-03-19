import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/favorite/UI/favorite_view.dart';
import 'package:furniture_app/views/home/UI/home_view.dart';
import 'package:furniture_app/views/navbar/cubit/cubit/nav_bar_cubit.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: GNav(
                    onTabChange: (index) {
                      cubit.changeCurrentIndex(index);
                    },
                    rippleColor: AppColors
                        .darkBrown, // tab button ripple color when pressed
                    hoverColor: AppColors.darkBrown, // tab button hover color
                    //  curve: Curves.easeOutExpo, // tab animation curves
                    duration:
                        Duration(milliseconds: 400), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: AppColors.lightBrown, // unselected icon color
                    activeColor: Colors.white, // selected icon and text color
                    iconSize: 28, // tab button icon size
                    tabBackgroundColor:
                        AppColors.darkBrown, // selected tab background color
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // navigation bar padding
                    tabs: [
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: LineIcons.store,
                        text: 'Cart',
                      ),
                      GButton(
                        icon: LineIcons.heart,
                        text: 'Favorite',
                      ),
                      GButton(
                        icon: LineIcons.user,
                        text: 'Profile',
                      )
                    ]),
              ),
            ),
          );
        }));
  }
}
