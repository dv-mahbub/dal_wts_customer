import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wts_customer/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/widget/TextCommon.dart';
import 'package:wts_customer/widget/TextFieldCommon.dart';
import 'package:wts_customer/widget/button_common.dart';
import 'package:wts_customer/widget/commons.dart';

class LoginScreen extends StatefulWidget {
  static const pageId = '/loginScreen';

  const LoginScreen() : super();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticKey.APP_MAINCOLOR,
      body: Obx(
        () => SafeArea(
          child: LoadingOverlay(
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
                                "assets/login_screen_logo.png",
                                fit: BoxFit.fill,
                                //  color: Colors.white,
                                  height: 60,
                                 width: 180,
                                //width: 200,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ],
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextCommon(
                                title: AppStringKey.mobile_number.tr,
                                fontSize: 20.0,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFieldCommon(
                                  controller: auth.mobileNumberCon,
                                  hint: AppStringKey.mobile_number.tr,
                                  icon: Icon(
                                    Icons.phone,
                                    color: green,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  errorText: auth.loginError.value),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: TextButtonCommon(
                                  backgroundColor: StaticKey.APP_MAINCOLOR,
                                  text: AppStringKey.login.tr,
                                  callBack: () async {
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    //  await auth.login('admin@domain.com', '12345678');
                                    await auth.login(
                                        auth.mobileNumberCon.text.trim().toString());

                                    switch (auth.status.value) {
                                      case Status.LOADING:
                                        print(
                                            '..............LOADING LOADING..................');
                                        break;
                                      case Status.SUCCESS:
                                        print(
                                            '..............SUCCESS SUCCESS..................');
                                        break;
                                      case Status.ERROR:
                                        print(
                                            '..............APIERROR APIERROR..................');
                                        break;
                                    }
                                  },
                                ),
                              ),


                              SizedBox(
                                height: 150,
                              ),

                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                child: Center(
                                  child:  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(color: Colors.black,),
                                            text: '${'For Emergency  Contact'}: ${StaticKey.SUPPORT_NUMBER}\n\n',
                                          ),
                                          TextSpan(
                                            style: TextStyle(color: Colors.green[600],fontWeight: FontWeight.normal),
                                            text: 'Copyright © Wood Tech Solution\n\n',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url = StaticKey.WEBSITE_URL_WOOD_TECH_SOLUTIONS;
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceSafariVC: false,
                                                  );
                                                }
                                              },
                                          ),
                                          TextSpan(
                                            style: TextStyle(color: Colors.grey,),
                                            text: 'Powered By',
                                          ),
                                          TextSpan(
                                            style: TextStyle(color: Colors.grey,),
                                            text: '\tDHAKAapps',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url = StaticKey.WEBSITE_URL;
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceSafariVC: false,
                                                  );
                                                }
                                              },
                                          ),


                                        ],
                                      )),

                                  // Text(
                                  //   'Copyright © Wood Tech Solution\nPowered By DHAKAapps',
                                  //   style: TextStyle(
                                  //       color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading: Get.find<AuthController>().isLoading.value),
        ),
      ),
      // bottomSheet: Container(
      //   color: Colors.white,
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   width: double.infinity,
      //   height: 50,
      //   child: Center(
      //     child:  RichText(
      //         textAlign: TextAlign.center,
      //         text: TextSpan(
      //           children: [
      //             TextSpan(
      //               style: TextStyle(color: Colors.grey,),
      //               text: 'Copyright © Wood Tech Solution\n',
      //             ),
      //             TextSpan(
      //               style: TextStyle(color: Colors.grey,),
      //               text: 'Powered By',
      //             ),
      //             TextSpan(
      //               style: TextStyle(color: Colors.green[600],),
      //               text: '\tDHAKAapps',
      //               recognizer: TapGestureRecognizer()
      //                 ..onTap = () async {
      //                   final url = StaticKey.WEBSITE_URL;
      //                   if (await canLaunch(url)) {
      //                     await launch(
      //                       url,
      //                       forceSafariVC: false,
      //                     );
      //                   }
      //                 },
      //             ),
      //
      //             TextSpan(
      //               style: TextStyle(color: Colors.black,),
      //               text: '\n\n${'For Emergency  Contact'}: 01914252536',
      //             ),
      //           ],
      //         )),
      //
      //     // Text(
      //     //   'Copyright © Wood Tech Solution\nPowered By DHAKAapps',
      //     //   style: TextStyle(
      //     //       color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      //     // ),
      //   ),
      // ),
    );
  }
}
