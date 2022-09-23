// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'createAccount.dart';
// import 'logIn.dart';

// class secScreen extends StatefulWidget {
//   const secScreen({Key? key}) : super(key: key);

//   @override
//   State<secScreen> createState() => _secScreenState();
// }

// class _secScreenState extends State<secScreen> with TickerProviderStateMixin {
//   late AnimationController _cartController;
//   bool shop = false;
//   bool textReady = false;

//   @override
//   void initState() {
//     super.initState();
//     _cartController = AnimationController(
//       vsync: this,
//     );
//     _cartController.addListener(() {
//       if (_cartController.value > 0.7) {
//         _cartController.stop();
//         shop = true;
//         setState(() {});
//         Future.delayed(const Duration(seconds: 3), () {
//           textReady = true;
//           setState(() {});
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _cartController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       body: Stack(
//         children: [
//           Visibility(
//             child: const BottomPart(),
//             visible: shop,
//           ),
//           AnimatedContainer(
//             height: shop ? (height / 1.45) : height,
//             duration: const Duration(seconds: 3),
//             decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                       offset: Offset(3, 3),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       color: Colors.black26)
//                 ],
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(shop ? 25.0 : 0.0),
//                     bottomRight: Radius.circular(shop ? 25.0 : 0.0)),
//                 color: Colors.white10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 AnimatedCrossFade(
//                   firstChild:
//                       Lottie.asset('assets/animations/75585-scooter.json'),
//                   secondChild: Lottie.asset(
//                       'assets/animations/30826-online-shopping.json',
//                       controller: _cartController,
//                       height: height / 2, onLoaded: (composition) {
//                     _cartController.duration = composition.duration;
//                     _cartController.forward();
//                   }),
//                   crossFadeState: shop
//                       ? CrossFadeState.showFirst
//                       : CrossFadeState.showSecond,
//                   duration: const Duration(seconds: 3),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomPart extends StatelessWidget {
//   const BottomPart({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'you order , we deliver!',
//               style: TextStyle(
//                   fontFamily: 'Caveat',
//                   fontSize: 27.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black45),
//             ),
//             const SizedBox(height: 10.0),
//             const SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: TextButton.icon(
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushNamed(createAccount.routeName);
//                       },
//                       icon: Icon(
//                         Icons.person_add,
//                         color: Colors.black,
//                       ),
//                       label: Text(
//                         'Sign up',
//                         style:
//                             TextStyle(fontFamily: 'Lato', color: Colors.black),
//                       )),
//                 ),
//                 SizedBox(width: 16),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: TextButton.icon(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed(logIN.routeName);
//                       },
//                       icon: Icon(
//                         Icons.person,
//                         color: Colors.black,
//                       ),
//                       label: Text(
//                         'Login ',
//                         style:
//                             TextStyle(fontFamily: 'Lato', color: Colors.black),
//                       )),
//                 )
//               ],
//             ),
//             const SizedBox(height: 50.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
