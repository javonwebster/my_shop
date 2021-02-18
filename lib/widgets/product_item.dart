import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // gives tiles rounded corners
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
            //Alternative to named routes
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(title),
            //   ),
            // );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus(authData.token, authData.userId);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart',
                    // textAlign: TextAlign.center,
                  ),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                    label: 'UNDO',
                  ),
                ),
              ); //establish a connection to the nearest Scaffold widget or layout
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
