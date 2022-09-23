// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orderItem.dart';
import '../models/wishlistItem.dart';
import '../providers/wishlistProvider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/wishLItem.dart';
import '../widgets/orders_item.dart';
import '../providers/ordersProvide.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishes';

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<Wishlist>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
        title: Text('My Wishlist'),
      ),
      body: ListView.builder(
        //shrinkWrap: true,
        itemBuilder: (context, i) => wishLItem(
          w_item: Data.wishes[i],
          wishes: Data.wishs,
        ),
        itemCount: Data.itemcount,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 1,
        //   childAspectRatio: 4 / 2,
        //   crossAxisSpacing: 10,
        //   mainAxisSpacing: 10,
        // ),
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),

      // body: FutureBuilder(
      //   future: Provider.of<Wishlist>(context, listen: false)
      //       .fetchAndSetWishlist(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else {
      //       if (snapshot.error != null) {
      //         // ...
      //         // Do error handling stuff
      //         return Center(
      //           child: Text('An error occurred!'),
      //         );
      //       } else {
      //         return Consumer<Wishlist>(
      //           builder: (ctx, wishListData, child) => ListView.builder(
      //             itemCount: wishListData.wishs.length,
      //             itemBuilder: (ctx, i) => wishLItem(
      //               w_item: wishListData.wishs[i],
      //               wishes: [],
      //             ),
      //           ),
      //         );
      //       }
      //     }
      //   },
      // )

      // _isloading
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemBuilder: (context, i) => ordItem(ord: ordersData.orders[i]),
      //         itemCount: ordersData.orders.length,
      //       ),
    );
  }
}
