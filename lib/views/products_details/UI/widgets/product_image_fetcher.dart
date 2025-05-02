// Product Image Fetcher
import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/products_details/UI/widgets/hex_to_color.dart';

class ProductImageFetcher {
  Future<Map<Color, String>> fetchProductImages(String productId) async {
    try {
      final supabase = SupabaseManager().client;
      final response = await supabase
          .from('product_image_table')
          .select('image_url, color')
          .eq('product_id', productId);

      if (response.isNotEmpty) {
        Map<Color, String> fetchedColorToImage = {};
        for (var item in response) {
          try {
            final color = hexToColor(item['color'] ?? '#FFFFFF');
            fetchedColorToImage[color] = item['image_url'] ?? '';
          } catch (_) {}
        }
        return fetchedColorToImage;
      }
    } catch (_) {}
    return {Colors.white: 'https://via.placeholder.com/150'};
  }
}
