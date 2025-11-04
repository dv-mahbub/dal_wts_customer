import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wts_customer/controller/auth_controller.dart';
import 'package:wts_customer/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:wts_customer/model/login_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/login_screen.dart';
import 'package:wts_customer/view/screen/splash_screen.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

class MyProfileScreen extends StatefulWidget {
  static const pageId = '/MyProfileScreen';

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  HomeController _homeCon = Get.find();
  late UserInfoModel _userInfoModel;
  bool isDataLoaded = false;
  File? imageFile;
  late String filePath;
  Map<String, dynamic> languageMap = Map();

  bool isBnSelected = false;

  setLangueWiseContentInLocalMap() async {
    String? langCon = await MySharedPreference.getString(
        SharedPrefKey.LANGUAGE_WISE_CONTENT,
        defauleValue: null);
    if (langCon != null) {
      setState(() {
        languageMap = jsonDecode(langCon.toString());
      });
    }
  }

  reloadLanguageWiseContent() async {
    _homeCon.status.value=Status.LOADING;
    bool value = await Get.find<AuthController>().getLanguageWiseContents();
    if (value == true) {
      Get.offAllNamed(SplashScreen.pageId);
      // setLangueWiseContentInLocalMap();
      // _homeCon.getDashBoardData();
    }
  }


  @override
  void initState() {
    setLangueWiseContentInLocalMap();
    super.initState();
    getUserData();
  }

