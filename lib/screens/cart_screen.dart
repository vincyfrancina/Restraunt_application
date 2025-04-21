import 'package:flutter/material.dart';
import 'package:flutter_app/models/menu_item.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../scoped_models/app_model.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeItem(CartItem item) {
    setState(() {
      widget.cart.removeItem(item as MenuItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.item.name} removed from cart"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void placeOrder() {
    final cart = widget.cart;
    final appModel = ScopedModel.of<AppModel>(context, rebuildOnChange: false);

    if (cart.items.isNotEmpty) {
      // Save order to AppModel
      appModel.addOrder(
        Order(
          items: List.from(cart.items),
          total: cart.total,
          date: DateTime.now(),
        ),
      );

      cart.checkout();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order placed!")),
      );

      Navigator.pop(context); // Go back to menu
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text(
                    "Your cart is empty 🛒",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return CartItemTile(
                    cartItem: item,
                    onRemove: () => removeItem(item),
                  );
                },
              ),
            ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Place Order - ₹${cart.total.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          : null,
    );
  }
}
