import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quntity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quntity,
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
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quntity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartitem) => CartItem(
              id: existingCartitem.id,
              title: existingCartitem.title,
              quntity: existingCartitem.quntity + 1,
              price: existingCartitem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quntity: 1,
                price: price,
              ));
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
    if (_items[productId].quntity > 1) {
      _items.update(
          productId,
          (existingCartitem) => CartItem(
              id: existingCartitem.id,
              title: existingCartitem.title,
              quntity: existingCartitem.quntity - 1,
              price: existingCartitem.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
