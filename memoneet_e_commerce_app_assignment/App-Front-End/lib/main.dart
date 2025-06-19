import 'package:flutter/material.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/authPage.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/cartPage.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/homePage.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/orderSummeryPage.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/paymentPage.dart';
import 'package:memoneet_e_commerce_app_assignment/Pages/popups/orderSuccessPopup.dart';
import 'package:memoneet_e_commerce_app_assignment/providers/cartProvider.dart';
import 'package:memoneet_e_commerce_app_assignment/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemoNeet Store',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
    routes: {
  '/': (context) => const AuthScreen(),
  '/cart': (context) => const CartScreen(),
  '/summary': (context) => const OrderSummaryScreen(),
  '/payment': (context) => const PaymentScreen(),
  '/success': (context) => const OrderSuccessScreen(),
}

    );
  }
}
