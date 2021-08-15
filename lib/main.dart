import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_first_vsc_app/provider/auth.dart';
import 'package:shop_first_vsc_app/provider/cart.dart';
import 'package:shop_first_vsc_app/provider/orders.dart';
import 'package:shop_first_vsc_app/provider/product.dart';
import 'package:shop_first_vsc_app/provider/products.dart';
import 'package:shop_first_vsc_app/screen/auth_screen.dart';
import 'package:shop_first_vsc_app/screen/cart_screen.dart';
import 'package:shop_first_vsc_app/screen/edit_product_screen.dart';
import 'package:shop_first_vsc_app/screen/orders_screen.dart';
import 'package:shop_first_vsc_app/screen/product_details_screen.dart';
import 'package:shop_first_vsc_app/screen/product_overview_screen.dart';
import 'package:shop_first_vsc_app/screen/splash_screen.dart';
import 'package:shop_first_vsc_app/screen/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(),
          update: (context, value, previous) => previous
            ..getData(
              value.token,
              value.userId,
              previous == null ? null : previous.orders,
            ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(),
          update: (context, value, previous) => previous
            ..getData(
              value.token,
              value.userId,
              previous == null ? null : previous.items,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, value, child) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: value.isAuth
              ? ProductOverViewScreen()
              : FutureBuilder(
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                  future: value.tryAutoLogin(),
                ),
          routes: {
            ProductDetailsScreen.routeName: (_) => ProductDetailsScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            OrderScreen.routeName: (_) => OrderScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
            EditProductScreen.routeName: (_) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
