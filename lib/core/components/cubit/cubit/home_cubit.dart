import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/models/favorite_products.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final SupabaseClient supabase = Supabase.instance.client;
  final ApiServices _apiServices = ApiServices();
  final String? userId = Supabase.instance.client.auth.currentUser?.id;
  List<Products> products = [];
  List<Products> categoryProducts = [];
  int categoryProductsCount = 0;
  List<Products> searchResults = [];
  List<Products> specialOffersProducts = [];
  Future<void> getProducts(
      {String? query, String? category, int? discount}) async {
    products = [];
    searchResults = [];
    categoryProducts = [];
    favoriteProductList = [];
    specialOffersProducts = [];
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          "products_table?select=*,category_table(*),product_image_table(*),favorite_table(*),cart_table(*),special_offers_table(*)");
      log("API Response: ${response.data}");

      print("Products after mapping: $products");

      for (var product in response.data) {
        products.add(Products.fromJson(product));
      }

      log("Fetched products: ${products.length}");
      getProductsByCategory(category);
      getProductsByDiscount(discount);
      getFavoriteProducts();
      search(query);
      emit(GetDataSuccess(products));
    } catch (e) {
      log(e.toString());

      emit(GetDataError());
    }
  }

  void getProductsByDiscount(int? discount) {
    if (discount != null) {
      log("Filtering products for discount: $discount");

      for (var product in products) {
        // Ensure the specialOffersTable is not empty before accessing first
        if (product.specialOffersTable.isNotEmpty &&
            product.specialOffersTable.first.discount == discount) {
          specialOffersProducts.add(product);
        }
      }
    } else {
      log("No products for discount!");
    }
  }

  void getProductsByCategory(String? category) {
    if (category != null) {
      log("Filtering products for category: $category");

      for (var product in products) {
        log("Product category: ${product.categoryTable.categoryName}");

        // Ensure the names are case-insensitive and trimmed
        if (product.categoryTable.categoryName.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryProducts.add(product);
          categoryProductsCount++;
        }
      }
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};
  //add to favorite
  Future<void> addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_table", {
        "is_favorite": true,
        "customer_id": userId,
        "product_id": productId
      });
      await getProducts();
      favoriteProducts.addAll({productId: true});

      emit(AddToFavoriteSuccess());
      emit(FavoriteUpdated());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }

  //remove from favorite

  Future<void> removeFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
          "favorite_table?customer_id=eq.$userId&product_id=eq.$productId");
      await getProducts();
      favoriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveFromFavoriteSuccess());
      emit(FavoriteUpdated());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteError());
    }
  }

  //get favorite products
  List<Products> favoriteProductList = [];
  void getFavoriteProducts() {
    for (Products product in products) {
      if (product.favoriteTable != null && product.favoriteTable!.isNotEmpty) {
        for (FavoriteTable favoriteProduct in product.favoriteTable!) {
          if (favoriteProduct.customerId == userId) {
            favoriteProductList.add(product);
            favoriteProducts.addAll({product.productId: true});
          }
        }
      }
    }
  }
}
