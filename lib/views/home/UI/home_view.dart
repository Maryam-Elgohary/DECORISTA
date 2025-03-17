import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/products_list.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/categories_screen.dart';
import 'package:furniture_app/views/home/UI/widgets/categories_list.dart';
import 'package:furniture_app/views/home/UI/widgets/discount_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(pxToSp(context, 100)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromRGBO(167, 167, 167, 0.20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
              const CategoriesList(),
              const SizedBox(height: 10),
              SizedBox(
                height: 500, // Adjust this height as needed
                child: ProductsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
