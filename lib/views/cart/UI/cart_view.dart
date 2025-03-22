import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_state.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double shippingCost = 50;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: BlocConsumer<CartCubit, CartState>(
        builder: (context, state) {
          CartCubit cartCubit = context.read<CartCubit>();
          List<Products> products = cartCubit.cartProducts ?? [];
// Calculate subtotal
          double subtotal = products.fold(0.0, (sum, item) {
            // Check if specialOffersTable is not null and has at least one element
            if (item.specialOffersTable != null &&
                item.specialOffersTable.isNotEmpty) {
              // Apply discount if available
              return sum +
                  (item.price *
                      ((100 - item.specialOffersTable.first.discount) / 100) *
                      (item.quantity ?? 1));
            } else {
              // If no discount, just add the price
              return sum + item.price * (item.quantity ?? 1);
            }
          });

          // if (state is GetCartLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }

          return Scaffold(
            backgroundColor: const Color(0xfff4f4f4),
            appBar: AppBar(
              foregroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Shopping",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: AppColors.darkBrown,
                      fontWeight: FontWeight.w500)),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.darkBrown,
                  )),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Product',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to delete this product from the cart?',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                'No',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: state is RemoveFromCartLoading
                                  ? null // Disable button while adding
                                  : () {
                                      final cartCubit =
                                          context.read<CartCubit>();

                                      cartCubit.removeAllFromCart();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                              child: Text(
                                'Yes',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.darkBrown,
                  ),
                )
              ],
            ),
            body: Column(
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
                                  var currentQuantity = item.quantity;

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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: item.productImageTable
                                                        .isNotEmpty &&
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
                                                    child: const Icon(
                                                        Icons.image,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "${item.brand}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: Colors.grey[600]),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item.specialOffersTable
                                                          .isNotEmpty
                                                      ? "\$${(item.price * ((100 - item.specialOffersTable.first.discount) / 100)) * item.quantity}"
                                                      : "\$${item.price * item.quantity}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColors
                                                          .orangeColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Delete Product',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .darkBrown,
                                                          ),
                                                        ),
                                                        content: Text(
                                                          'Are you sure you want to delete this product from the cart?',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .darkBrown,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: Text(
                                                              'No',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .darkBrown,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: state
                                                                    is RemoveFromCartLoading
                                                                ? null // Disable button while adding
                                                                : () {
                                                                    final cartCubit =
                                                                        context.read<
                                                                            CartCubit>();

                                                                    cartCubit
                                                                        .removeFromCart(
                                                                            item.productId);

                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                            child: Text(
                                                              'Yes',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .darkBrown,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColors.orangeColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                              ),
                                              Row(
                                                children: [
                                                  _buildQuantityButton(
                                                      icon: Icons.remove,
                                                      color: const Color(
                                                          0xfff0f0f2),
                                                      iconColor: const Color(
                                                          0xff828A89),
                                                      onTap: () {
                                                        setState(() {
                                                          if (currentQuantity >
                                                              1) {
                                                            currentQuantity--;
                                                          }
                                                        });
                                                        context
                                                            .read<CartCubit>()
                                                            .updateQuantity(
                                                                item.productId,
                                                                currentQuantity);
                                                      }),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    //   "${item.cartItem.isNotEmpty ? item.cartItem.first.quantity ?? 1 : 1}",
                                                    "${currentQuantity}",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  _buildQuantityButton(
                                                      icon: Icons.add,
                                                      color:
                                                          AppColors.darkBrown,
                                                      iconColor: Colors.white,
                                                      onTap: () {
                                                        setState(() {
                                                          currentQuantity++;
                                                        });
                                                        context
                                                            .read<CartCubit>()
                                                            .updateQuantity(
                                                                item.productId,
                                                                currentQuantity);
                                                      }),
                                                ],
                                              ),
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
            ),
            bottomSheet: products.isEmpty
                ? Container(
                    height: 0,
                  )
                : Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Summary",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Color(0xff828A89)),
                                  ),
                                  Text(
                                    "\$${subtotal.toStringAsFixed(2)}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping Cost",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Color(0xff828A89)),
                                  ),
                                  Text(
                                    "\$${shippingCost}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(
                                color: Color(0xfff0f0f2),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Payment",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.darkBrown,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${(subtotal + shippingCost).toStringAsFixed(2)}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: AppColors.orangeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors
                                    .darkBrown, // Change this color if needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle checkout action
                                naviagteTo(
                                    context,
                                    CheckOut(
                                      subtotal: subtotal,
                                      shippingCost: shippingCost,
                                    ));
                              },
                              child: Text(
                                "Check Out",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
          );
        },
        listener: (BuildContext context, CartState state) {
          if (state is CartUpdated) {
            setState() {}
          }
        },
      ),
    );
  }
}

// 🔥 استخراج زر التحكم في العدد كود نظيف
Widget _buildQuantityButton({
  required IconData icon,
  required Color color,
  required Color iconColor,
  required VoidCallback onTap,
}) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: iconColor, size: 20),
        onPressed: onTap,
      ),
    ),
  );
}
