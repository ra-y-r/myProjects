import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart_provider..dart';
import '../providers/ordersProvide.dart';
import '../widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cartt';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontFamily: 'Caveat-Medium',
            color: Color(0XFFFFF9900),
          ),
          textAlign: TextAlign.start,
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'total',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Caveat-Medium',
                      color: Color(0XFFFFF9900),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.TotalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Caveat-Medium',
                        color: Color(0XFFFFF9900),
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  orderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              //shrinkWrap: true,
              itemBuilder: (context, i) => CartItems(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].imageUrl,
              ),
              itemCount: cart.itemcount,
            ),
          ),
        ],
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.TotalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(
                context,
                listen: false,
              ).addOrder(
                  widget.cart.items.values.toList(), widget.cart.TotalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Text(
              'ORDER NOW',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Caveat-Medium',
                color: Color(0XFFFFF9900),
              ),
            ),
    );
  }
}
