import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';
import 'package:furniture_app/views/home/UI/widgets/CategoryView.dart';
import 'package:furniture_app/views/home/UI/widgets/ErrorDisplay.dart';
import 'package:furniture_app/views/home/UI/widgets/NoCategoriesAvailable.dart';
import 'package:furniture_app/views/products_details/UI/comments_list_widgets/loading_indicator.dart';

class CategoriesContent extends StatefulWidget {
  const CategoriesContent();

  @override
  State<CategoriesContent> createState() => CategoriesContentState();
}

class CategoriesContentState extends State<CategoriesContent> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return switch (state) {
          CategoryLoading() => const LoadingIndicator(),
          CategoryError() => ErrorDisplay(message: state.message),
          CategoryLoaded() => CategoryView(
              categories: state.categories,
              selectedIndex: _selectedIndex,
              onCategorySelected: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          _ => const NoCategoriesAvailable(),
        };
      },
    );
  }
}
