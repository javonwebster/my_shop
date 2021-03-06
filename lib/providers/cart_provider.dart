import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantitiy;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantitiy,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantitiy;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    //check if we already have the item in the cart and if not present add it
    if (_items.containsKey(productId)) {
      //change the quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantitiy: existingCartItem.quantitiy + 1,
            price: existingCartItem.price),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantitiy: 1,
            price: price),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantitiy > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantitiy: existingCartItem.quantitiy - 1,
                price: existingCartItem.price,
              ));
    }
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {}; //set items back to an empty map
    notifyListeners();
  }
}
