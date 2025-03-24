import 'package:flutter/material.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/home/UI/home_view.dart';
import 'package:furniture_app/views/profile/UI/profile_view.dart';

import '../../../favorite/UI/favorite_view.dart';

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const CartView();
    case 2:
      return const FavoriteView();
    case 3:
      return const ProfileView();
    default:
      return const HomeView();
  }
}
