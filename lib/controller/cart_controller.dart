import 'package:flutter/material.dart';
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
  double quantitiy = 1.0;
  increaseQuentity(){
    quantitiy++;
    totalPrice();
    update();
  }
  decreaseQuentity(){
    if(quantitiy>1){
      quantitiy--;
      totalPrice();
      update();
    }
  }

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
      totalPrice();
      update();
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
      totalPrice();
      update();
    }
    update();
    return true;
  }

  void removeItem(String id) {
    _items.remove(id);
    totalPrice();
    update();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      totalPrice();
      update();
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
      totalPrice();
      update();
    }
    totalPrice();
    update();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
      update();
    });
    return total;
  }

  void clear() {
    _items = {};
    totalPrice();
    update();
  }

  double total = 0;
  double totalAfterDiscount = 0;
  void totalPrice() {
    total = 0;
    totalAfterDiscount = 0;
    items.forEach((key, value) {
      total += (value.price! * value.quantity!);
      totalAfterDiscount += (value.price! * value.quantity!);
      update();
    });

  }
  void addToPrice(value) {
    totalAfterDiscount += value;
    update();
  }
  void subtractFromPrice(value) {
    totalAfterDiscount -= value;
    update();
  }
}
