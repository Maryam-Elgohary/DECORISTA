import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/views/special_offers/UI/special_offers_view.dart';

class DiscountBanner extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {
      "image": "assets/offers1.png",
      "discount": "25% Discount",
      "description": "For a cozy yellow set!",
      "buttonText": "Learn More"
    },
    {
      "image": "assets/offers2.png",
      "discount": "35% Discount",
      "description": "For a cozy yellow set!",
      "buttonText": "Shop Now"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(banner["image"]!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner["discount"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          banner["description"]!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkBrown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            if (index == 0) {
                              naviagteTo(context, SpecialOffers(discount: 25));
                            }
                            if (index == 1) {
                              naviagteTo(context, SpecialOffers(discount: 35));
                            }
                          },
                          child: Text(
                            banner["buttonText"]!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
