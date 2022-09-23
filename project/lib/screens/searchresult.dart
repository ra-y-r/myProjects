// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/searchedItem.dart';
import 'package:untitled/providers/searchProvider.dart';
import 'package:untitled/widgets/searchItem.dart';
import '../models/orderItem.dart';
import '../models/wishlistItem.dart';
import '../providers/wishlistProvider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/wishLItem.dart';
import '../widgets/orders_item.dart';
import '../providers/ordersProvide.dart';
import 'searchfilter.dart';

class searchScreen extends StatefulWidget {
  static const routeName = '/searchs';

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<SearchProv>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(searchS.routeName);
            },
            icon: Icon(Icons.search),
            color: Colors.blue,
          )
        ],
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
        title: Text('Search results'),
      ),
      body: ListView.builder(
        //shrinkWrap: true,
        itemBuilder: (context, i) => SearchItem(
          s_item: Data.item[i],
          items: Data.items,
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
    );
  }
}
