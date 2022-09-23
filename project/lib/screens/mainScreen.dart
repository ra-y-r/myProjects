import 'package:flutter/material.dart';

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text(
            'Yummy corner',
            textAlign: TextAlign.start,
          ),
          /*Image.asset(
            //fixlater
            'assets/logo.png',
            alignment: Alignment.topLeft,
            height: 99.0,
            width: 99.0,
          ), */
          actions: <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.location_on),
            ),
            /* IconButton(
              onPressed: null,
              icon: Icon(Icons.shopping_cart_rounded),
            ), */
            IconButton(
              onPressed: null,
              icon: Icon(Icons.account_circle),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.access_alarm),
                          label: Text('f'))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: null,
                icon: Icon(Icons.location_on),
              ),
              actions: [
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.lock),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
