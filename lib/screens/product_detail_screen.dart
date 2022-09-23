import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prodR.dart';
import '../models/productReview.dart';
import '../providers/productReviewProv.dart';
import '../providers/wishlistProvider.dart';
import '../screens/prodRev.dart';
import '../providers/product.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var _isLoading = false;
  final _createFocusNode = FocusNode();
  var comment = ProdReview(
    product_id: 0,
    user_id: 0,
    value: '',
  );

  @override
  void dispose() {
    _createFocusNode.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await Provider.of<ProdRe>(context, listen: false).addComment(comment);
    } catch (error) {
      const errorMessage = 'Could not add comment. Please try again later.';
      _showErrorDialog(errorMessage);
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
    final wishes = Provider.of<Wishlist>(
      context,
      listen: false,
    );
    final Data = Provider.of<ProdRe>(context);
    final productId = ModalRoute.of(context)!.settings.arguments; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // SizedBox(height: 50),
            // Text(
            //   '\$${loadedProduct.price}',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   width: double.infinity,
            //   child: Text(
            //     loadedProduct.description,
            //     textAlign: TextAlign.center,
            //     softWrap: true,
            //   ),
            // ),
            // Divider(
            //   color: Colors.black26,
            //   height: 50,
            //   thickness: 6,
            //   endIndent: 20,
            //   indent: 20,
            // ),
            // Container(
            //comments
            // )

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
                        Text(
                          '${loadedProduct.description}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Name :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.title}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Text('Category :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.cat_id}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Price :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.price}',
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
                      Text('${loadedProduct.exp_date} ',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Text('Quantity :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.quantity} ',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                Divider(),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        wishes.addWiL(loadedProduct);
                        //   product.toggleFavoriteStatus(authData.logtoken);
                      },
                      color: Colors.blue,
                    ),
                  ),
                ]),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 160.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i) =>
                          prodRItem(w_item: Data.reviews[i], wishes: Data.com),
                      itemCount: Data.itemcount,
                    ),
                  ),
                ),

                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: 350,
                    alignment: Alignment.bottomCenter,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(3),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'add a comment',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.blueGrey),
                                    )),
                                TextFormField(
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_createFocusNode);
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  decoration: InputDecoration(
                                    suffixIcon: TextButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black26),
                                      ),
                                      onPressed: _savedis,
                                      icon: Icon(Icons.login,
                                          color: Colors.white),
                                      label: Text(
                                        'post',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    prefixIcon:
                                        Icon(Icons.email, color: Colors.white),
                                    hintText: '......',
                                    fillColor: Colors.black26,
                                    filled: true,
                                    semanticCounterText: 'comment ',
                                  ),
                                  maxLength: 25,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'comment is Required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    comment = ProdReview(
                                        product_id: loadedProduct.id,
                                        user_id: loadedProduct.user_id,
                                        value: '$value');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                )
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 390,
                //       height: 60,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           // child: TextFormField(
                //           //   decoration: InputDecoration(
                //           //     labelText: "Leave a review :",
                //           //     labelStyle:
                //           //         TextStyle(fontSize: 15, color: Colors.black),
                //           //     // hintText: "Write your review of the product",
                //           //     hintStyle:
                //           //         TextStyle(fontSize: 12, color: Colors.black),
                //           //   ),
                //           // ),
                //           child: IconButton(
                //             icon: Icon(Icons.add),
                //             onPressed: () {
                //               Navigator.of(context).pushNamed(
                //                   addProdComment.routeName,
                //                   arguments: productId);
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
