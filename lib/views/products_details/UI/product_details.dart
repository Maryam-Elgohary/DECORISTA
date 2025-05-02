import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_view.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_image_fetcher.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

/// A screen that displays detailed information about a product
class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
    required this.isFav,
  });

  final Products product;
  final bool isFav;

  @override
  State<ProductDetails> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetails> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  late bool _isFavorite;
  Map<Color, String> _colorToImage = {};
  Color? _selectedColor;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFav;
    _fetchProductImages();
  }

  /// Fetches product images and initializes color selection
  Future<void> _fetchProductImages() async {
    final images = await ProductImageFetcher()
        .fetchProductImages(widget.product.productId);
    setState(() {
      _colorToImage = images;
      _selectedColor = images.keys.firstOrNull;
    });
  }

  /// Increments the product quantity
  void _incrementQuantity() => setState(() => _quantity++);

  /// Decrements the product quantity if greater than 1
  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId),
      child: ProductDetailsView(
        product: widget.product,
        formKey: _formKey,
        commentController: _commentController,
        colorToImage: _colorToImage,
        selectedColor: _selectedColor,
        quantity: _quantity,
        onIncrement: _incrementQuantity,
        onDecrement: _decrementQuantity,
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
