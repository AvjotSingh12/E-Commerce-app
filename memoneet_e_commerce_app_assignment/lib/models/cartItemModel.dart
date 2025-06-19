import 'package:memoneet_e_commerce_app_assignment/models/productModel.dart';



class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
