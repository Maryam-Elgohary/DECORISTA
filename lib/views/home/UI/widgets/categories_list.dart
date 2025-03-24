import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';
import 'package:furniture_app/views/home/UI/widgets/CategoriesContent.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..fetchCategories(),
      child: const CategoriesContent(),
    );
  }
}
