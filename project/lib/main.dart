import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/providers/searchProvider.dart';

import 'providers/auth.dart';
import 'providers/cart_provider..dart';
import 'providers/ordersProvide.dart';
import 'providers/postCommentProvider.dart';
import 'providers/postsProvider.dart';
import 'providers/productReviewProv.dart';
import 'providers/products_provider.dart';
import 'providers/storyProv.dart';
import 'providers/wishlistProvider.dart';
import 'screens/cart_screen.dart';
import 'screens/createAccount.dart';
import 'screens/createPost.dart';
import 'screens/first-time-user/liquid-swipe.dart';
import 'screens/logIn.dart';
import 'screens/ordersScreen.dart';
import 'screens/postComments.dart';
import 'screens/postsScreen.dart';
import 'screens/prodRev.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_details.dart';
import 'screens/products_overview_screen.dart';
import 'screens/searchfilter.dart';
import 'screens/searchresult.dart';
import 'screens/storyScreen.dart';
import 'screens/user_products_screen.dart';
import 'screens/wishlist.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final showhome = pref.getBool("showhome") ?? false;

  runApp(MyApp(
    sharedPreferences: pref,
    showhome: showhome,
  ));
}

class MyApp extends StatelessWidget {
  final bool showhome;
  final SharedPreferences sharedPreferences;

  MyApp({
    required this.sharedPreferences,
    Key? key,
    required this.showhome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c1 = const Color(0x0099b898);

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: Auth(),
        // ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', []),
            update: (ctx, auth, previousProducts) => Products(auth.logtoken,
                previousProducts == null ? [] : previousProducts.items)),
// ChangeNotifierProxyProvider<Auth, Products>(

//     create: (ctx) => Products(),
//     update: (ctx, auth, previousProducts) => previousProducts!
//     /.update(auth.token,
//     previousProducts.items == null ?  : previousProducts.items),
//   ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', []),
          update: (ctx, auth, previousOrders) => Orders(auth.logtoken,
              previousOrders == null ? [] : previousOrders.orders),
        ),

        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Wishlist>(
          create: (ctx) => Wishlist('', []),
          update: (ctx, auth, previousOrders) => Wishlist(auth.logtoken,
              previousOrders == null ? [] : previousOrders.wishs),
        ),
        ChangeNotifierProxyProvider<Auth, Posts>(
          create: (ctx) => Posts('', []),
          update: (ctx, auth, previousOrders) => Posts(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),

        ChangeNotifierProxyProvider<Auth, Pcomment>(
          create: (ctx) => Pcomment('', []),
          update: (ctx, auth, previousOrders) => Pcomment(
              auth.logtoken, previousOrders == null ? [] : previousOrders.com),
        ),
        ChangeNotifierProxyProvider<Auth, story>(
          create: (ctx) => story('', []),
          update: (ctx, auth, previousOrders) => story(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),
        ChangeNotifierProxyProvider<Auth, ProdRe>(
          create: (ctx) => ProdRe('', []),
          update: (ctx, auth, previousOrders) => ProdRe(
              auth.logtoken, previousOrders == null ? [] : previousOrders.com),
        ),
        ChangeNotifierProxyProvider<Auth, SearchProv>(
          create: (ctx) => SearchProv('', []),
          update: (ctx, auth, previousOrders) => SearchProv(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, ath, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: productsOverviewScreen(),
          theme: ThemeData(
            fontFamily: 'Caveat-SemiBold',
          ),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme(),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.amber,
              secondary: Colors.amber,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.light,
          routes: {
            //     addPostComment.routeName: (context) => addPostComment(),
            P_ComScreen.routeName: (context) => P_ComScreen(),
            Details.routeName: (context) => Details(),
            WishlistScreen.routeName: (context) => WishlistScreen(),
            createAccount.routeName: (context) => createAccount(),
            logIN.routeName: (context) => logIN(),
            ordersScreen.routeName: (context) => ordersScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            // EditProductScreen.routeName: (ctx) => EditProductScreen(),
            productsOverviewScreen.routeName: (ctx) => productsOverviewScreen(),
            postScreen.routeName: (ctx) => postScreen(),
            liquid_swipe_sc.routeName: (ctx) => liquid_swipe_sc(),
            createPost.routeName: (ctx) => createPost(),
            storyScreen.routeName: (ctx) => storyScreen(),
            addProdComment.routeName: (ctx) => addProdComment(),
            searchS.routeName: (ctx) => searchS(),
            searchScreen.routeName: (ctx) => searchScreen(),
          },
        ),
      ),
    );
  }
}
