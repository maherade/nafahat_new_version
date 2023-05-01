import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteItem {
  final String? id;
  final String? imgUrl;
  final String? brandName;
  final String? perfumeName;
  final double? perfumeRate;
  final String? rateCount;
  final String? priceBeforeDiscount;
  final String? priceAfterDiscount;

  FavouriteItem(this.id,this.imgUrl, this.brandName, this.perfumeName, this.perfumeRate, this.rateCount, this.priceBeforeDiscount, this.priceAfterDiscount);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'brandName': brandName,
      'perfumeName': perfumeName,
      'perfumeRate': perfumeRate,
      'rateCount': rateCount,
      'priceBeforeDiscount': priceBeforeDiscount,
      'priceAfterDiscount': priceAfterDiscount,
    };
  }

}

class FavouriteController extends GetxController {
  Map<String, FavouriteItem> _items = {};

  Map<String, FavouriteItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool addItem(
      {String? pdtid,
      String? imgUrl,
        String? brandName,
        String? perfumeName,
        double? perfumeRate,
        String? rateCount,
        String? priceBeforeDiscount,
        String? priceAfterDiscount,
      }) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid!,
              (existingFavouriteItem) => FavouriteItem(
                pdtid = existingFavouriteItem.id,
                imgUrl = existingFavouriteItem.imgUrl,
                brandName = existingFavouriteItem.brandName,
                perfumeName = existingFavouriteItem.perfumeName,
                perfumeRate = existingFavouriteItem.perfumeRate,
                rateCount = existingFavouriteItem.rateCount,
                priceBeforeDiscount = existingFavouriteItem.priceBeforeDiscount,
                priceAfterDiscount = existingFavouriteItem.priceAfterDiscount,
              ));
      update();
    } else {
      _items.putIfAbsent(
          pdtid!,
              () => FavouriteItem(
                pdtid = pdtid,
                imgUrl = imgUrl,
                brandName = brandName,
                perfumeName = perfumeName,
                perfumeRate = perfumeRate,
                rateCount = rateCount,
                priceBeforeDiscount = priceBeforeDiscount,
                priceAfterDiscount = priceAfterDiscount,
          ));
    }
    _saveItemsToPrefs();
    update();
    return true;
  }

  bool removeItem(String id) {
    _items.remove(id);
    _saveItemsToPrefs();
    update();
    return true;
  }



  void clear() {
    _items = {};
    _saveItemsToPrefs();
    update();
  }


  Future<void> loadItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('favouriteItems') ?? '{}';
    final itemsMap = json.decode(itemsJson) as Map<String, dynamic>;
    _items = itemsMap.map(
          (key, value) => MapEntry(
        key,
        FavouriteItem(value['id'], value['imgUrl'],value['brandName'],value['perfumeName'],value['perfumeRate'],value['rateCount'],value['priceBeforeDiscount'],value['priceAfterDiscount']),
      ),
    );
    // _items.forEach((key, value) {print(key);});
    update();
  }

  void _saveItemsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = Map<String, dynamic>.fromIterable(
      _items.keys,
      value: (key) => _items[key]!.toJson(),
    );
    prefs.setString('favouriteItems', json.encode(itemsJson));
    loadItemsFromPrefs();
  }

}
