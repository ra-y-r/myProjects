import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/logIn.dart';
import '../screens/products_overview_screen.dart';
import '/constant.dart';

class createAccount extends StatefulWidget {
  static const routeName = '/signupPage';
  @override
  State<StatefulWidget> createState() {
    return _createAccountState();
  }
}

class _createAccountState extends State<createAccount> {
  String _name = '';
  String _email = '';
  String _password = '';
  String _passwordRepeat = '';
  String _facebook_url = '';
  String _phone_num = '';
  String _whatsapp_url = '';
  var _userInfo = user(
    role: '',
    name: '',
    email: '',
    password: '',
    passwordRepeat: '',
    facebook_url: '',
    phone_num: '',
    whatsapp_url: '',
  );
  var _isLoading = false;
  bool showWidget = false;
  final _createFocusNode = FocusNode();
  final _SeccreateFocusNode = FocusNode();

  @override
  void dispose() {
    _createFocusNode.dispose();
    _SeccreateFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          //     margin: EdgeInsets.all(3),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'UserName',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                decoration: TextDecoration.none),
                          )),
                      // SizedBox(
                      //   height: 1,
                      // ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_createFocusNode);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: 'Micheal_scott',
                          fillColor: Colors.blueGrey,
                          filled: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          semanticCounterText: 'Name',
                        ),
                        maxLength: 15,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is Required';
                          }
                          if (value.length < 3) {
                            return 'Name must be longer than 3';
                          }
                          _name == value;
                          return null;
                        },
                        onSaved: (value) {
                          _userInfo = user(
                              role: _userInfo.role,
                              name: '$value',
                              email: _userInfo.email,
                              password: _userInfo.password,
                              passwordRepeat: _userInfo.passwordRepeat,
                              facebook_url: _userInfo.facebook_url,
                              phone_num: _userInfo.phone_num,
                              whatsapp_url: _userInfo.whatsapp_url);
                        },
                      ),
                    ],
                  ),
                  //     SizedBox(height: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          //           margin: EdgeInsets.all(3),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'UserEmail',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                decoration: TextDecoration.none),
                          )),
                      // SizedBox(
                      //   height: 1,
                      // ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_SeccreateFocusNode);
                        },
                        focusNode: _createFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          hintText: 'Micheal_scott@dundirmifflen.com',
                          fillColor: Colors.blueGrey,
                          filled: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          semanticCounterText: 'Email',
                        ),
                        maxLength: 25,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          }

                          if (!value.contains('@')) {
                            return 'Please enter a valid email Address';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userInfo = user(
                              role: _userInfo.role,
                              name: _userInfo.name,
                              email: '$value',
                              password: _userInfo.password,
                              passwordRepeat: _userInfo.passwordRepeat,
                              facebook_url: _userInfo.facebook_url,
                              phone_num: _userInfo.phone_num,
                              whatsapp_url: _userInfo.whatsapp_url);
                        },
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          //           margin: EdgeInsets.all(3),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'role',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                decoration: TextDecoration.none),
                          )),
                      // SizedBox(
                      //   height: 1,
                      // ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_SeccreateFocusNode);
                        },
                        //  focusNode: _createFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          hintText: '',
                          fillColor: Colors.blueGrey,
                          filled: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          semanticCounterText: 'role',
                        ),
                        maxLength: 25,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'role is Required';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userInfo = user(
                              role: '$value',
                              name: _userInfo.name,
                              email: _userInfo.email,
                              password: _userInfo.password,
                              passwordRepeat: _userInfo.passwordRepeat,
                              facebook_url: _userInfo.facebook_url,
                              phone_num: _userInfo.phone_num,
                              whatsapp_url: _userInfo.whatsapp_url);
                        },
                      ),
                    ],
                  ),

                  //   SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                //  margin: EdgeInsets.all(3),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'password',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.blueGrey),
                                )),
                            // SizedBox(
                            //   height: 1,
                            // ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              onFieldSubmitted: (_) => {
                                //_savedis()
                              },
                              focusNode: _SeccreateFocusNode,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                hintText: '********',
                                fillColor: Colors.blueGrey,
                                filled: true,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                semanticCounterText: 'password',
                              ),
                              maxLength: 18,
                              onSaved: (value) {
                                _userInfo = user(
                                    role: _userInfo.role,
                                    name: _userInfo.name,
                                    email: _userInfo.email,
                                    password: '$value',
                                    passwordRepeat: _userInfo.passwordRepeat,
                                    facebook_url: _userInfo.facebook_url,
                                    phone_num: _userInfo.phone_num,
                                    whatsapp_url: _userInfo.whatsapp_url);
                              },
                              validator: (value) {
                                if (value == "") {
                                  return 'Please enter your password';
                                }

                                if (value!.length < 8) {
                                  return 'Password must be longer than 8';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                //  margin: EdgeInsets.all(3),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Repeat password',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.blueGrey),
                                )),
                            // SizedBox(
                            //   height: 1,
                            // ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              onFieldSubmitted: (_) => {_savedis()},
                              //    focusNode: _SeccreateFocusNode,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                hintText: '********',
                                fillColor: Colors.blueGrey,
                                filled: true,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                semanticCounterText: 'asword',
                              ),
                              maxLength: 18,
                              onSaved: (value) {
                                _userInfo = user(
                                    role: _userInfo.role,
                                    name: _userInfo.name,
                                    email: _userInfo.email,
                                    password: _userInfo.password,
                                    passwordRepeat: "$value",
                                    facebook_url: _userInfo.facebook_url,
                                    phone_num: _userInfo.phone_num,
                                    whatsapp_url: _userInfo.whatsapp_url);
                              },
                              validator: (value) {
                                if (value == "") {
                                  return 'Please enter your password';
                                }

                                if (value!.length < 8) {
                                  return 'Password must be longer than 8';
                                }
                                if (_password != _passwordRepeat) {
                                  return 'passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                //           margin: EdgeInsets.all(3),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      decoration: TextDecoration.none),
                                )),
                            // SizedBox(
                            //   height: 1,
                            // ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context)
                              //       .requestFocus(_SeccreateFocusNode);
                              // },
                              //   focusNode: _createFocusNode,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.facebook,
                                    color: Colors.white),

                                //    hintText: 'Micheal_scott@dundirmifflen.com',
                                fillColor: Colors.blueGrey,
                                filled: true,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                semanticCounterText: 'facebook Url',
                              ),
                              maxLength: 15,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'facebook Url is Required';
                                }

                                if (!value.contains('@')) {
                                  return 'Please enter a valid facebook Url Address';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _userInfo = user(
                                    role: _userInfo.role,
                                    name: _userInfo.name,
                                    email: _userInfo.email,
                                    password: _userInfo.password,
                                    passwordRepeat: _userInfo.passwordRepeat,
                                    facebook_url: "$value",
                                    phone_num: _userInfo.phone_num,
                                    whatsapp_url: _userInfo.whatsapp_url);
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                //           margin: EdgeInsets.all(3),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      decoration: TextDecoration.none),
                                )),
                            // SizedBox(
                            //   height: 1,
                            // ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context)
                              //       .requestFocus(_SeccreateFocusNode);
                              // },
                              // focusNode: _createFocusNode,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.whatsapp,
                                    color: Colors.white),
                                //     hintText: 'Micheal_scott@dundirmifflen.com',
                                fillColor: Colors.blueGrey,
                                filled: true,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                //   semanticCounterText: 'Email',
                              ),
                              maxLength: 15,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Whastapp Url is Required';
                                }

                                // if (!value.contains('@')) {
                                //   return 'Please enter a valid Whastapp Url  Address';
                                // }

                                return null;
                              },
                              onSaved: (value) {
                                _userInfo = user(
                                    role: _userInfo.role,
                                    name: _userInfo.name,
                                    email: _userInfo.email,
                                    password: _userInfo.password,
                                    passwordRepeat: _userInfo.passwordRepeat,
                                    facebook_url: _userInfo.facebook_url,
                                    phone_num: _userInfo.phone_num,
                                    whatsapp_url: '$value');
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                //           margin: EdgeInsets.all(3),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      decoration: TextDecoration.none),
                                )),
                            // SizedBox(
                            //   height: 1,
                            // ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context)
                              //       .requestFocus(_SeccreateFocusNode);
                              // },
                              // focusNode: _createFocusNode,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.phone,
                                    color: Colors.white),
                                //hintText: 'Micheal_scott@dundirmifflen.com',
                                fillColor: Colors.blueGrey,
                                filled: true,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                semanticCounterText: 'phone number ',
                              ),
                              maxLength: 15,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'phone number is Required';
                                }

                                // if (!value.contains('@')) {
                                //   return 'Please enter a valid phone number  Address';
                                // }

                                return null;
                              },
                              onSaved: (value) {
                                _userInfo = user(
                                    role: _userInfo.role,
                                    name: _userInfo.name,
                                    email: _userInfo.email,
                                    password: _userInfo.password,
                                    passwordRepeat: _userInfo.passwordRepeat,
                                    facebook_url: _userInfo.facebook_url,
                                    phone_num: '$value',
                                    whatsapp_url: _userInfo.whatsapp_url);
                              },
                            ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //   onPressed: null,
                      //   icon: Icon(Icons.facebook),
                      // ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       showWidget = !showWidget;
                      //     });
                      //   },
                      //   child: showWidget
                      //       ? TextFormField(
                      //           autovalidateMode: AutovalidateMode.always,
                      //           onFieldSubmitted: (_) {
                      //             FocusScope.of(context)
                      //                 .requestFocus(_createFocusNode);
                      //           },
                      //           decoration: InputDecoration(
                      //             prefixIcon: Icon(
                      //               Icons.person,
                      //               color: Colors.blue.shade900,
                      //             ),
                      //             hintText: 'Micheal_scott',
                      //             fillColor: c3,
                      //             filled: true,
                      //             // border: OutlineInputBorder(
                      //             //   borderRadius: BorderRadius.circular(20),
                      //             // ),
                      //             semanticCounterText: 'Name',
                      //           ),
                      //           maxLength: 10,
                      //           validator: (value) {
                      //             if (value!.isEmpty) {
                      //               return 'Name is Required';
                      //             }
                      //             if (value.length < 3) {
                      //               return 'Name must be longer than 3';
                      //             }

                      //             return null;
                      //           },
                      //           onSaved: (value) {
                      //             _Username == value;
                      //           },
                      //         )
                      //       : IconButton(
                      //           onPressed: null,
                      //           icon: const Icon(FontAwesomeIcons.facebook,
                      //               color: Colors.blue),
                      //         ),
                      // ),

                      // FloatingActionButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       showWidget = !showWidget;
                      //     });
                      //   },
                      //   child: // showWidget
                      //       //     ? TextFormField(
                      //       //         autovalidateMode: AutovalidateMode.always,
                      //       //         onFieldSubmitted: (_) {
                      //       //           FocusScope.of(context)
                      //       //               .requestFocus(_createFocusNode);
                      //       //         },
                      //       //         decoration: InputDecoration(
                      //       //           prefixIcon: Icon(
                      //       //             Icons.person,
                      //       //             color: Colors.blue.shade900,
                      //       //           ),
                      //       //           hintText: 'Micheal_scott',
                      //       //           fillColor: c3,
                      //       //           filled: true,
                      //       //           // border: OutlineInputBorder(
                      //       //           //   borderRadius: BorderRadius.circular(20),
                      //       //           // ),
                      //       //           semanticCounterText: 'Name',
                      //       //         ),
                      //       //         maxLength: 10,
                      //       //         validator: (value) {
                      //       //           if (value!.isEmpty) {
                      //       //             return 'Name is Required';
                      //       //           }
                      //       //           if (value.length < 3) {
                      //       //             return 'Name must be longer than 3';
                      //       //           }

                      //       //           return null;
                      //       //         },
                      //       //         onSaved: (value) {
                      //       //           _Username == value;
                      //       //         },
                      //       //       )
                      //       //     :
                      //       IconButton(
                      //     onPressed: null,
                      //     icon: const Icon(FontAwesomeIcons.facebook,
                      //         color: Colors.blue),
                      //   ),
                      // ),

                      // FloatingActionButton(
                      //   onPressed: null,
                      //   isExtended: true,
                      // ),
                      // FloatingActionButton(
                      //   onPressed: null,
                      //   isExtended: true,
                      // )
                      // IconButton(
                      //     onPressed: null,
                      //     icon: const Icon(FontAwesomeIcons.facebook,
                      //         color: Colors.blue)),

                      // Spacer(),
                      // IconButton(
                      //     onPressed: null,
                      //     icon: const Icon(FontAwesomeIcons.whatsapp,
                      //         color: Colors.green)),
                      // Spacer(),
                      // IconButton(
                      //     onPressed: null,
                      //     icon: const Icon(FontAwesomeIcons.phone,
                      //         color: Colors.blue)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget _banner() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(4),
          child: Text(
            ' Let\'s Get Started!',
            style: TextStyle(color: Colors.blueGrey),
            textScaleFactor: 2,
          ),
        ),
        // Container(
        //   margin: EdgeInsets.all(3),
        //   child: Text('Sign Up And We\'ll continue'),
        // ),
      ],
    );
  }

  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      //_regData['name'] = _name;
      // _regData['email'] = _email;
      // _regData['password'] = _password;
      // _regData['c_password'] = _passwordRepeat;
      // _regData['facebook_url'] = _facebook_url;
      // _regData['phone_num'] = _phone_num;
      // _regData['whatsapp_url'] = _whatsapp_url;
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await Provider.of<Auth>(context, listen: false).signup(_userInfo);
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

    // await Provider.of<Auth>(context, listen: false).signup(_name, _email,
    //     _password, _passwordRepeat, _facebook_url, _phone_num, _whatsapp_url);
    setState(() {
      _isLoading = false;
    });

    //   _formKey1.currentState!.save();
    // _formKey2.currentState!.save();
