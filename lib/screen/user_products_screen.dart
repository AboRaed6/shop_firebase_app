import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_first_vsc_app/provider/products.dart';
import 'package:shop_first_vsc_app/screen/edit_product_screen.dart';
import 'package:shop_first_vsc_app/widget/app_drawer.dart';
import 'package:shop_first_vsc_app/widget/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Consumer<Products>(
                    builder: (context, value, child) => Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: value.items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              UserProductItem(
                                value.items[index].id,
                                value.items[index].title,
                                value.items[index].imageUrl,
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
