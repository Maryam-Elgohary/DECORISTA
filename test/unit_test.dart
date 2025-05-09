// unit_test.dart
// Unit tests for getRandomColor function, which generates a random Color.

import 'package:flutter_test/flutter_test.dart';
import 'package:furniture_app/core/functions/get_random_color.dart';

void main() {
  print('Starting getRandomColor tests'); // Debug: Confirm test execution

  group('getRandomColor Tests', () {
    setUp(() {
      print('Setting up test'); // Debug: Confirm setup
    });

    test('getRandomColor returns Color with alpha 100', () {
      print(
          'Running test: getRandomColor returns Color with alpha 100'); // Debug
      // Act: Call getRandomColor
      final color = getRandomColor();

      // Assert: Verify alpha channel
      expect(color.alpha, 100);
    });

    test('getRandomColor returns Color with valid RGB values', () {
      print(
          'Running test: getRandomColor returns Color with valid RGB values'); // Debug
      // Act: Call getRandomColor
      final color = getRandomColor();

      // Assert: Verify RGB values are in range 0–255
      expect(color.red, inInclusiveRange(0, 255));
      expect(color.green, inInclusiveRange(0, 255));
      expect(color.blue, inInclusiveRange(0, 255));
    });

    test('getRandomColor returns different colors on multiple calls', () {
      print('Running test: getRandomColor returns different colors'); // Debug
      // Act: Call getRandomColor twice
      final color1 = getRandomColor();
      final color2 = getRandomColor();

      // Assert: Verify colors are different (with high probability)
      expect(color1 != color2, true);
    });
  });
}
