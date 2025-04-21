import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.item.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange[100],
                child: Text(
                  cartItem.item.name[0],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.item.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text("Qty: ${cartItem.quantity}", style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${cartItem.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onRemove,
                    tooltip: "Remove",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
