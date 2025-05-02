import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/add_to_cart_button.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_total_price.dart';
import 'package:furniture_app/views/products_details/UI/widgets/quantity_controls.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final ProductDetails widget;
  final int quantity;
  final ProductDetailsState state;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ProductDetailsBottomSheet({
    super.key,
    required this.widget,
    required this.quantity,
    required this.state,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuantityControls(
                quantity: widget.quantity,
                onIncrease: widget.onIncrease,
                onDecrease: widget.onDecrease,
              ),
              product_details_total_price(
                widget: widget.widget,
                quantity: widget.quantity,
              ),
            ],
          ),
          const SizedBox(height: 10),
          add_to_cart_button(
            widget: widget.widget,
            quantity: widget.quantity,
            state: widget.state,
          ),
        ],
      ),
    );
  }
}
