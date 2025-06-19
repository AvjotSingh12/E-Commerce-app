import 'package:flutter/material.dart';
import 'package:memoneet_e_commerce_app_assignment/providers/cartProvider.dart';
import 'package:memoneet_e_commerce_app_assignment/utils/colors.dart';
import 'package:memoneet_e_commerce_app_assignment/widgets/productCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'title': 'Study Planner Notebook',
      'description': 'Organize your NEET prep with daily/weekly layouts.',
      'price': 12.99,
      'imageUrl': 'https://m.media-amazon.com/images/I/81Q-IBt-dYL.jpg',
    },
    {
      'title': 'Flashcard Set – Biology',
      'description': '500 illustrated flashcards for quick review.',
      'price': 19.99,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq2xqsqj8vmqvmUZCpBmRu4r7xmSG1vec0lw&s',
    },
    {
      'title': 'Memory Training App Guide',
      'description': 'Downloadable PDF + access code.',
      'price': 9.49,
      'imageUrl': 'https://m.media-amazon.com/images/I/614bcxyyS8L._AC_UF1000,1000_QL80_.jpg',
    },
    {
      'title': 'Revision Poster Pack',
      'description': 'Set of 5 colorful educational posters.',
      'price': 14.75,
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuE-kuZ9tYvMtyJuMPpdwMVy2-7SM8qi7E7w&s',
    },
    {
      'title': 'Motivational Stickers',
      'description': 'Pack of 20 stickers for your study space.',
      'price': 4.99,
      'imageUrl': 'https://images.vexels.com/media/users/3/267173/raw/522b7d16fb50338af573f9ef1ddd2d5b-motivational-positive-quotes-sticker-set.jpg',
    },
  ];

  void _navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'MemoNeet Store',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Product List
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ProductCard(
                  title: product['title'],
                  description: product['description'],
                  price: product['price'],
                  imageUrl: product['imageUrl'],
                ),
              );
            },
          ),

          // Active Order Tab (if cart is not empty)
          if (cartProvider.items.isNotEmpty)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => _navigateToCart(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white),
                      Text(
                        'Active Order (${cartProvider.items.length} items)',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.home, color: AppColors.primaryColor),
                  const Icon(Icons.favorite_border),
                  GestureDetector(
                    onTap: () => _navigateToCart(context),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
