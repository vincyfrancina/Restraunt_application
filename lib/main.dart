import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/table_booking_screen.dart';
import 'scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppModel appModel = AppModel();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: appModel,
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MenuScreen(),
          '/cart': (context) => CartScreen(cart: appModel.cart),
          '/booking': (context) => TableBookingScreen(),
        },
      ),
    );
  }
}
