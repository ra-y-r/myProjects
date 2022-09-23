// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orderItem.dart';
import '../widgets/app_drawer.dart';
import '../widgets/orders_item.dart';
import '../providers/ordersProvide.dart';

class ordersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //  final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
        title: Text('My Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => ordItem(ord: orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
      // _isloading
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemBuilder: (context, i) => ordItem(ord: ordersData.orders[i]),
      //         itemCount: ordersData.orders.length,
      //       ),
    );
  }
}
