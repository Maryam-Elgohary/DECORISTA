import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/comments_list_widgets/build_comments_list.dart';
import 'package:furniture_app/views/products_details/UI/comments_list_widgets/empty_review_message.dart';
import 'package:furniture_app/views/products_details/UI/comments_list_widgets/error_message.dart';
import 'package:furniture_app/views/products_details/UI/comments_list_widgets/loading_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.productModel,
  });

  final Products productModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _getReviewsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyReviewsMessage();
        }

        if (snapshot.hasError) {
          return const ErrorMessage();
        }

        return buildCommentsList(snapshot.data!);
      },
    );
  }

  Stream<List<Map<String, dynamic>>> _getReviewsStream() {
    return Supabase.instance.client
        .from("review_table")
        .stream(primaryKey: ['review_id'])
        .eq("product_id", productModel.productId!)
        .order("created_at");
  }
}
