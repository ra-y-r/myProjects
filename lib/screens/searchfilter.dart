// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/searchedItem.dart';
import 'package:untitled/models/searchedValue.dart';
import 'package:untitled/providers/searchProvider.dart';
import 'package:untitled/widgets/searchItem.dart';
import '../models/orderItem.dart';
import '../models/wishlistItem.dart';
import '../providers/wishlistProvider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/wishLItem.dart';
import '../widgets/orders_item.dart';
import '../providers/ordersProvide.dart';
import 'searchresult.dart';

class searchS extends StatefulWidget {
  static const routeName = '/search';

  @override
  State<searchS> createState() => _searchSState();
}

class _searchSState extends State<searchS> {
  var val = searchedValue(val: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }

    try {
      await Provider.of<SearchProv>(context, listen: false).search(val).then(
          (value) => Navigator.of(context).pushNamed(searchScreen.routeName));
    } catch (error) {
      print(error);
      // const errorMessage =
      //     'Could not authenticate you. Please try again later.';
      // _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
    //   _formKey1.currentState!.save();
    // _formKey2.currentState!.save();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<SearchProv>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.blue,
          )
        ],
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
        title: Text('Search results'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    labelText: '  value',
                    //  prefixIcon: Icon(Icons.email, color: Colors.white),
                    hintText: '',

                    semanticCounterText: 'value',
                  ),
                  maxLength: 25,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'value is Required';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    val = searchedValue(val: '$value');
                  },
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  onPressed: _savedis,
                  icon: Icon(Icons.post_add, color: Colors.white),
                  label: Text(
                    'post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ])
        ]),
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
    );
  }
}
