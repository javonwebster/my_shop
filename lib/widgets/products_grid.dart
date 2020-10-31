import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    //we want to create a direct channel to the provider instance of products class
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(
        10.0,
      ), //use const so this does not rebuild to improve performance
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //number of columns we want
        childAspectRatio: 3 / 2, //make items taller that the are wide
        crossAxisSpacing: 10, //spacing between the columns
        mainAxisSpacing: 10, //spacing between rows
      ), //defines how the grid should be structured
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //we should use .value() for lists or grid items where flutter will recycle the widget
        value: products[i],
        child: ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ), //defines how every item should be built
      itemCount: products.length,
    );
  }
}
