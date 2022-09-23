import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orderItem.dart';
import '../models/wishlistItem.dart';
import '21.1 badge.dart.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/ordersProvide.dart';

class wishLItem extends StatefulWidget {
  final wishItem w_item;
  List<wishItem> wishes = [];
  wishLItem({required this.wishes, required this.w_item});

  @override
  State<wishLItem> createState() => _wishLItemState();
}

class _wishLItemState extends State<wishLItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.w_item.title}'),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.w_item.datetime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            SizedBox(
              height: 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                // height: min(widget.wishes.length * 20 + 10, 100),
                child: ListView(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                            child: SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 90,
                                child: Image.network(
                                  '${widget.w_item.imageUrl}',
                                  fit: BoxFit.cover,
                                  //height: 10,
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('item id:    ${widget.w_item.id}'),
                                  Text('category id: ${widget.w_item.cat_id}'),
                                  Text(
                                      'price:      ${widget.w_item.price.toString()}'),
                                ],
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
