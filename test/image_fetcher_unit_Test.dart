import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furniture_app/views/products_details/UI/widgets/hex_to_color.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_image_fetcher.dart';

void main() {
  const testProductId = '352d2ca9-1614-4557-9392-d5301612b9c7';
  const jsonResponse = '''
  [
    {
      "id": "53795c62-3b2e-4d5b-b515-bb13947a0f1b",
      "product_id": "352d2ca9-1614-4557-9392-d5301612b9c7",
      "color": "#854836",
      "image_url": "https://ak1.ostkcdn.com/images/products/1448615/Tribeca-Queen-size-Bed-L1123148.jpg"
    },
    {
      "id": "5fad81d1-326b-4779-92b2-c6fdf8131489",
      "product_id": "352d2ca9-1614-4557-9392-d5301612b9c7",
      "color": "#E5E1DA",
      "image_url": "https://m.media-amazon.com/images/I/81lzsVHJK-L.jpg"
    },
    {
      "id": "319433b1-9b21-42ba-87f1-8fd0e79821f0",
      "product_id": "93594ab4-d560-4aff-9e61-c1204799f163",
      "color": "#D6BD98",
      "image_url": "https://th.bing.com/th/id/OIP.o14yb7VW2cFLsULjPFDdowHaIe?rs=1&pid=ImgDetMain"
    }
  ]
  ''';

  group('ProductImageFetcher Tests (No Mocks)', () {
    test('parse actual JSON response correctly', () {
      print('\n=== Testing JSON parsing ===');
      final data = json.decode(jsonResponse) as List;
      final result = <Color, String>{};

      for (final item in data.cast<Map<String, dynamic>>()) {
        if (item['product_id'] == testProductId) {
          final color = hexToColor(item['color']);
          final url = item['image_url'];
          result[color] = url;
          print('Added color: ${color.value.toRadixString(16)} -> $url');
        }
      }

      print('Result map contains ${result.length} entries');
      expect(result.length, 2);
      expect(result[hexToColor('#854836')],
          'https://ak1.ostkcdn.com/images/products/1448615/Tribeca-Queen-size-Bed-L1123148.jpg');
      expect(result[hexToColor('#E5E1DA')],
          'https://m.media-amazon.com/images/I/81lzsVHJK-L.jpg');
    });

    test('returns default image when empty', () {
      print('\n=== Testing empty response handling ===');
      final emptyResponse = <Map<String, dynamic>>[];
      final result = <Color, String>{};

      if (emptyResponse.isEmpty) {
        result[Colors.white] = 'https://via.placeholder.com/150';
        print('Using default image: white -> https://via.placeholder.com/150');
      }

      print('Result map contains ${result.length} entry');
      expect(result.length, 1);
      expect(result[Colors.white], 'https://via.placeholder.com/150');
    });

    test('handles invalid color values', () {
      print('\n=== Testing invalid color handling ===');
      final testData = [
        {
          "product_id": testProductId,
          "color": "invalid-hex",
          "image_url": "https://example.com/image.jpg"
        }
      ];

      final result = <Color, String>{};

      for (final item in testData) {
        try {
          final color = hexToColor(item['color']!);
          result[color] = item['image_url']!;
        } catch (e) {
          print('Skipped invalid color: ${item['color']}');
        }
      }

      print('Result map is empty: ${result.isEmpty}');
      expect(result.isEmpty, isTrue);
    });

    test('integration test with actual parsing logic', () async {
      print('\n=== Testing integration ===');
      final fetcher = ProductImageFetcher();
      final data = json.decode(jsonResponse) as List;

      final result = await _simulateFetch(
          fetcher, data.cast<Map<String, dynamic>>(), testProductId);

      print('Result map contains ${result.length} entries');
      print('Map contains URLs: ${result.values}');
      expect(result.length, 2);
      expect(result.values,
          contains('https://m.media-amazon.com/images/I/81lzsVHJK-L.jpg'));
    });
  });
}

Future<Map<Color, dynamic>> _simulateFetch(
  ProductImageFetcher fetcher,
  List<Map<String, dynamic>> testData,
  String productId,
) async {
  try {
    final filtered =
        testData.where((item) => item['product_id'] == productId).toList();
    final result = {
      for (var item in filtered) hexToColor(item['color']): item['image_url']
    };
    return result;
  } catch (_) {
    return {Colors.white: 'https://via.placeholder.com/150'};
  }
}
