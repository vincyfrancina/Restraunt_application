import 'package:intl/intl.dart';
import 'cart_item.dart';

class Order {
  final List<CartItem> items;
  final double total;
  final DateTime date;

  Order({required this.items, required this.total, required this.date});

  String get formattedDate => DateFormat('yyyy-MM-dd – kk:mm').format(date);
}
