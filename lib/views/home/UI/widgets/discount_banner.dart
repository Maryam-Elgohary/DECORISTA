import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/BannerItem.dart';
import 'package:furniture_app/views/home/UI/widgets/banner_model_class.dart';
import 'package:furniture_app/views/home/UI/widgets/handleBannerTap.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _banners.length,
        itemBuilder: (context, index) {
          return BannerItem(
            banner: _banners[index],
            onPressed: () => handleBannerTap(context, index),
          );
        },
      ),
    );
  }

  static const List<BannerModel> _banners = [
    BannerModel(
      imagePath: "assets/offers1.png",
      discount: "25% Discount",
      description: "For a cozy yellow set!",
      buttonText: "Learn More",
    ),
    BannerModel(
      imagePath: "assets/offers2.png",
      discount: "35% Discount",
      description: "For a cozy yellow set!",
      buttonText: "Shop Now",
    ),
  ];
}
