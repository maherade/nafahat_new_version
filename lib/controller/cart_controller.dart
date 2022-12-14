import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  String? id;
  String? name;
  String? imgurl;
  double? quantity;
  double? price;

  CartItem(
      {this.id, this.name,this.imgurl, this.quantity, this.price});
}

class CartController extends GetxController {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool addItem(
      {String? imgurl,
        String? pdtid,
        String? name,
        double? quantitiy,
        double? price}) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid!,
              (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              imgurl: existingCartItem.imgurl,
              quantity: existingCartItem.quantity! + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pdtid!,
              () => CartItem(
            imgurl: imgurl,
            name: name,
            id: pdtid,
            quantity: quantitiy,
            price: price,
          ));
    }
    update();
    return true;
  }

  void removeItem(String id) {
    _items.remove(id);
    update();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity! > 1) {
      _items.update(
          id,
              (existingCartItem) => CartItem(
              imgurl: existingCartItem.imgurl,
              id: existingCartItem.id,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity! - 1,
              price: existingCartItem.price));
    }
    update();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  void clear() {
    _items = {};
    update();
  }

  double totalPrice () {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price!;
    });
    return total;
  }
}
