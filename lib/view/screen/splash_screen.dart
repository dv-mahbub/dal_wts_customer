import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/view/screen/home_page.dart';
import 'package:wts_customer/view/screen/login_screen.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const pageId = "/splashscreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var screenMaxWidth, screenMaxHeight;
  var _height, _width, _imageHeight, _imageWidth, _fontSize;
  Color _backgroundColor = Colors.white, _fontColor = Colors.red;
  var _opacity = 0.0;
  late Timer _timer;
  int _start = 1;

  @override
  void initState() {
    startTimer();
    startTimerForGoingNextScreen();
    _height = 100.0;
    _width = 150.0;
    _imageHeight = 0.0;
    _imageWidth = 0.0;
    _fontSize = 5.0;
  }

  @override
  Widget build(BuildContext context) {
    screenMaxWidth = MediaQuery.of(context).size.width;
    screenMaxHeight = MediaQuery.of(context).size.height;

    //
    return Scaffold(
     backgroundColor: StaticKey.APP_MAINCOLOR,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 320,
                   //   margin: EdgeInsets.symmetric(horizontal: -20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/splash_screen_top.png"),
                          fit: BoxFit.fill,
                        ),
                       // color: Colors.green
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: Stack(
                          children: [
                            Center(
                                child: Image.asset(
                                  "assets/splash_round.png",
                                  fit: BoxFit.fill,
                                  //  color: Colors.white,
                                  // height: 80,
                                  // width: 200,
                                  //width: 200,
                                )
                            ),
                            Positioned(child: Center(
                              child: Image.asset(
                                "assets/splash_screen_logo.png",
                                fit: BoxFit.fill,
                              //  color: Colors.black,
                                 height: 50,
                                 width: 150,
                                //width: 200,
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('সকল  ধরণের দরজা ও ফার্ণিচার তৈরির মেশিনারিজ এবং কাটার এক্সেসরিজের এক বিশ্বস্ত প্রতিষ্ঠান',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,
                            color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              Expanded(
              child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                margin: EdgeInsets.all(10),
                height: _height,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(
                      "assets/splash_body_icon.png",
                      fit: BoxFit.fill,
                    //  color: Colors.black,
                      // height: 80,
                      // width: 200,
                      //width: 200,
                    ),
                    SizedBox(height: 10,),
                    Text('Wood Tech Solution',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14,
                          color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
              ))
            ],
          ),
        ),
      )
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _timer.cancel();
          setState(() {
            timer.cancel();

            print(
                ".........................................timer..........................................");
            _backgroundColor = Colors.white;
            _height = screenMaxHeight;
            _width = screenMaxWidth;
            _imageHeight = 100.0;
            _imageWidth = 100.0;
            _fontSize = 25.0;
            _fontColor = Colors.black;
            _opacity = 1.0;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void startTimerForGoingNextScreen() {
    var _start = 3;
    const oneSec = const Duration(seconds: 1);
    var _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_start == 0) {
            timer.cancel();
            MySharedPreference.getBoolean(SharedPrefKey.ISONBOARDINGSHOWED)
                .then((value) => {
                      if (value == true)
                        {
                          MySharedPreference.getBoolean(SharedPrefKey.ISLOGIN)
                              .then((value) => {
                                if (value == true) {
                                  Get.offNamed(HomePage.pageId)
                                } else {
                                  Get.offNamed(LoginScreen.pageId)
                                }}),
                          //    Navigator.push(context,  MaterialPageRoute(builder: (_)=>OnBoardingScreen()));
                        }
                      else
                        {
                          Get.offNamed(OnBoardingScreen.pageId)
                        }
                    });
          } else {
            setState(() {
              _start--;
            });
          }
        });
      },
    );
  }
}
