import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  final ApiServices _apiServices = ApiServices();
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      Response response = await _apiServices.getData("category_table?select=*");

      List<Map<String, dynamic>> categories =
          (response.data as List).map((item) {
        return {
          "id": item["category_id"],
          "name": item["category_name"],
          "image_url": item["image_url"] ?? "", // Handle null case
        };
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Failed to load categories"));
    }
  }
}
