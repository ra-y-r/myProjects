import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider..dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final num price;
  final String imageUrl;
  final num quantity;
  final String title;

  CartItems(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Confirm',
              style: TextStyle(
                fontFamily: 'caveat',
              ),
            ),
            content: Text('do you want to remove the item'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('NO')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('YES'))
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(imageUrl),
            // CircleAvatar(
            //   radius: 100,
            //   child: Padding(
            //     padding: EdgeInsets.all(1),
            //     child: CircleAvatar(
            //       radius: 40,
            //       backgroundImage: NetworkImage(
            //         imageUrl,
            //       ),
            //     ),
            //   ),
            // ),

            title: Text(title),

            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: // Column(
                //   children: [
                // IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.plus_one),
                // ),
                Text('$quantity x'),
            // IconButton(
            //   onPressed: null,
            //   icon: Icon(Icons.minimize),
            // ),
            //],
            //)
          ),
        ),
      ),
    );
  }
}
