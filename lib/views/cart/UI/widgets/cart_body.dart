import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_Quantity_Button.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class cart_body extends StatelessWidget {
  const cart_body({
    super.key,
    required this.products,
    required this.cartCubit,
  });

  final List<Products> products;
  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                products.isEmpty
                    ? Center()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final item = products[index];
                          var currentQuantity = item.quantity ?? 1;

                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: item.productImageTable.isNotEmpty &&
                                            item.productImageTable.first
                                                    .imageUrl !=
                                                null
                                        ? Image.network(
                                            item.productImageTable.first
                                                .imageUrl,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 80,
                                            height: 80,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image,
                                                color: Colors.grey),
                                          ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkBrown,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${item.brand}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.specialOffersTable.isNotEmpty
                                              ? "\$${(item.price * ((100 - item.specialOffersTable.first.discount) / 100)) * item.quantity}"
                                              : "\$${item.price * item.quantity}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: AppColors.orangeColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final cartCubit =
                                              context.read<CartCubit>();
                                          await cartCubit
                                              .removeFromCart(item.productId);

                                          // showDialog(
                                          //   context: context,
                                          //   builder:
                                          //       (BuildContext context) {
                                          //     return AlertDialog(
                                          //       title: Text(
                                          //         'Delete Product',
                                          //         style: GoogleFonts
                                          //             .poppins(
                                          //           fontSize: 18,
                                          //           fontWeight:
                                          //               FontWeight.bold,
                                          //           color: AppColors
                                          //               .darkBrown,
                                          //         ),
                                          //       ),
                                          //       content: Text(
                                          //         'Are you sure you want to delete this product from the cart?',
                                          //         style: GoogleFonts
                                          //             .poppins(
                                          //           fontSize: 16,
                                          //           color: AppColors
                                          //               .darkBrown,
                                          //         ),
                                          //       ),
                                          //       actions: <Widget>[
                                          //         TextButton(
                                          //           onPressed: () {
                                          //             Navigator.of(
                                          //                     context)
                                          //                 .pop(); // Close the dialog
                                          //           },
                                          //           child: Text(
                                          //             'No',
                                          //             style: GoogleFonts
                                          //                 .poppins(
                                          //               fontSize: 16,
                                          //               color: AppColors
                                          //                   .darkBrown,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         TextButton(
                                          //           onPressed: state
                                          //                   is RemoveFromCartLoading
                                          //               ? null // Disable button while deleting
                                          //               : () async {
                                          //                   final cartCubit =
                                          //                       context.read<
                                          //                           CartCubit>();
                                          //                   await cartCubit
                                          //                       .removeFromCart(
                                          //                           item.productId);

                                          //                   Navigator.pop(
                                          //                       context);
                                          //                 },
                                          //           child: Text(
                                          //             'Yes',
                                          //             style: GoogleFonts
                                          //                 .poppins(
                                          //               fontSize: 16,
                                          //               color: AppColors
                                          //                   .darkBrown,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     );
                                          //   },
                                          // );
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.orangeColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                      ),
                                      Row(
                                        children: [
                                          buildQuantityButton(
                                            icon: Icons.remove,
                                            color: const Color(0xfff0f0f2),
                                            iconColor: const Color(0xff828A89),
                                            onTap: () {
                                              if (currentQuantity > 1) {
                                                currentQuantity--;
                                                cartCubit.updateQuantity(
                                                    item.productId,
                                                    currentQuantity);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "$currentQuantity",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          buildQuantityButton(
                                            icon: Icons.add,
                                            color: AppColors.darkBrown,
                                            iconColor: Colors.white,
                                            onTap: () {
                                              currentQuantity++;
                                              cartCubit.updateQuantity(
                                                  item.productId,
                                                  currentQuantity);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
          ),
        ),
        SizedBox(
            height: products.isNotEmpty
                ? MediaQuery.of(context).size.height * 0.35
                : 0)
      ],
    );
  }
}
