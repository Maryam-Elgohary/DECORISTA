import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/categories/UI/widgets/EmptyState.dart';
import 'package:furniture_app/views/categories/UI/widgets/ErrorState.dart';
import 'package:furniture_app/views/categories/UI/widgets/LoadedState.dart';
import 'package:furniture_app/views/categories/UI/widgets/LoadingState.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return switch (state) {
            CategoryLoading() => const LoadingState(),
            CategoryError() => ErrorState(message: state.message),
            CategoryLoaded() => LoadedState(categories: state.categories),
            _ => const EmptyState(),
          };
        },
      ),
    );
  }
}
