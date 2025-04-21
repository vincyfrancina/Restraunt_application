import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../utils/data.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Cart cart = Cart();

  void addToCart(index) {
    setState(() {
      cart.addItem(sampleMenu[index], 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${sampleMenu[index].name} added to cart!")),
    );
  }

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: cart),
      ),
    );
  }

  void goToBooking() {
    Navigator.pushNamed(context, '/booking');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.orangeAccent,
                      child: Text(
                        '${cart.items.length}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: goToCart,
          ),
          SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        itemCount: sampleMenu.length,
        itemBuilder: (context, index) {
          return MenuItemCard(
            item: sampleMenu[index],
            onAdd: () => addToCart(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToBooking,
        backgroundColor: Colors.orangeAccent,
        icon: Icon(Icons.event_seat),
        label: Text("Book Table"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            if (cart.items.isNotEmpty) {
              cart.checkout();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Total: ₹${cart.total.toStringAsFixed(2)}")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Your cart is empty!")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            "Checkout (₹${cart.total.toStringAsFixed(2)})",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}  