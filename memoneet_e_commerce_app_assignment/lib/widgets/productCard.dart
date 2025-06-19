import 'package:flutter/material.dart';
import 'package:memoneet_e_commerce_app_assignment/models/productModel.dart';
import 'package:memoneet_e_commerce_app_assignment/providers/cartProvider.dart';
import 'package:memoneet_e_commerce_app_assignment/utils/colors.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final int quantity = cart.getItemQuantity(title);

    final product = Product(
      imageUrl: imageUrl,
      title: title,
      description: description,
      price: price,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 16),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTextColor,
                  ),
                ),

                const SizedBox(height: 6),

                // Description
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.secondaryTextColor,
                  ),
                ),

                const SizedBox(height: 8),

                // Price + Add/Remove Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    quantity == 0
                        ? ElevatedButton(
                            onPressed: () => cart.addToCart(product),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => cart.decreaseQuantity(product),
                                  icon: const Icon(Icons.remove, size: 20),
                                  color: AppColors.primaryColor,
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => cart.increaseQuantity(product),
                                  icon: const Icon(Icons.add, size: 20),
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
