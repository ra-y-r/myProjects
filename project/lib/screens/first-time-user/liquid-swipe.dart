import 'package:shared_preferences/shared_preferences.dart';
import '../createAccount.dart';
import '../logIn.dart';

import '/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class liquid_swipe_sc extends StatefulWidget {
  const liquid_swipe_sc({Key? key}) : super(key: key);
  static const routeName = '/liquid';

  @override
  State<liquid_swipe_sc> createState() => _liquid_swipe_scState();
}

class _liquid_swipe_scState extends State<liquid_swipe_sc> {
  final controller = LiquidController();
  bool islastPage = false;
  Color c3 = const Color(0XFF96a8ff);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              liquidController: controller,
              enableSideReveal: true,
              onPageChangeCallback: (index) {
                setState(() => islastPage = index == 3);
              },
              slideIconWidget: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              pages: [
                buildpage(
                    color: Colors.blueGrey,
                    Image: "assets/animations/30826-online-shopping.json",
                    title: ' find what you need easily',
                    subtitle:
                        "offering large number of products that will match your demand and more"),
                buildpage(
                    color: Colors.blueGrey,
                    Image: "assets/animations/man.json",
                    title: 'expand your buisness  ',
                    subtitle:
                        "manage your store effectivly with the help of our app"),
                buildpage(
                    color: Colors.blueGrey,
                    Image: "assets/animations/del.json",
                    title: 'reach millions of users around the globe',
                    subtitle: " create a trustworthy relation with clients "),
                buildpage(
                    color: Colors.blueGrey,
                    Image: "assets/animations/team.json",
                    title: 'keep up with the new trends  ',
                    subtitle: "and stay updated about salles"),
                // Container(
                //   color: Colors.purple,
                //   child: const Center(
                //     child: Text('p 3'),
                //   ),
                // ),
              ]),
          Positioned(
              bottom: 0,
              left: 16,
              right: 32,
              child: islastPage
                  ? TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool("showhome", true);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => createAccount(),
                          ),
                        );
                      },
                      child: const Text(
                        "get started",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Caveat-Bold"),
                        textScaleFactor: 2,
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.jumpToPage(page: 3);
                            },
                            child: const Text(
                              'skip',
                              style: TextStyle(color: Colors.white),
                            )),
                        AnimatedSmoothIndicator(
                            activeIndex: controller.currentPage,
                            count: 4,
                            effect: const WormEffect(
                                spacing: 16,
                                dotColor: Colors.black38,
                                activeDotColor: Colors.black),
                            onDotClicked: (index) {
                              controller.animateToPage(page: index);
                            }),
                        TextButton(
                            onPressed: () {
                              final page = controller.currentPage + 1;
                              controller.animateToPage(
                                page: page > 4 ? 0 : page,
                                duration: 400,
                              );
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ))
        ],
      ),
    );
  }
}

Widget buildpage(
    {required Color color,
    required String Image,
    required String title,
    required String subtitle}) {
  return Container(
    color: color,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          child: LottieBuilder.asset(
            Image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          padding: const EdgeInsets.only(right: 32),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}
