import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/view/screen/login_screen.dart';
import 'package:wts_customer/widget/commons.dart';

import 'home_page.dart';


class OnBoardingScreen extends StatefulWidget {
  static const pageId = '/OnBoardingPage';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    MySharedPreference.setBoolean(SharedPrefKey.ISONBOARDINGSHOWED, true);
    Get.offAllNamed(LoginScreen.pageId);
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => HomePage()),
    // );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }


  Widget _buildImage(String assetName, [double width = 350,double height = 250]) {
    return Image.asset('assets/$assetName', width: width,height: height,);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
     // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

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
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/onboarding.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child:  Image.asset(
                          "assets/wts_logo_white.png",
                          fit: BoxFit.none,
                        //  color: Colors.white,
                         // height: 40,
                          //width: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child:  IntroductionScreen(
                key: introKey,
                globalBackgroundColor: Colors.white,
                // globalHeader: Align(
                //   alignment: Alignment.topRight,
                //   child: SafeArea(
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 16, right: 16),
                //       child: _buildImage('logo.png', 100,100),
                //     ),
                //   ),
                // ),




                // globalFooter: Container(
                //   width: double.infinity,
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color: green
                //   ),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         primary: Colors.green[600],
                //         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                //         textStyle: TextStyle(
                //             fontSize: 30,
                //             fontWeight: FontWeight.bold)),
                //     child: const Text(
                //       'Let\s go right away!',
                //       style: TextStyle(fontSize: 16.0, color: white,fontWeight: FontWeight.bold),
                //     ),
                //     onPressed: () => _onIntroEnd(context),
                //   ),
                // ),
                pages: [
                  PageViewModel(
                    titleWidget: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold
                              ),
                              text: 'প্রথম ধাপ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              text: '\n\n মোবাইল নম্বর দিন',
                            ),
                          ],
                        )),
                    body:
                    "আমাদের সাথে নিবন্ধিত আপনার মোবাইল নম্বরের সাহায্যে খুব সহজে লগইন করে আপনার প্রফাইলে যান",
                    image: _buildImage('img1.png',),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold
                              ),
                              text: 'দ্বিতীয় ধাপ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              text: '\n\n অভিযোগ জানান',
                            ),
                          ],
                        )),
                    body:
                    "এ্যাপটির নিচের দিকে সবুজ রঙের গোল (+) বাটনের সাহায্যে অভিযোগ তৈরি করুন",
                    image: _buildImage('img2.png'),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    titleWidget: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold
                              ),
                              text: 'তৃতীয় ধাপ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              text: '\n\n  অভিযোগের অবস্থা জানুন',
                            ),
                          ],
                        )),
                    body:
                    "এ্যাপ থেকে যে কোন সময় যে কোন অভিযোগের অবস্থা জানুন খুব সহজে",
                    image: _buildImage('img3.png'),
                    decoration: pageDecoration,
                  ),
                  // PageViewModel(
                  //   title: "Full Screen Page",
                  //   body:
                  //       "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
                  //   image: _buildFullscrenImage(),
                  //   decoration: pageDecoration.copyWith(
                  //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                  //     fullScreen: true,
                  //     bodyFlex: 2,
                  //     imageFlex: 3,
                  //   ),
                  // ),
                  // PageViewModel(
                  //   title: "Another title page",
                  //   body: "Another beautiful body text for this example onboarding",
                  //   image: _buildImage('img2.png'),
                  //   footer: ElevatedButton(
                  //     onPressed: () {
                  //       introKey.currentState?.animateScroll(0);
                  //     },
                  //     child: const Text(
                  //       'FooButton',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.lightBlue,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //     ),
                  //   ),
                  //   decoration: pageDecoration,
                  // ),
                  // PageViewModel(
                  //   title: "Title of last page - reversed",
                  //   bodyWidget: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: const [
                  //       Text("Click on ", style: bodyStyle),
                  //       Icon(Icons.edit),
                  //       Text(" to edit a post", style: bodyStyle),
                  //     ],
                  //   ),
                  //   decoration: pageDecoration.copyWith(
                  //     bodyFlex: 2,
                  //     imageFlex: 4,
                  //     bodyAlignment: Alignment.bottomCenter,
                  //     imageAlignment: Alignment.topCenter,
                  //   ),
                  //   image: _buildImage('img1.png'),
                  //   reverse: true,
                  // ),
                ],
                onDone: () => _onIntroEnd(context),
                //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
                showSkipButton: true,
                dotsFlex: 0,
                nextFlex: 0,
                //rtl: true, // Display as right-to-left
                skip: const Text('Skip',style: TextStyle(fontWeight: FontWeight.w600,color: black)),
                next: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: StaticKey.APP_MAINCOLOR!),
                        color:  StaticKey.APP_MAINCOLOR,
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(Icons.arrow_forward,color: white,)),
                done:  Container(
                  height: 70,
                    width: 70,
                    decoration: BoxDecoration(

                        border: Border.all(width: 1, color: StaticKey.APP_MAINCOLOR!),
                        color:  StaticKey.APP_MAINCOLOR,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(child: Text('শুরু করুন', style: TextStyle(fontWeight: FontWeight.w600,color: white)))),
                curve: Curves.fastLinearToSlowEaseIn,
                controlsMargin: const EdgeInsets.all(16),
                controlsPadding: kIsWeb
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                dotsDecorator:  DotsDecorator(
                  size: Size(10.0, 10.0),
                  color: Color(0xFFBDBDBD),
                  activeColor: StaticKey.APP_MAINCOLOR,
                  activeSize: Size(22.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                // dotsContainerDecorator: const ShapeDecoration(
                //   color: Colors.black87,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //   ),
                // ),
              ))
             ,
            ],
          ),
        ),
      ),
    );
  }
}

