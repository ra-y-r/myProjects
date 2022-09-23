// ignore: file_names
import '../models/logged.dart';
import '../screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../screens/createAccount.dart';
import '/constant.dart';

class logIN extends StatefulWidget {
  static const routeName = '/logInPage';
  @override
  State<StatefulWidget> createState() {
    return _logINState();
  }
}

class _logINState extends State<logIN> {
  late String _Username;
  String _email = '';
  late String _password;
  String _passwordRepeat = '';
  var _isLoading = false;
  final _createFocusNode = FocusNode();
  final _SeccreateFocusNode = FocusNode();
  var _authData = logged(
    email: '',
    password: '',
  );
  @override
  void dispose() {
    _createFocusNode.dispose();
    _SeccreateFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  @override
  Widget frm() {
    Color c3 = const Color(0XFF96a8ff);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //       SizedBox(height: 2),

                  //     SizedBox(height: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(3),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'UserEmail',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.blueGrey),
                          )),
                      //  SizedBox(
                      //  height: 10,
                      //),
                      TextFormField(
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_createFocusNode);
                        },
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          hintText: 'Micheal_scott@dundirmifflen.com',
                          fillColor: Colors.blueGrey,
                          filled: true,
                          semanticCounterText: 'Email',
                        ),
                        maxLength: 25,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          }

                          if (!value.contains('@')) {
                            return 'Please enter a valid email Address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData = logged(
                              email: '$value', password: _authData.password);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(3),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'password',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.blueGrey),
                          )),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_SeccreateFocusNode);
                        },
                        focusNode: _createFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          hintText: '********',
                          fillColor: Colors.blueGrey,
                          filled: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          semanticCounterText: 'password',
                        ),
                        maxLength: 15,
                        onSaved: (value) {
                          _authData = logged(
                              email: _authData.email, password: '$value');
                        },
                        validator: (value) {
                          if (value == "") {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget _banner() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            ' Welcome back!',
            style: TextStyle(color: Colors.blueGrey),
            textScaleFactor: 2,
          ),
        ),
        // Container(
        //   margin: EdgeInsets.all(6),
        //   child: Text('Please Enter your Email '),
        // ),
      ],
    );
  }

  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await Provider.of<Auth>(context, listen: false).login(_authData).then(
          (value) => Navigator.of(context)
              .pushNamed(productsOverviewScreen.routeName));
      ;
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
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
    Color c2 = const Color(0XFF7884cc);
    Color c3 = const Color(0XFF96a8ff);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: whiteshade,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                // margin: EdgeInsets.all(44),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09),
                        child:
                            LottieBuilder.asset("assets/animations/login.json"),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: 70),
                              _banner(),
                              //   SizedBox(height: 30),
                              frm(),
                              //    CheckerBox(),
                              SizedBox(height: 10),
                              if (_isLoading)
                                CircularProgressIndicator()
                              else
                                (TextButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey),
                                  ),
                                  onPressed: () {
                                    _savedis();
                                  },
                                  icon: Icon(Icons.login, color: Colors.white),
                                  label: Text(
                                    'log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.149,
                            top: MediaQuery.of(context).size.height * 0.08),
                        child: Text.rich(
                          TextSpan(
                              text: "Don't  Have an account already? ",
                              style: TextStyle(
                                  color: grayshade.withOpacity(0.8),
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamed(createAccount.routeName);
                                      }),
                              ]),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
