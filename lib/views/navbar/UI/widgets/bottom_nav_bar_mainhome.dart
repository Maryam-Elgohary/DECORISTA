import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/navbar/cubit/cubit/nav_bar_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class bottom_nav_bar_mainhome extends StatelessWidget {
  const bottom_nav_bar_mainhome({
    super.key,
    required this.cubit,
  });

  final NavBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: GNav(
            onTabChange: (index) {
              cubit.changeCurrentIndex(index);
            },
            rippleColor:
                AppColors.darkBrown, // tab button ripple color when pressed
            hoverColor: AppColors.darkBrown, // tab button hover color
            //  curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 400), // tab animation duration
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
                icon: LineIcons.shoppingCart,
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
    );
  }
}
