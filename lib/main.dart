import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //to register a provider

import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';
import './screens/orders_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //here we setup a provider the provides an instance of the class to all child widgets that are interested.
    //not all child widgets can setup listeners for the instance of the Products class
    //therefore only widgets that are listening will now be rebuilt
    return MultiProvider(//setup multiple providers
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(), // we this instead .value() because we are creating a new object that won't be reused
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ], 
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
