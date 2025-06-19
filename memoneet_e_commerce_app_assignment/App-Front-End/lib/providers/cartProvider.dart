import 'package:flutter/material.dart';
import 'package:memoneet_e_commerce_app_assignment/models/cartItemModel.dart';
import 'package:memoneet_e_commerce_app_assignment/models/productModel.dart';
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.title == product.title);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.title == product.title);
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.title == product.title);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }
  


  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.title == product.title);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      removeFromCart(product);
    }
    notifyListeners();
  }

  double get totalPrice => _items.fold(
    0,
    (total, item) => total + (item.product.price * item.quantity),
  );
   
   
  int getItemQuantity(String title) {
  final index = _items.indexWhere((item) => item.product.title == title);
  return index != -1 ? _items[index].quantity : 0;
}

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
