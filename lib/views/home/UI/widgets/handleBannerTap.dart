import 'package:flutter/material.dart';
import 'package:furniture_app/views/special_offers/UI/special_offers_view.dart';

void handleBannerTap(BuildContext context, int index) {
  final discount = index == 0 ? 25 : 35;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SpecialOffers(discount: discount),
    ),
  );
}
