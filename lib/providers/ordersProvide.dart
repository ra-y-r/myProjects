import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/cartItem.dart';
import '../models/orderItem.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  var token;
  Orders(this.token, this._orders);

  List<OrdersItem> _orders = [];

  List<OrdersItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    //fix urls
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Charset': 'utf-8',
      'Connection': 'keep-alive',
    });
    final List<OrdersItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrdersItem(
          id: orderId,
          amount: orderData['amount'],
          datetime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  imageUrl: item['imageurl'],
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, var total) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product");
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'datetime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        });
    _orders.insert(
      0,
      OrdersItem(
        id: json.decode(response.body)['name'],
        amount: total,
        datetime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
