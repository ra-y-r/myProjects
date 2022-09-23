import 'package:flutter/material.dart';
import '../models/wishlistItem.dart';

import 'productReview.dart';

class prodRItem extends StatefulWidget {
  final ProdReview w_item;
  List<ProdReview> wishes = [];
  prodRItem({required this.wishes, required this.w_item});

  @override
  State<prodRItem> createState() => _prodRState();
}

class _prodRState extends State<prodRItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('${widget.w_item.user_id}'),
        subtitle: Text('${widget.w_item.value}'),
      ),
    );
  }
}
