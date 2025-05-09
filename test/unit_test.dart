import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late CategoryCubit categoryCubit;
  late MockApiServices mockApiServices;

  // Sample response data matching your actual API response
  final mockResponse = [
    {
      "category_id": "0ef36617-ffa2-48ab-a153-b80b1582f47c",
      "category_name": "Wardrobes",
      "image_url":
          "https://th.bing.com/th/id/R.ee111f39375320f6994268f191702d42?rik=2EafdRQ2cmKw4A&pid=ImgRaw&r=0"
    },
    {
      "category_id": "fd1fa098-0a07-40f3-b9bb-7879a36d93cb",
      "category_name": "Beds",
      "image_url":
          "https://th.bing.com/th/id/OIP.Ubf0h1WThVwKoDaJQHfUkQHaHa?rs=1&pid=ImgDetMain"
    },
  ];

  // Expected transformed data
  final expectedCategories = [
    {
      "id": "0ef36617-ffa2-48ab-a153-b80b1582f47c",
      "name": "Wardrobes",
      "image_url":
          "https://th.bing.com/th/id/R.ee111f39375320f6994268f191702d42?rik=2EafdRQ2cmKw4A&pid=ImgRaw&r=0"
    },
    {
      "id": "fd1fa098-0a07-40f3-b9bb-7879a36d93cb",
      "name": "Beds",
      "image_url":
          "https://th.bing.com/th/id/OIP.Ubf0h1WThVwKoDaJQHfUkQHaHa?rs=1&pid=ImgDetMain"
    },
  ];

  setUp(() {
    mockApiServices = MockApiServices();
    categoryCubit = CategoryCubit()..apiServices = mockApiServices;

    // Print setup completion
    print('✓ Test setup completed - Mock services initialized');
  });

  tearDown(() {
    categoryCubit.close();
    print('✓ Test cleaned up - Cubit closed');
  });

  group('CategoryCubit Test Group', () {
    test('Initial state verification', () {
      // Act - Nothing to do, just check initial state

      // Assert
      expect(categoryCubit.state, isA<CategoryInitial>());

      // Verification output
      print('✓ Verified: Initial state is CategoryInitial');
      print('  → Actual state: ${categoryCubit.state.runtimeType}');
    });

    blocTest<CategoryCubit, CategoryState>(
      'Successful API call test',
      build: () {
        // Arrange - Setup mock response
        when(() => mockApiServices.getData("category_table?select=*"))
            .thenAnswer((_) async => Response(
                  data: mockResponse,
                  requestOptions:
                      RequestOptions(path: 'category_table?select=*'),
                ));

        print('✓ Mock API configured to return success response');
        return categoryCubit;
      },
      act: (cubit) {
        print('▶ Triggering fetchCategories()');
        return cubit.fetchCategories();
      },
      expect: () => [
        isA<CategoryLoading>(),
        isA<CategoryLoaded>().having(
          (s) => s.categories,
          'categories',
          expectedCategories,
        ),
      ],
      verify: (_) {
        verify(() => mockApiServices.getData("category_table?select=*"))
            .called(1);
        print('✓ Verified: API was called exactly once');
      },
    );

    blocTest<CategoryCubit, CategoryState>(
      'Failed API call test',
      build: () {
        // Arrange - Setup mock to throw error
        when(() => mockApiServices.getData("category_table?select=*"))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: 'category_table?select=*'),
        ));

        print('✓ Mock API configured to throw DioException');
        return categoryCubit;
      },
      act: (cubit) {
        print('▶ Triggering fetchCategories() (expected to fail)');
        return cubit.fetchCategories();
      },
      expect: () => [
        isA<CategoryLoading>(),
        isA<CategoryError>(),
      ],
      verify: (_) {
        print('✓ Verified: Error state emitted after API failure');
      },
    );
  });
}
