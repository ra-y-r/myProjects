import 'package:flutter/cupertino.dart';

class searchedItem with ChangeNotifier {
  var user_id;
  var name;
  var exp_date;
  var cat_id;
  var views;
  var description;
  var quantity;
  var img;
  var id;
  var price;
  searchedItem(
      {required this.id,
      required this.cat_id,
      required this.exp_date,
      required this.name,
      required this.views,
      required this.user_id,
      required this.description,
      required this.img,
      required this.quantity,
      required this.price});
}
