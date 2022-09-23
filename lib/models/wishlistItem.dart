import '../providers/product.dart';

import 'cartItem.dart';

class wishItem {
  final String id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  final DateTime datetime;
  String cat_id;

  wishItem({
    required this.cat_id,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.description,
    required this.datetime,
  });
}
