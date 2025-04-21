import 'package:scoped_model/scoped_model.dart';
import '../models/booking_model.dart';
import '../models/order.dart';

class AppModel extends Model {
  final List<Booking> _bookings = [];
  final List<Order> _orders = [];

  List<Booking> get bookings => _bookings;
  List<Order> get orders => _orders;

  get cart => null;

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
