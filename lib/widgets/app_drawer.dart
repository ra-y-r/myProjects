import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/first-time-user/liquid-swipe.dart';
import '../screens/ordersScreen.dart';
import '../screens/postsScreen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/wishlist.dart';
import '../screens/createPost.dart';
import '../screens/storyScreen.dart';
import '../screens/ordersScreen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Auth>(
      context,
      listen: false,
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.black12,
            title: Text('welcome'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(productsOverviewScreen.routeName);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text('Orders'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(ordersScreen.routeName);
          //   },
          // ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Manage Products'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(UserProductsScreen.routeName);
          //   },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('wish List'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(WishlistScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text('create post'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(postScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text(' story'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(storyScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text(' logOut'),
            onTap: () {
              loadedProduct.logout();
              Navigator.of(context)
                  .pushReplacementNamed(liquid_swipe_sc.routeName);
            },
          ),
        ],
      ),
    );
  }
}
