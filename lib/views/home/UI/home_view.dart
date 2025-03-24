import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/categories/UI/categories_screen.dart';
import 'package:furniture_app/views/home/UI/widgets/categories_list.dart';
import 'package:furniture_app/views/home/UI/widgets/custom_search_field.dart';
import 'package:furniture_app/views/home/UI/widgets/discount_banner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {}); // Trigger a rebuild after returning
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getRandomColor() {
      Random random = Random();
      return Color.fromARGB(
        150, // Alpha (fully opaque)
        random.nextInt(256), // Red
        random.nextInt(256), // Green
        random.nextInt(256), // Blue
      );
    }

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF4F4F4),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                  const SizedBox(height: 10),
                  CustomSearchField(),
                  const SizedBox(height: 10),
                  Text("Special Offers",
                      style: TextStyle(
                          color: AppColors.darkBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: pxToSp(context, 16))),
                  const SizedBox(
                    height: 10,
                  ),
                  DiscountBanner(),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: AppColors.darkBrown,
                          fontSize: pxToSp(context, 20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          naviagteTo(context, CategoriesScreen());
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: AppColors.darkBrown,
                            fontSize: pxToSp(context, 16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  //    const SizedBox(height: 5),
                  CategoriesList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
