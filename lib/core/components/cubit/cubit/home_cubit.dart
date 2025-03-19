import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices _apiServices = ApiServices();

  List<Products> products = [];
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          "products_table?select=*,category_table(*),product_image_table(*),favorite_table(*)");
      for (var product in response.data) {
        products.add(Products.fromJson(product));
      }
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }
}
