import 'menu_item.dart';

class CartItem {
  final MenuItem item;
  final int quantity;

  CartItem({
    required this.item,
    required this.quantity,
  });

  double get totalPrice => item.price * quantity;
}
