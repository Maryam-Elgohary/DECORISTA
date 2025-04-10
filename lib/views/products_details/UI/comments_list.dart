import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/widgets/comments_list_listview.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.productModel});

  final Products productModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: SupabaseManager()
            .client
            .from("review_table")
            .stream(primaryKey: ['review_id'])
            .eq("product_id", productModel.productId!)
            .order("created_at"),
        builder: (_, snapshot) {
          List<Map<String, dynamic>>? data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CustomCircleProIndicator(),
            );
          } else if (snapshot.hasData) {
            return comments_list_listview(data: data);
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Reviews Yet"),
            );
          } else {
            return Center(
              child: Text("Something went wrong, please try again."),
            );
          }
        });
  }
}
