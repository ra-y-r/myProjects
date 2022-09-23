import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orderItem.dart';
import '21.1 badge.dart.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/ordersProvide.dart';

class ordItem extends StatefulWidget {
  final OrdersItem ord;

  const ordItem({required this.ord});

  @override
  State<ordItem> createState() => _ordItemState();
}

class _ordItemState extends State<ordItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.ord.amount}'),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.ord.datetime)),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.ord.products.length * 20 + 10, 100),
              child: ListView(
                children: widget.ord.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            prod.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity}x \$${prod.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
