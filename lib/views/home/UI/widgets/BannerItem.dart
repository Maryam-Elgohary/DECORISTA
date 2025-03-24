import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/BannerContent.dart';
import 'package:furniture_app/views/home/UI/widgets/banner_model_class.dart';

class BannerItem extends StatelessWidget {
  final BannerModel banner;
  final VoidCallback onPressed;

  const BannerItem({
    required this.banner,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(banner.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: BannerContent(banner: banner, onPressed: onPressed),
      ),
    );
  }
}
