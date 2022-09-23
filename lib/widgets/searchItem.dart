import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/searchedItem.dart';
import '../models/orderItem.dart';
import '../models/wishlistItem.dart';
import '21.1 badge.dart.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/ordersProvide.dart';

class SearchItem extends StatefulWidget {
  final searchedItem s_item;
  List<searchedItem> items = [];
  SearchItem({required this.items, required this.s_item});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.s_item.name.toString()}'),
            subtitle: Text('${widget.s_item.user_id.toString()}'),
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
                                  '${widget.s_item.img}',
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
                                  Text(
                                      'item id:    ${widget.s_item.id.toString()}'),
                                  Text(
                                      'category id: ${widget.s_item.cat_id.toString()}'),
                                  Text(
                                      'price:      ${widget.s_item.price.toString()}'),
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
