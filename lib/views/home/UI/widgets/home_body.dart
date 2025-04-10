import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/categories_list.dart';
import 'package:furniture_app/views/home/UI/widgets/custom_search_field.dart';
import 'package:furniture_app/views/home/UI/widgets/discount_banner.dart';
import 'package:furniture_app/views/home/UI/widgets/home_categories_see_all.dart';
import 'package:furniture_app/views/home/UI/widgets/home_circle_avatar_row.dart';
import 'package:furniture_app/views/home/UI/widgets/home_special_offers_text.dart';

class home_body extends StatelessWidget {
  const home_body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            home_circle_avatar_row(),
            const SizedBox(height: 10),
            CustomSearchField(),
            const SizedBox(height: 10),
            home_special_offers_text(),
            const SizedBox(
              height: 10,
            ),
            DiscountBanner(),
            const SizedBox(height: 5),
            home_categories_see_all(),
            //    const SizedBox(height: 5),
            CategoriesList(),
          ],
        ),
      ),
    );
  }
}
