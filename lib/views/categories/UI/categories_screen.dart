import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/selected_category.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Categories"),
      body: BlocProvider(
        create: (context) => CategoryCubit()..fetchCategories(),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoryError) {
              return Center(child: Text(state.message));
            }
            if (state is CategoryLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network("${category['image_url']}",
                            width: 60, height: 80, fit: BoxFit.cover),
                      ),
                      title: Text(category['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 18, color: Colors.grey),
                      onTap: () {
                        naviagteTo(
                            context,
                            SelectedCategory(
                              title: category['name'],
                            ));
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("No Categories Available"));
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
