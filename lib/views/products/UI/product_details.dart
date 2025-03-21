import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products/logic/cubit/product_details_cubit.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Products product;

  @override
  State<ProductDetails> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetails> {
  final List<Color> productColors = [
    Color(0xFFC4A484), // Light Brown
    Color(0xFF6B6462), // Grayish Brown
    Color(0xFF000000), // Black
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is AddOrUpdateRateSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();

          return Scaffold(
              body: state is GetRateLoading
                  //|| state is AddCommentLoading
                  ? const CustomCircleProIndicator()
                  : Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/RoyalChair.png', // Replace with your image path
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
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
                                    children: productColors.map((color) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: color,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
              // ListView(
              //     children: [
              //       Image.network(
              //           "${widget.product.productImageTable[0].imageUrl}"),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 10, vertical: 16),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   "${widget.product.productName}",
              //                   style: TextStyle(fontWeight: FontWeight.bold),
              //                 ),
              //                 Text("${widget.product.price} LE")
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 20,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Row(
              //                   children: [
              //                     Text("${cubit.averageRate} "),
              //                     Icon(Icons.star, color: Colors.amber)
              //                   ],
              //                 ),
              //                 Icon(
              //                   Icons.favorite,
              //                   color: Colors.grey,
              //                 )
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 30,
              //             ),
              //             Text("${widget.product.description}"),
              //             const SizedBox(
              //               height: 20,
              //             ),
              //             RatingBar.builder(
              //               initialRating: cubit.userRate.toDouble(),
              //               minRating: 1,
              //               direction: Axis.horizontal,
              //               allowHalfRating: false,
              //               itemCount: 5,
              //               itemPadding:
              //                   const EdgeInsets.symmetric(horizontal: 4.0),
              //               itemBuilder: (context, _) => const Icon(
              //                 Icons.star,
              //                 color: Colors.amber,
              //               ),
              //               onRatingUpdate: (rating) {
              //                 cubit.addOrUpdateUserRate(
              //                     productId: widget.product.productId!,
              //                     data: {
              //                       "rate": rating.toInt(),
              //                       "user_id": cubit.userId,
              //                       "product_id": widget.product.productId
              //                     });
              //               },
              //             ),
              //             const SizedBox(
              //               height: 40,
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              );
        },
      ),
    );
  }
}
