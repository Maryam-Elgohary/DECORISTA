import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();
  String userId = SupabaseManager().client.auth.currentUser!.id;

  List<Rate> rates = []; //rate ==> int
  int averageRate = 0;
  int userRate = 0;
  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      Response response = await _apiServices
          .getData("rating_table?select=*&product_id=eq.$productId");
      for (var rate in response.data) {
        rates.add(Rate.fromJson(rate));
      }
      _getAverageRate();
      _getUserRate();

      emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetRateError());
    }
  }

  void _getUserRate() {
    List<Rate> userRates = rates.where((Rate rate) {
      return rate.userId == userId;
    }).toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
    }
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      log(userRate.rate.toString());
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length;
    }
  }

  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if ((rate.userId == userId) && (rate.productId == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateUserRate(
      {required String productId, required Map<String, dynamic> data}) async {
    //user rate exists ==> update for user rate
    //user doesn't exist ==> add rate
    String path =
        "rating_table?select=*&user_id=eq.$userId&product_id=eq.$productId";
    emit(AddOrUpdateRateLoading());
    try {
      if (_isUserRateExist(productId: productId)) {
        //patch rate
        await _apiServices.patchData(path, data);
      } else {
        //post rate
        await _apiServices.postData(path, data);
      }
      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddOrUpdateRateError());
    }
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    await _apiServices.postData("review_table", data);
    emit(AddCommentSuccess());
    try {} catch (e) {
      log(e.toString());
      emit(AddCommentError());
    }
  }
}