  getUserData() async {
    String userInfo =
        (await MySharedPreference.getString(SharedPrefKey.USER_INFO))!;
    //  Map<String,dynamic> json = jsonDecode(userInfo!);
    String lang = (await MySharedPreference.getLanguage())!;

    setState(() {
      isBnSelected = lang == 'bn' ? true : false;
    });
    print(
        '................................user data ${jsonDecode(userInfo.toString())}........................');
    _userInfoModel = UserInfoModel.fromJson(
        jsonDecode(userInfo.toString().replaceAll("\n", "")));
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/common_header.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          languageMap['my_profile'] ?? 'My Profile',
                          style: TextStyle(color: white,fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: isDataLoaded == false
                        ? Loading()
                        : Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showSelectionDialog(context);
                                },
                                child: Stack(
                                  children: [

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100.0),
                                      child: imageFile != null
                                          ? Image.file(
                                              imageFile!,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                        _userInfoModel.image != ""  ? '${_userInfoModel.image}' :
                                        'https://fastly.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                  ),
                                    ),
                                  Positioned(
                                      right: 5,
                                      bottom: 30,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: StaticKey.APP_MAINCOLOR,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: Center(
                                          child: Icon(
                                    Icons.image
                                            ,color: white,
                                  ),
                                        ),
                                      ))
                             ] ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: double.infinity,
                                          child: _buildProfileItem(
                                              languageMap['name'] ?? 'Name',
                                              _userInfoModel.name ?? "" ,Icons.people_alt),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: double.infinity,
                                          child: _buildProfileItem(
                                              languageMap['email'] ?? 'Email',
                                              _userInfoModel.email ?? "",Icons.email),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: double.infinity,
                                          child: _buildProfileItem(
                                              languageMap['phone_number'] ??
                                                  'Phone Number',
                                              _userInfoModel.phone ?? "",Icons.phone),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: double.infinity,
                                          child: _buildLanguage(
                                              languageMap['language'] ??
                                                  'Language',
                                              _userInfoModel.phone ?? "",Icons.language),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Container(
                              //             width: double.infinity,
                              //             child: _buildTermsAndConditions(
                              //                 languageMap['terms_and_conditions'] ??
                              //                     'Terms And Conditions',
                              //                 Icons.note),
                              //           )),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: double.infinity,
                                          child: _buildLogout(
                                              languageMap['logout'] ?? 'Logout',
                                              Icons.login_outlined),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 50),
                                  child:   RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 16,fontWeight: FontWeight.bold),
                                          text: '\n\n${languageMap['for_emergency_contact']??'For Emergency  Contact'}: ${StaticKey.SUPPORT_NUMBER}\n\n',
                                        ),
                                        TextSpan(
                                          style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 16,fontWeight: FontWeight.bold),
                                          text: 'Copyright © Wood Tech Solution\n',
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
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _onOpen(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _buildProfileItem(String title, String value,IconData icon) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: grey),
      //     borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon,color: grey,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 30),
                child: Text(
                  value ?? '',
                  style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(height: 1,color: Colors.grey,),
              ),
            ],
          )),
    );
  }
  Widget _buildLanguage(String title, String value,IconData icon) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: grey),
      //     borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon,color: grey,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: _buildLanguageSelection(),
                        )),
                  )
                ],
              ),
            //  SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(height: 1,color: Colors.grey,),
              ),
            ],
          )),
    );
  }
  Widget _buildLanguageSelection() {
    return Container(
      width: 112,
      // decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: grey),
      //     borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
          child:
    Center(
        child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isBnSelected == true ? StaticKey.APP_MAINCOLOR : StaticKey.APP_MAINCOLOR,
        borderRadius: BorderRadius.circular(
          (15),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              MySharedPreference.setString(SharedPrefKey.LANGUAGE, 'bn');

              setState(() {
                isBnSelected = true;
              });
             // Get.offAllNamed(SplashScreen.pageId);
              reloadLanguageWiseContent();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isBnSelected == true ? Colors.white :  StaticKey.APP_MAINCOLOR,
                borderRadius: BorderRadius.circular(
                  (15),
                ),
              ),
              child: Text('BN',style: TextStyle(color: isBnSelected == true ?Colors.black:white)),
            ),
          ),
          GestureDetector(
            onTap: () {
              MySharedPreference.setString(SharedPrefKey.LANGUAGE, 'en');
              setState(() {
                isBnSelected = false;
              });

              reloadLanguageWiseContent();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isBnSelected != true ? Colors.white :  StaticKey.APP_MAINCOLOR,
                borderRadius: BorderRadius.circular(
                  (15),
                ),
              ),
              child: Text('EN',style: TextStyle(color: isBnSelected != true ?Colors.black:white),),
            ),
          ),
        ],
      ),
    ))),
    );
  }
  Widget _buildTermsAndConditions(String title,IconData icon) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: grey),
      //     borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon,color: grey,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(height: 1,color: Colors.grey,),
              ),
            ],
          )),
    );
  }
  Widget _buildLogout(String title,IconData icon) {
    return GestureDetector(
            onTap: () {
              MySharedPreference.clear();
              Get.offAllNamed(LoginScreen.pageId);
            },
      child: Container(
        // decoration: BoxDecoration(
        //     border: Border.all(width: 1, color: grey),
        //     borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon,color: grey,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0,left: 5),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }


  Future<void> _showSelectionDialog(BuildContext context) {
    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => Container(
        height: 160,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: StaticKey.APP_MAINCOLOR),
              child: Center(
                  child: Text(
                '${languageMap['choose_option'] ?? 'Choose Option'}',
                style: TextStyle(color: white, fontSize: 15),
              )),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: StaticKey.APP_MAINCOLOR,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${languageMap['from_camera'] ?? 'From Camera'}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openGallery(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_album,
                          size: 35,
                          color:  StaticKey.APP_MAINCOLOR,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${languageMap['from_gallery'] ?? 'From Gallery'}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _openGallery(BuildContext context) async {
    //var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(
        '............................................${picture}.............');
    this.setState(() {
      imageFile = File(picture!.path);
      filePath = picture.path;
      if (imageFile != null) _homeCon.changeProfilePic(filePath!);
    });
    Navigator.of(context).pop();
  }
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture!.path);
      filePath = picture.path;
    });
    Navigator.of(context).pop();
  }
  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile!, width: 50, height: 50);
    } else {
      return Text("Please select an image");
    }
  }
}
