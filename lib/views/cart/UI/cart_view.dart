import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_state.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: const _CartViewContent(),
    );
  }
}

class _CartViewContent extends StatefulWidget {
  const _CartViewContent();

  @override
  State<_CartViewContent> createState() => _CartViewContentState();
}

class _CartViewContentState extends State<_CartViewContent> {
  final double shippingCost = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: _buildAppBar(context),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final products = cartCubit.cartProducts;
          final subtotal = _calculateSubtotal(products);

          return Column(
            children: [
              Expanded(
                child: _buildProductList(products),
              ),
              if (products.isNotEmpty) _buildOrderSummary(subtotal, context),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Shopping",
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: AppColors.darkBrown,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => _navigateToHome(context),
        icon: const Icon(Icons.arrow_back, color: AppColors.darkBrown),
      ),
      actions: [_buildClearCartButton()],
    );
  }

  Widget _buildClearCartButton() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => _showClearCartConfirmation(context),
          icon: const Icon(Icons.delete, color: AppColors.darkBrown),
        );
      },
    );
  }

  void _showClearCartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Cart',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        content: Text(
          'Are you sure you want to clear your cart?',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.darkBrown,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.darkBrown,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<CartCubit>().removeAllFromCart();
              Navigator.pop(context);
              navigateWithoutBack(context, const CartView());
            },
            child: Text(
              'Clear',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Products> products) {
    if (products.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildCartItem(products[index], context),
    );
  }

  Widget _buildCartItem(Products item, BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final currentQuantity = item.quantity ?? 1;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildProductImage(item),
            const SizedBox(width: 16),
            Expanded(child: _buildProductDetails(item)),
            _buildQuantityControls(item, cartCubit, currentQuantity),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(Products item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: item.productImageTable.isNotEmpty
          ? Image.network(
              item.productImageTable.first.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  Widget _buildProductDetails(Products item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.productName,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          item.brand ?? '',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _calculateItemPrice(item),
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.orangeColor,
          ),
        ),
      ],
    );
  }

  String _calculateItemPrice(Products item) {
    final price = item.specialOffersTable.isNotEmpty
        ? (item.price *
                ((100 - item.specialOffersTable.first.discount) / 100)) *
            (item.quantity ?? 1)
        : item.price * (item.quantity ?? 1);
    return '\$${price.toStringAsFixed(2)}';
  }

  Widget _buildQuantityControls(
    Products item,
    CartCubit cartCubit,
    int currentQuantity,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => cartCubit.removeFromCart(item.productId),
          icon: const Icon(Icons.delete, color: AppColors.orangeColor),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _QuantityButton(
              icon: Icons.remove,
              color: const Color(0xfff0f0f2),
              iconColor: const Color(0xff828A89),
              onPressed: currentQuantity > 1
                  ? () => cartCubit.updateQuantity(
                        item.productId,
                        currentQuantity - 1,
                      )
                  : null,
            ),
            const SizedBox(width: 10),
            Text('$currentQuantity', style: _quantityTextStyle),
            const SizedBox(width: 10),
            _QuantityButton(
              icon: Icons.add,
              color: AppColors.darkBrown,
              iconColor: Colors.white,
              onPressed: () => cartCubit.updateQuantity(
                item.productId,
                currentQuantity + 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderSummary(double subtotal, BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Shipping Cost', shippingCost),
          const Divider(color: Color(0xfff0f0f2)),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Total Payment',
            subtotal + shippingCost,
            isTotal: true,
          ),
          const SizedBox(height: 16),
          _buildCheckoutButton(subtotal, context),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? AppColors.darkBrown : const Color(0xff828A89),
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: AppColors.orangeColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(double subtotal, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _navigateToCheckout(subtotal, context),
        child: Text(
          "Check Out",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  double _calculateSubtotal(List<Products> products) {
    return products.fold(0.0, (sum, item) {
      double price = item.price.toDouble();
      if (item.specialOffersTable.isNotEmpty) {
        final discount = item.specialOffersTable.first.discount.toDouble();
        if (discount > 0 && discount <= 100) {
          price *= (100 - discount) / 100;
        }
      }
      return sum + (price * (item.quantity ?? 1));
    });
  }

  void _navigateToHome(BuildContext context) {
    naviagteTo(
      context,
      MainHomeView(
        userDataModel: context.read<AuthenticationCubit>().userDataModel!,
      ),
    );
  }

  void _navigateToCheckout(double subtotal, BuildContext context) {
    naviagteTo(
      context,
      CheckOut(
        subtotal: subtotal,
        shippingCost: shippingCost,
      ),
    );
  }

  final TextStyle _quantityTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback? onPressed;

  const _QuantityButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(icon, color: iconColor, size: 20),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
