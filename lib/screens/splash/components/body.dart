import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:e_commerce_app/screens/splash/components/splash_content.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> _splashData = [
    {"text": "Welcome to our shop", "image": "assets/images/splash_1.png"},
    {
      "text": "We help people connect with store \naround Viet Nam",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Just stay at home and click",
      "image": "assets/images/splash_3.png"
    },
  ];

  // init states
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: _splashData.length,
                itemBuilder: (context, index) {
                  return SplashContent(
                    text: _splashData[index]["text"],
                    image: _splashData[index]["image"],
                  );
                },
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          _splashData.length, (index) => createDot(index)),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    DefaultButton(
                      text: "Continue",
                      handleOnPress: () {
                        Navigator.pushNamed(
                          context,
                          AuthenticaitonWrapper.routeName,
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer createDot(int index) {
    return AnimatedContainer(
        duration: mAnimationDuration,
        margin: EdgeInsets.only(right: 5),
        height: 6,
        width: _currentPage == index ? 20 : 6,
        decoration: BoxDecoration(
          color: _currentPage == index ? mPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(_currentPage == index ? 8 : 3),
        ));
  }
}
