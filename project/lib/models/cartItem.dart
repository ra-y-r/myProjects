import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String imageUrl;
  final String title;
  final num price;
  final num quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.quantity});
}
