import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_first_vsc_app/provider/orders.dart' show Orders;
import 'package:shop_first_vsc_app/widget/app_drawer.dart';
import 'package:shop_first_vsc_app/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error Occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.orders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(value.orders[index]);
                  },
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
