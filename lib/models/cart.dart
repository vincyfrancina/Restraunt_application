import 'cart_item.dart';
import 'menu_item.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(MenuItem item, int quantity) {
    try {
      if (quantity <= 0) {
        throw Exception("Invalid quantity");
      }
      items.add(CartItem(item: item, quantity: quantity));
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.totalPrice;
    }
    return sum;
  }

  void checkout() {
    if (items.isEmpty) {
      print("Cart is empty.");
    } else {
      print("Order placed! Total: ₹${total.toStringAsFixed(2)}");
    }
  }

  void removeItem(MenuItem item) {}

  void clear() {}
}
