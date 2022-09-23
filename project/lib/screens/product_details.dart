import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

import '../models/ModelAds1.dart';

class Details extends StatefulWidget {
  static const routeName = '/details';

  Details({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)!.settings.arguments as String?;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final loadedP =
        Provider.of<Products>(context).findById(productId.toString());
    final Data = Provider.of<Products>(context).getSingleAds(productId);
    return FutureBuilder(
        future: Data,
        builder: (context, snapchot) {
          switch (snapchot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black12,
                backgroundColor: Theme.of(context).backgroundColor,
              ));
              break;

            case ConnectionState.active:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black12,
                backgroundColor: Theme.of(context).backgroundColor,
              ));
              break;

            case ConnectionState.none:
              return Center(child: Text("ERROR"));
              break;

            case ConnectionState.done:
              return ListView(children: [
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                        // ignore: unnecessary_brace_in_string_interps
                        ModelAds1.photo1,
                        fit: BoxFit.fill),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Description:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  '${ModelAds1.des}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:
                                Text('Name :', style: TextStyle(fontSize: 16)),
                          ),
                          Text('${ModelAds1.name}',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Category :',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Text('Ground Beef', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:
                                Text('Price :', style: TextStyle(fontSize: 16)),
                          ),
                          Text('${ModelAds1.price}',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Product expiration date :',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Text('${ModelAds1.exp} ',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Quantity :',
                                style: TextStyle(fontSize: 16)),
                          ),
                          FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.add),
                            onPressed: () {
                              ModelAds1.quan++;
                            },
                          ),
                          Text('${ModelAds1.quan} ',
                              style: TextStyle(fontSize: 14)),
                          FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.remove),
                            onPressed: () {
                              ModelAds1.quan--;
                            },
                          ),
                        ],
                      ),
                    ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100.0, 8.0, 90.0, 0),
                      child: RaisedButton(
                        color: Colors.black12,
                        textColor: Colors.white,
                        child:
                            Text('Add to Cart', style: TextStyle(fontSize: 16)),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Leave a comment :",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      hintText: "Write your review of the product",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ),
              ]);
          }
        });
  }
}
