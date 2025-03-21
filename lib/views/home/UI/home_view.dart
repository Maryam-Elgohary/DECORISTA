import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
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
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/avatar.png"),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              CategoriesList(),
            ],
          ),
        ),
      ),
    );
  }
}