//loading spinner
  }

  @override
  Widget build(BuildContext context) {
    Color c2 = const Color(0XFF7884cc);
    Color c3 = const Color(0XFF96a8ff);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            //   margin: EdgeInsets.all(44),
            child: Stack(
          children: [
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
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45))),
                    child: SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.09),
                                child: LottieBuilder.asset(
                                    "assets/animations/user-profile-.json"),
                              ),
                              Form(
                                //   key: _formKey,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // SizedBox(height: 80),
                                    _banner(),
                                    frm(),
                                    //   SizedBox(height: 30),
                                    // CheckerBox(),
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
                                        icon: Icon(Icons.create,
                                            color: Colors.white),
                                        label: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.18,
                                    top: MediaQuery.of(context).size.height *
                                        0.08),
                                child: Text.rich(
                                  TextSpan(
                                      text: "I already Have an account ",
                                      style: TextStyle(
                                          color: grayshade.withOpacity(0.8),
                                          fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text: "Sign In",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.of(context)
                                                    .pushNamed(logIN.routeName);
                                              }),
                                      ]),
                                ),
                              ),
                            ]))))),
          ],
        )),
      ),
    );
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
}

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  bool? isCheck;
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: whiteshade, // color of tick Mark
              activeColor: blue,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
                text: "I agree with ",
                style:
                    TextStyle(color: grayshade.withOpacity(0.8), fontSize: 16),
                children: [
                  TextSpan(
                      text: "Terms ",
                      style: TextStyle(color: blue, fontSize: 16)),
                  const TextSpan(text: "and "),
                  TextSpan(
                      text: "Policy",
                      style: TextStyle(color: blue, fontSize: 16)),
                ]),
          ),
        ],
      ),
    );
  }
}
