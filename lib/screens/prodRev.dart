// ignore: file_names
import '../models/postComment.dart';
import '../models/productReview.dart';
import '../providers/postCommentProvider.dart';
import '../providers/postsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productReviewProv.dart';
import '../providers/products_provider.dart';

class addProdComment extends StatefulWidget {
  static const routeName = '/addProdComm';
  @override
  State<StatefulWidget> createState() {
    return _addProdCommentState();
  }
}

class _addProdCommentState extends State<addProdComment> {
  var _isLoading = false;
  final _createFocusNode = FocusNode();
  var comment = ProdReview(product_id: 0, user_id: 0, value: '');

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
    final prodId = ModalRoute.of(context)!.settings.arguments; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(prodId.toString());
    Color c2 = const Color(0XFF7884cc);
    Color c3 = const Color(0XFF96a8ff);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(children: [
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
                        FocusScope.of(context).requestFocus(_createFocusNode);
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        hintText: '......',
                        fillColor: Colors.blueGrey,
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
                            user_id: 0,
                            value: '$value');
                      },
                    ),
                    SizedBox(height: 10),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      (TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blueGrey),
                        ),
                        onPressed: _savedis,
                        icon: Icon(Icons.login, color: Colors.white),
                        label: Text(
                          'post',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ))
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
