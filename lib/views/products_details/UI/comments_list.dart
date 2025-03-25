import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/user_comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.productModel});

  final Products productModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => UserComment(
                        commentData: data?[index],
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        color: AppColors.lightBeige,
                      ),
                  itemCount: data?.length ?? 0),
            );
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
