import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/products_details/UI/comments_list.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/bottom_action_section.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/comment_input_section.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/product_image_section.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/product_info_section.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/rating_section.dart';
import 'package:furniture_app/views/products_details/UI/product_details_widgets.dart/review_title_section.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_state.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/product_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
    required this.isFav,
  });

  final Products product;
  final bool isFav;

  @override
  State<ProductDetails> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  late bool _isFav;
  Map<Color, String> colorToImage = {};
  Color? _selectedColor;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _isFav = widget.isFav;
    _fetchProductImages();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _fetchProductImages() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('product_image_table')
          .select('image_url, color')
          .eq('product_id', widget.product.productId);

      if (response.isNotEmpty) {
        final fetchedColorToImage = <Color, String>{};
        for (final item in response) {
          try {
            final color = _hexToColor(item['color'] ?? '#FFFFFF');
            fetchedColorToImage[color] = item['image_url'] ?? '';
          } catch (e) {
            debugPrint('Error parsing color: $e');
          }
        }

        setState(() {
          colorToImage = fetchedColorToImage;
          _selectedColor = colorToImage.keys.firstOrNull ?? Colors.white;
        });
      }
    } catch (e) {
      setState(() {
        colorToImage = {Colors.white: 'https://via.placeholder.com/150'};
        _selectedColor = Colors.white;
      });
    }
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  void _increaseQuantity() => setState(() => quantity++);

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  void _toggleFavorite() {
    setState(() => _isFav = !_isFav);
    final homeCubit = context.read<HomeCubit>();
    _isFav
        ? homeCubit.addToFavorite(widget.product.productId!)
        : homeCubit.removeFavorite(widget.product.productId!);
  }

  Future<void> _submitComment(ProductDetailsCubit cubit) async {
    if (!_formKey.currentState!.validate()) return;
    if (_commentController.text.isEmpty) return;

    await context.read<AuthenticationCubit>().getUserData();
    final user = context.read<AuthenticationCubit>().userDataModel;

    await cubit.submitComment({
      'comment': _commentController.text,
      'user_id': cubit.userId,
      'product_id': widget.product.productId,
      'user_name': '${user?.firstName} ${user?.lastName}' ?? 'User Name',
    });

    _commentController.clear();
  }

  void _addToCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.checkIsInCart(widget.product.productId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product is already in the cart!')),
      );
    } else {
      cartCubit.addToCart(widget.product.productId, quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.08;

    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        repository: SupabaseProductRepository(
          ApiServices(),
          Supabase.instance.client.auth.currentUser!.id,
        ),
      )..loadRates(widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is CommentSubmissionSuccess || state is RateUpdateSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoading ||
              state is CommentSubmissionInProgress) {
            return const Scaffold(body: CustomCircleProIndicator());
          }

          final cubit = context.read<ProductDetailsCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Product Image Section
                  ProductImageSection(
                    product: widget.product,
                    colorToImage: colorToImage,
                    selectedColor: _selectedColor,
                    isFav: _isFav,
                    iconSize: iconSize,
                    onColorChanged: (color) =>
                        setState(() => _selectedColor = color),
                    onFavoritePressed: _toggleFavorite,
                  ),

                  // Product Details Section
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ProductInfoSection(product: widget.product),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            buildWhen: (previous, current) =>
                                current is RatesLoaded ||
                                current is RateUpdateSuccess,
                            builder: (context, state) {
                              if (state is RatesLoaded ||
                                  state is RateUpdateSuccess) {
                                final cubit =
                                    context.read<ProductDetailsCubit>();
                                final currentState = cubit.state;

                                return RatingSection(
                                  averageRate: currentState is RatesLoaded
                                      ? currentState.averageRate.toDouble()
                                      : 0.0,
                                  userRate: currentState is RatesLoaded
                                      ? currentState.userRate
                                      : 0,
                                  onRatingUpdate: (rating) =>
                                      cubit.submitRating(
                                    productId: widget.product.productId!,
                                    rating: rating.toInt(),
                                  ),
                                );
                              }
                              return RatingSection(
                                averageRate: 0.0,
                                userRate: 0,
                                onRatingUpdate:
                                    (_) {}, // Empty callback while loading
                              );
                            },
                          ),
                          CommentInputSection(
                            formKey: _formKey,
                            controller: _commentController,
                            onSendPressed: () => _submitComment(cubit),
                          ),
                          const ReviewsTitleSection(),
                          CommentsList(productModel: widget.product),
                          SizedBox(height: screenSize.height * 0.22),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: BottomActionSection(
              product: widget.product,
              quantity: quantity,
              onDecrease: _decreaseQuantity,
              onIncrease: _increaseQuantity,
              onAddToCart: () => _addToCart(context),
              isLoading: state is AddToCartLoading,
            ),
          );
        },
      ),
    );
  }
}
