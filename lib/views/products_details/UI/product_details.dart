import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/comments_list.dart';
import 'package:furniture_app/views/products_details/UI/widgets/add_to_cart_button.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_arrow_back.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_comments_part.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_image.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_reviews_text.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_total_price.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_under_image.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product, required this.isFav});
  final Products product;
  final bool isFav;
  @override
  State<ProductDetails> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isFav;

  Map<Color, String> colorToImage = {}; // Stores color and corresponding image
  Color? _selectedColor; // Stores the selected color
  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _isFav = widget.isFav;
    fetchProductImages();
  }

  Future<void> fetchProductImages() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('product_image_table')
          .select('image_url, color')
          .eq('product_id', widget.product.productId);

      if (response.isNotEmpty) {
        Map<Color, String> fetchedColorToImage = {};
        for (var item in response) {
          try {
            Color color =
                _hexToColor(item['color'] ?? '#FFFFFF'); // Default white
            fetchedColorToImage[color] = item['image_url'] ?? '';
          } catch (e) {
            // Handle individual item errors
          }
        }

        setState(() {
          colorToImage = fetchedColorToImage;
          _selectedColor = colorToImage.keys.firstOrNull ?? Colors.white;
        });
      }
    } catch (e) {
      // Handle fetch error
      setState(() {
        colorToImage = {Colors.white: 'https://via.placeholder.com/150'};
        _selectedColor = Colors.white;
      });
    }
  }

  // Convert HEX string (e.g. "#C4A484") to Color
  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("0xFF$hex"));
  }

  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double iconSize = screenWidth * 0.08;
    double imageWidth = screenWidth; // Full screen width
    double imageHeight = screenHeight * 0.5248; // 69.45% of screen height
    HomeCubit homeCubit = context.watch<HomeCubit>(); // Access HomeCubit

    //  bool isFavorite = homeCubit.checkIsFavorite(widget.product.productId!);

    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is AddOrUpdateRateSuccess || state is AddCommentSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: state is GetRateLoading || state is AddCommentLoading
                  ? const CustomCircleProIndicator()
                  : product_details_body(imageWidth, imageHeight, context,
                      homeCubit, iconSize, cubit),
              bottomSheet: product_details_bottom_sheet(context, state),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView product_details_body(
      double imageWidth,
      double imageHeight,
      BuildContext context,
      HomeCubit homeCubit,
      double iconSize,
      ProductDetailsCubit cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          product_details_stack(
              imageWidth, imageHeight, context, homeCubit, iconSize),
          product_details_under_image(widget: widget, cubit: cubit),
          product_details_comments_part(
              formKey: _formKey,
              commentController: _commentController,
              cubit: cubit,
              widget: widget),
          const SizedBox(height: 10),
          product_details_reviews_text(),
          CommentsList(
            productModel: widget.product,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
          ),
        ],
      ),
    );
  }

  Stack product_details_stack(double imageWidth, double imageHeight,
      BuildContext context, HomeCubit homeCubit, double iconSize) {
    return Stack(
      children: [
        product_details_image(
            colorToImage: colorToImage,
            selectedColor: _selectedColor,
            widget: widget,
            imageWidth: imageWidth,
            imageHeight: imageHeight),
        product_details_arrow_back(),
        stack_positioned(context),
        stack_fav_align(homeCubit, iconSize),
      ],
    );
  }

  Align stack_fav_align(HomeCubit homeCubit, double iconSize) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            setState(() {
              _isFav = !_isFav;
            });

            if (_isFav) {
              homeCubit.addToFavorite(widget.product.productId!);
            } else {
              homeCubit.removeFavorite(widget.product.productId!);
            }
          },
          icon: Icon(
            _isFav ? Icons.favorite : Icons.favorite_border,
            color: _isFav ? Colors.red : Colors.grey,
            size: iconSize,
          ),
        ));
  }

  Positioned stack_positioned(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 20,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(pxToSp(context, 40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: colorToImage.keys.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == color
                            ? Color(0xff9C9C9C)
                            : Color(0xfff0f0f0),
                        width: 4,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Container product_details_bottom_sheet(
      BuildContext context, ProductDetailsState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product_details_quantity_controls(),
              product_details_total_price(widget: widget, quantity: quantity),
            ],
          ),
          const SizedBox(height: 10),
          add_to_cart_button(
            widget: widget,
            quantity: quantity,
            state: state,
          ),
        ],
      ),
    );
  }

  Row product_details_quantity_controls() {
    return Row(
      children: [
        IconButton(
          onPressed: decreaseQuantity,
          icon: Icon(Icons.remove, color: AppColors.darkBrown),
          style: IconButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 219, 219, 221),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          quantity.toString().padLeft(2, '0'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: increaseQuantity,
          icon: Icon(Icons.add, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.darkBrown,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
