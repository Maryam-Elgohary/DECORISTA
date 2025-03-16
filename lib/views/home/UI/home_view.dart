import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/views/home/UI/widgets/categories_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover The Best\nFurniture.",
                    style: TextStyle(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: pxToSp(context, 20)),
                  ),
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset("assets/avatar.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(pxToSp(context, 100)),
                      borderSide: BorderSide.none),
                  fillColor: Color.fromRGBO(167, 167, 167, 0.20),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text("Special Offers",
              //     style: TextStyle(
              //         color: AppColors.darkBrown,
              //         fontWeight: FontWeight.w600,
              //         fontSize: pxToSp(context, 16))),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: pxToSp(context, 20),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: pxToSp(context, 16),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CategoriesList()
            ],
          ),
        ));
  }
}
