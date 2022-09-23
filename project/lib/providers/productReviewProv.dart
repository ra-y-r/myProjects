import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/postComment.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/productReview.dart';

class ProdRe with ChangeNotifier {
  var token;
  ProdRe(this.token, this.reviews);

  List<ProdReview> reviews = [];

  List<ProdReview> get com {
    return [...reviews];
  }

  int get itemcount {
    return reviews.length;
  }

  Future<void> addComment(ProdReview comment) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Map<String, dynamic> pro = {};

    pro['value'] = comment.value;

    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/product/${comment.product_id}/comment");

    try {
      final timestamp = DateTime.now();
      final response = await http.post(url, body: pro, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Connection': 'keep-alive',
      });
      var data = jsonDecode(response.body);
      print(data);
      reviews.insert(
          0,
          ProdReview(
              product_id: comment.product_id,
              user_id: comment.user_id,
              value: comment.value));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchallcomments(ProdReview comment) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/post/${comment.product_id}/comment");
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
      final extractedData = Data['data'];
      if (extractedData == null) {
        return;
      }

      final List<ProdReview> loadedcomments = [];
      extractedData.forEach((commData) {
        loadedcomments.add(ProdReview(
          product_id: commData['product_id'],
          user_id: commData['user_id'],
          value: commData['value'],
        ));
      });
      reviews = loadedcomments;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
