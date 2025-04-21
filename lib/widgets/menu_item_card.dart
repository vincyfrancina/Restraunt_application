import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const MenuItemCard({
    super.key,
    required this.item,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // 💡 Light maroon shade
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional image (can comment this if not using images)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl!,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  // Text(
                  //   item.description,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //     color: Colors.black54,
                  //   ),
                  // ),
                  SizedBox(height: 8),
                  Text(
                    "₹${item.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.orangeAccent,
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
