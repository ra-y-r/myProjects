import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wishlistItem.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';
import '../models/cartItem.dart';
import '../models/orderItem.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Wishlist with ChangeNotifier {
  var token;
  Wishlist(this.token, this.wishes);

  List<wishItem> wishes = [];

  List<wishItem> get wishs {
    return [...wishes];
  }

  int get itemcount {
    return wishes.length;
  }

  // Future<void> fetchAndSetWishlist() async {
  //   //fix urls
  //   Uri url = Uri.parse("http://10.0.2.2:8000/api/product/wishlist");
  //   final response = await http.get(url, headers: {
  //     'Authorization': 'Bearer $token',
  //     'Accept': 'application/json',
  //     'Charset': 'utf-8',
  //     'Connection': 'keep-alive',
  //   });
  //   final List<wishItem> loadedList = [];
  //   final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //   if (extractedData == null) {
  //     return;
  //   }
  //   extractedData.forEach((wishId, wishData) {
  //     loadedList.add(
  //   wishItem (
  //     cat_id: ,
  //     datetime: ,
  //     description: ,
  //     id: ,
  //     imageUrl: ,
  //     price: ,
  //      title: ,

  //       //   id: wishId,
  //       //   amount: wishData['amount'],
  //       //   datetime: DateTime.parse(wishData['dateTime']),
  //       //   products: (wishData['products'] as List<dynamic>)
  //       //       .map(
  //       //         (item) => CartItem(
  //       //           imageUrl: item['imageurl'],
  //       //           id: item['id'],
  //       //           price: item['price'],
  //       //           quantity: item['quantity'],
  //       //           title: item['title'],
  //       //         ),
  //       //       )
  //       //       .toList(),
  //       ),
  //     );
  //   });
  //   wishes = loadedList.reversed.toList();
  //   notifyListeners();
  // }

  Future<void> addWiL(Product product) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Map<String, dynamic> pro = {};
    pro["product_id"] = product.id.toString();
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product/wishlist");
    final timestamp = DateTime.now();
    final response = await http.post(url, body: pro, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Charset': 'utf-8',
      'Connection': 'keep-alive',
    });
    wishes.insert(
      0,
      wishItem(
        datetime: timestamp,
        cat_id: product.cat_id,
        description: product.description,
        id: product.id.toString(),
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      ),
    );
    notifyListeners();
  }
  // void addWiL(Product product) async {
  //   final timestamp = DateTime.now();

  //   wishes.insert(
  //     0,
  //     wishItem(
  //       datetime: timestamp,
  //       cat_id: product.cat_id,
  //       description: product.description,
  //       id: product.id,
  //       imageUrl: product.imageUrl,
  //       price: product.price,
  //       title: product.title,
  //     ),
  //   );
  //   notifyListeners();
  // }
}
