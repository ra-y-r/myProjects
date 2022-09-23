import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';
import '../models/storyItem.dart';
import '../models/postItem.dart';

class story with ChangeNotifier {
  final token;

  story(this.token, this.item);
  final n = stItem(
    desc: '',
    img: '',
    price: '',
    quantity: '',
    story_id: '',
    user_id: '',
  );

  List<stItem> item = [];
  List<stItem> get items {
    return [...item];
  }

  int get itemcount {
    return item.length;
  }

  stItem findById(String id) {
    return item.firstWhere((prod) => prod.story_id.toString() == id,
        orElse: () => n as stItem);
  }

  Future<void> addStory(stItem post) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Map<String, dynamic> pro = {};
    //   pro["user_id"] = post.user_id.toString();
    pro["story_id"] = post.story_id.toString();
    pro["price"] = post.price.toString();
    pro["description"] = post.desc.toString();
    pro["img_url"] = post.img;
    pro["quantity"] = post.quantity.toString();
    //fix
    Uri url = Uri.parse("http://10.0.2.2:8000/api/story/");

    try {
      final response = await http.post(
        url,
        body: pro,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );
      print(pro);
      print(response.body);

      final newPost = stItem(
        desc: post.desc,
        img: post.img,
        price: post.price,
        quantity: post.quantity,
        story_id: post.story_id,
        user_id: post.user_id,
      );
      item.add(newPost);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAllPost() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/story/");
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
      print(resp.body);
      var Data = jsonDecode(resp.body);
      //  print(Data);
      // var id = Data['data']['id'];
      final extractedData = Data['data'];
      // print(extractedData);
      //print(Data);
      if (extractedData == null) {
        return;
      }
      final List<stItem> loadedposts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedposts.add(stItem(
          desc: prodData['description'],
          img: prodData['img_url'],
          price: prodData['price'].toString(),
          quantity: prodData['quantity'].toString(),
          story_id: prodData['id'].toString(),
          user_id: prodData['user_id'].toString(),
        ));
      });
      item = loadedposts;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> fetchStory(stItem post) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('logToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/story/${post.story_id}");
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
      final extractedData = Data['data'];
      if (extractedData == null) {
        return;
      }
      final DisPost = stItem(
        desc: extractedData.desc,
        img: extractedData.img,
        price: extractedData.price,
        quantity: extractedData.quantity,
        story_id: extractedData.story_id,
        user_id: extractedData.user_id,
      );
      // item.insert(0, DisPost);

      print(DisPost);
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }
}
