import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_first_vsc_app/provider/product.dart';
import 'package:shop_first_vsc_app/provider/products.dart';
import 'package:shop_first_vsc_app/widget/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  ProductsGrid(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        showFavorites ? productData.favoritesItems : productData.items;
    return products.isEmpty
        ? Center(
            child: Text('There is no Product!'),
          )
        : GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(),
            ),
          );
  }
}
