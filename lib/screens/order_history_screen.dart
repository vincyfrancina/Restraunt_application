import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/app_model.dart';
import '../models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        final orders = model.orders;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Order History"),
            backgroundColor: Colors.orangeAccent,
          ),
          body: orders.isEmpty
              ? const Center(child: Text("No orders yet."))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text("₹${order.total.toStringAsFixed(2)}"),
                        subtitle: Text(order.formattedDate),
                        trailing: Icon(Icons.receipt_long),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
