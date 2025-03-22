import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:furniture_app/views/products/UI/comments_list.dart';
import 'package:furniture_app/views/products/logic/cubit/product_details_cubit.dart';
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
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('product_image_table')
        .select('image_url, color')
        .eq('product_id', widget.product.productId);

    if (response.isNotEmpty) {
      Map<Color, String> fetchedColorToImage = {};
      for (var item in response) {
        Color color = _hexToColor(item['color']); // Convert HEX to Color
        fetchedColorToImage[color] = item['image_url'];
      }

      setState(() {
        colorToImage = fetchedColorToImage;
        _selectedColor = colorToImage.keys.first; // Default to the first color
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
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
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
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                  child: Image.network(
                                    colorToImage[_selectedColor] ??
                                        widget.product.productImageTable[0]
                                            .imageUrl,
                                    fit: BoxFit.fill,
                                    width: imageWidth,
                                    height: imageHeight,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 20,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        pxToSp(context, 40)),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
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
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isFav = !_isFav;
                                      });

                                      if (_isFav) {
                                        homeCubit.addToFavorite(
                                            widget.product.productId!);
                                      } else {
                                        homeCubit.removeFavorite(
                                            widget.product.productId!);
                                      }
                                    },
                                    icon: Icon(
                                      _isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _isFav ? Colors.red : Colors.grey,
                                      size: iconSize,
                                    ),
                                  )),
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       if (isFavorite) {
                              //         homeCubit.removeFavorite(
                              //             widget.product.productId!);
                              //       } else {
                              //         homeCubit.addToFavorite(
                              //             widget.product.productId!);
                              //       }
                              //     },
                              //     child: Icon(
                              //       isFavorite
                              //           ? Icons.favorite
                              //           : Icons.favorite_border,
                              //       color:
                              //           isFavorite ? Colors.red : Colors.grey,
                              //       size: iconSize,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        "${widget.product.productName}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      "\$${widget.product.price.toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffF2A666),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffAB886D),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 25),
                                        SizedBox(width: 4),
                                        Text(
                                          "${cubit.averageRate}",
                                          style: GoogleFonts.poppins(
                                              color: AppColors.darkBrown,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Text(
                                    "${widget.product.description}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Color(0xffAB886D)),
                                  ),
                                ),
                                Center(
                                  child: RatingBar.builder(
                                    initialRating: cubit.userRate.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      cubit.addOrUpdateUserRate(
                                          productId: widget.product.productId!,
                                          data: {
                                            "rate": rating.toInt(),
                                            "user_id": cubit.userId,
                                            "product_id":
                                                widget.product.productId
                                          });
                                    },
                                  ),
                                ),
                                //   const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This field is required";
                                          }
                                          return null;
                                        },
                                        controller: _commentController,
                                        decoration: InputDecoration(
                                          fillColor: Color(0xfff4f4f4),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          filled: true,
                                          //hintText: "Add a review",
                                          labelText: "Add a review",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          //  minimumSize: Size(10, 55),
                                          backgroundColor: AppColors.darkBrown,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (_commentController.text.isEmpty) {
                                            // Show an error message or handle the empty fields case
                                            return;
                                          }
                                          await context
                                              .read<AuthenticationCubit>()
                                              .getUserData();
                                          await cubit.addComment(data: {
                                            "comment": _commentController.text,
                                            "user_id": cubit.userId,
                                            "product_id":
                                                widget.product.productId,
                                            "user_name":
                                                "${context.read<AuthenticationCubit>().userDataModel?.firstName} ${context.read<AuthenticationCubit>().userDataModel?.lastName}" ??
                                                    "User Name"
                                          });
                                        }

                                        _commentController.clear();
                                      },
                                      label: const Icon(
                                        Icons.send,
                                        size: 25,
                                      )),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Reviews",
                                  style: TextStyle(
                                      color: AppColors.darkBrown,
                                      fontWeight: FontWeight.w600,
                                      fontSize: pxToSp(context, 16))),
                            ),
                          ),
                          CommentsList(
                            productModel: widget.product,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                          ),
                        ],
                      ),
                    ),
              bottomSheet: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.22,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: decreaseQuantity,
                              icon: Icon(Icons.remove,
                                  color: AppColors.darkBrown),
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 219, 219, 221),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              quantity.toString().padLeft(2, '0'),
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                        ),
                        Text(
                          "Total: \$${(widget.product.price * quantity).toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: state is AddToCartLoading
                          ? null // Disable button while adding
                          : () {
                              final cartCubit = context.read<CartCubit>();

                              // Ensure quantity is updated correctly
                              final currentQuantity = quantity;

                              cartCubit.addToCart(
                                  widget.product.productId, currentQuantity);
                            },
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text(
                        "Add To Cart",
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBrown,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
