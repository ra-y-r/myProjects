import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/searchedItem.dart';
import 'package:untitled/models/searchedValue.dart';
import '../models/http_exception.dart';
import '../models/storyItem.dart';
import '../models/postItem.dart';

class SearchProv with ChangeNotifier {
  final token;

  SearchProv(this.token, this.item);
  final n = searchedItem(
    cat_id: '',
    exp_date: '',
    id: '',
    name: '',
    views: 0,
    description: '',
    img: '',
    price: 0,
    quantity: 0,
    user_id: 0,
  );

  List<searchedItem> item = [];
  List<searchedItem> get items {
    return [...item];
  }

  int get itemcount {
    return item.length;
  }

  searchedItem findById(String id) {
    return item.firstWhere((prod) => prod.id.toString() == id,
        orElse: () => n as searchedItem);
  }

  Future<void> SearchByDate(DateTime date) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product/searchD/${date}");
    try {
      final resp = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );

      var Data = jsonDecode(resp.body);
      final extractedData = Data;
      if (extractedData == null) {
        return;
      }

      final List<searchedItem> loadedproducts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedproducts.add(searchedItem(
            user_id: prodData['user_id'],
            views: prodData['views'],
            exp_date: prodData['exp_date'],
            cat_id: prodData['category_id'],
            id: prodData["id"],
            img: prodData['img_url'],
            price: prodData['price'],
            quantity: prodData['quantity'],
            name: prodData['name'],
            description: prodData['description']));
      });
      item = loadedproducts;

      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> SearchByName(String name) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product/searchn/${name}");
    try {
      final resp = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );

      var Data = jsonDecode(resp.body);
      print(Data);
      final extractedData = Data;
      if (extractedData == null) {
        return;
      }
      final List<searchedItem> loadedproducts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedproducts.add(searchedItem(
            user_id: prodData['user_id'],
            views: prodData['views'],
            exp_date: prodData['exp_date'],
            cat_id: prodData['category_id'],
            id: prodData["id"],
            img: prodData['img_url'],
            price: prodData['price'],
            quantity: prodData['quantity'],
            name: prodData['name'],
            description: prodData['description']));
      });
      item = loadedproducts;

      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> search(searchedValue val) async {
    if (val.val is String) {
      return SearchByName(val.val);
    } else
      return SearchByDate(val.val);
  }
}
