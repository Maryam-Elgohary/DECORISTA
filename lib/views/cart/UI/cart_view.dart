import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Modern Chair",
      "brand": "Hatil-Loren",
      "price": 258.91,
      "image": "assets/RoyalChair.png",
      "quantity": 1,
    },
    {
      "name": "Minimalist Chair",
      "brand": "Regal Do Lobo",
      "price": 279.95,
      "image": "assets/RockingChair.png",
      "quantity": 4,
    },
    {
      "name": "Mathis Chair",
      "brand": "Hatil-Loren",
      "price": 369.86,
      "image": "assets/ModernWoodenChair.png",
      "quantity": 3,
    },
    {
      "name": "Mathis Chair",
      "brand": "Hatil-Loren",
      "price": 369.86,
      "image": "assets/ModernWoodenChair.png",
      "quantity": 3,
    },
  ];

  void updateQuantity(int index, int change) {
    setState(() {
      if (cartItems[index]['quantity'] + change >= 0) {
        cartItems[index]['quantity'] += change;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: AppColors.darkBrown,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
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
                          child: Image.asset(
                            item["image"],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkBrown),
                              ),
                              Text(item["brand"],
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.grey[600])),
                              const SizedBox(height: 4),
                              Text(
                                "\$${item["price"]}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: AppColors.orangeColor),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Color(0xfff0f0f2),
                                shape: BoxShape.circle,
                                //   borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.remove,
                                      color: Color(0xff828A89), size: 20),
                                  onPressed: () => updateQuantity(index, -1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${item["quantity"]}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: AppColors.darkBrown,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.add,
                                      color: Colors.white, size: 20),
                                  onPressed: () => updateQuantity(index, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Color(0xff828A89)),
                        ),
                        Text(
                          "\$908.72",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping Cost",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Color(0xff828A89)),
                        ),
                        Text(
                          "\$26.00",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "\$934.72",
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
                      backgroundColor:
                          AppColors.darkBrown, // Change this color if needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Handle checkout action
                      naviagteTo(context, CheckOut());
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
        ],
      ),
    );
  }
}
