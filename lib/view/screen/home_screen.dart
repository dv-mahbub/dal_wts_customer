import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wts_customer/controller/auth_controller.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/home_controller.dart';
import 'package:wts_customer/controller/product_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/model/login_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/util/utils.dart';
import 'package:wts_customer/view/screen/home_page.dart';
import 'package:wts_customer/view/screen/splash_screen.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

import 'complain_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const pageId = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _homeCon = Get.find();
  UserInfoModel? _userInfoModel;
  EasySearchBar? searchBar;
  bool isBnSelected = false;
  Map<String, dynamic> languageMap = Map();
  List<dynamic> offerList = [];
  List<dynamic> promotionBannerList = [];
  List<Widget> promotionBannerWidgetList = [];

  @override
  void initState() {
    super.initState();
    setLangueWiseContentInLocalMap();
    getUserData();
    _homeCon.getDashBoardData();
    getPromotionBanner();
    getOffers();

    setState(() {});
  }

  String searchValue = '';

  getOffers() async {
    var offerList = await _homeCon.getOffers();
    setState(() {
      this.offerList = offerList;
    });
    print(
        '............................getOffers........${offerList}...............');
  }

  getPromotionBanner() async {
    promotionBannerList = await _homeCon.getPromotionBanner();
    print(
        '............................getPromotionBanner........${promotionBannerList}...............');


    setState(() {
      promotionBannerList.forEach((element) {
        print(".............element,,,,,,,,,,,,,,,${element}");
        promotionBannerWidgetList.add(
          GestureDetector(
            onTap: () async {
              final url = element["url"];
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(
                      StaticKey.BASE_URL + "/" + element['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        );
      });
    });
  }


  setLangueWiseContentInLocalMap() async {
    String? langCon = await MySharedPreference.getString(
        SharedPrefKey.LANGUAGE_WISE_CONTENT,
        defauleValue: null);

    if (langCon != null) {
      setState(() {
        languageMap = jsonDecode(langCon.toString());
      });
    } else {
      reloadLanguageWiseContent();
    }
  }

  reloadLanguageWiseContent() async {
    _homeCon.status.value = Status.LOADING;
    bool value = await Get.find<AuthController>().getLanguageWiseContents();
    if (value == true) {
      Get.offAllNamed(SplashScreen.pageId);
      // setLangueWiseContentInLocalMap();
      // _homeCon.getDashBoardData();
    }
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
        '................................user data ${jsonDecode(
            userInfo.toString())}........................');
    _userInfoModel = UserInfoModel.fromJson(
        jsonDecode(userInfo.toString().replaceAll("\n", "")));
  }
EasySearchBar buildApp(BuildContext context){
    return EasySearchBar(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        elevation: 0.0,
        title:  Image.asset('assets/login_screen_logo.png',
          fit: BoxFit.contain,
          height: 40,
        ),
        onSearch: (value) => setState(() => searchValue = value)

    );
}
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: StaticKey.APP_MAINCOLOR,
      centerTitle: false,
      elevation: 0.0,
      title: Image.asset('assets/login_screen_logo.png',
        fit: BoxFit.contain,
        height: 40,
      ),
      actions: [




        SizedBox(
          width: 10,
        )
      ],

      bottom: PreferredSize(
        child: Container(
          // color: Colors.orange,
          height: 160.0,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/common_header.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.network(
                      _userInfoModel?.image != ""  ? '${_userInfoModel?.image}' :
                          'https://fastly.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.greetingMessage(languageMap),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hello ${_userInfoModel?.name}',
                        style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(160.0),

      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Obx(() {
        switch (_homeCon.status.value) {
          case Status.LOADING:
            return Loading();
          case Status.SUCCESS:
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  return _homeCon.getDashBoardData();
                },
                child: SingleChildScrollView(
                  child: Container(
                    //  height: MediaQuery.of(context).size.height,
                    //  width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(0),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [
                      //     Colors.blue,
                      //     Colors.black45,
                      //   ],
                      // )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xfffaecec)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    padding: EdgeInsets.all(0),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    decoration: BoxDecoration(
                                      //border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: StaticKey.SECONDARY_COLOR
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${languageMap['info'] ?? 'Info'}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(0),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    decoration: BoxDecoration(
                                      //border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xfffaecec)
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Text(
                                              '${ _homeCon.dashBoardInfoModel
                                                  .value?.dashboard_note}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Get
                                        .find<ComplainController>()
                                        .selectedTab =
                                    1;
                                    Get
                                        .find<HomeController>()
                                        .pageIndex
                                        .value =
                                    3;
                                  },
                                  child: _buildHomeMenu(
                                      languageMap['complain_due'] ??
                                          'Complain Due',
                                      _homeCon.dashBoardInfoModel?.value
                                          ?.complain_due
                                          .toString() ??
                                          "0",
                                      'complain_due.png', 'main1.png', Color(
                                      0xffe8f5f2)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Get
                                        .find<ProductController>()
                                        .selectedTab = 1;
                                    Get
                                        .find<HomeController>()
                                        .pageIndex
                                        .value =
                                    1;
                                  },
                                  child: _buildHomeMenu(
                                      languageMap['installation_due'] ??
                                          'Installation Due',
                                      _homeCon.dashBoardInfoModel?.value
                                          ?.install_dues
                                          .toString() ??
                                          "0",
                                      'installation_due.png', 'main2.png',
                                      Color(
                                          0xffeef6e8)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Get
                                        .find<ComplainController>()
                                        .selectedTab =
                                    0;
                                    Get
                                        .find<HomeController>()
                                        .pageIndex
                                        .value =
                                    3;
                                  },
                                  child: _buildHomeMenu(
                                      "${languageMap['complain'] ??
                                          'Complain' "\n\n"}",
                                      _homeCon.dashBoardInfoModel?.value
                                          ?.complain
                                          .toString() ??
                                          "0",
                                      'complain.png', 'main3.png', Color(
                                      0xfff5e5d6)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Get
                                        .find<ProductController>()
                                        .selectedTab = 0;
                                    Get
                                        .find<HomeController>()
                                        .pageIndex
                                        .value =
                                    1;
                                  },
                                  child: _buildHomeMenu(
                                      languageMap['products'] ?? 'Products',
                                      _homeCon.dashBoardInfoModel?.value
                                          ?.products
                                          .toString() ??
                                          "0",
                                      'products.png', 'main4.png', Color(
                                      0xffe4efef)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                            items: promotionBannerWidgetList,
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,

                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(
                                  milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) async {},
                              scrollDirection: Axis.horizontal,
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: (_homeCon.dashBoardInfoModel.value
                              ?.install_in_process.length != null
                              && _homeCon.dashBoardInfoModel.value
                                  ?.install_in_process!.length != 0)
                              ? true
                              : false,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              languageMap['install_in_process'] ??
                                  'Install In Process',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: (_homeCon.dashBoardInfoModel.value
                              ?.install_in_process.length != null
                              && _homeCon.dashBoardInfoModel.value
                                  ?.install_in_process!.length != 0)
                              ? true
                              : false,
                          child: Container(
                            height: 200,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_left,
                                  size: 20,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.2),
                                                spreadRadius: 5,
                                                blurRadius: 17,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                8),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ],
                                            )),
                                        child: _buildInstallDue())),
                                Icon(
                                  Icons.arrow_right,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: (_homeCon.dashBoardInfoModel.value
                              ?.complain_in_process.length != null
                              && _homeCon.dashBoardInfoModel.value
                                  ?.complain_in_process!.length != 0)
                              ? true
                              : false,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              languageMap['complain_in_process'] ??
                                  'Complain In Process',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: (_homeCon.dashBoardInfoModel.value
                              ?.complain_in_process.length != null
                              && _homeCon.dashBoardInfoModel.value
                                  ?.complain_in_process!.length != 0)
                              ? true
                              : false,
                          child: Container(
                            height: 200,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_left,
                                  size: 20,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.2),
                                                spreadRadius: 5,
                                                blurRadius: 17,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                8),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ],
                                            )),
                                        child: _buildComplainInProcess())),
                                Icon(
                                  Icons.arrow_right,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: (offerList?.length != null
                              && offerList!.length != 0) ? true : false,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              languageMap['offers'] ?? 'Offers',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: (offerList.length != null
                              && offerList!.length != 0) ? true : false,
                          child: Container(
                            height: 200,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_left,
                                  size: 20,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: _buildOffers())),
                                Icon(
                                  Icons.arrow_right,
                                  size: 20,
                                ),
                              ],
                            ),
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
            );
          default:
            return Center(
              child: Text(languageMap['no_data_found'] ?? "No data found"),
            );
        }
      }),
    );
  }

  Widget _buildHomeMenu(String title, String value, String smallIcon,
      String largeIcon, Color backgroundColor) {
    return Container(
      height: 135,
      //  padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 17,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        // gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Colors.white,
        //     Colors.white,
        //   ],
        // )

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Container(
          //     padding: EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(8)),
          //         color: Colors.amber),
          //     child: FaIcon(
          //       fontAwesomeIcons,
          //       color: Colors.green,
          //     )),
          SizedBox(
            height: 5,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Image.asset(
                "assets/${smallIcon}",
                fit: BoxFit.fill,
                //  color: Colors.white,
                // height: 40,
                // width: 100,
                //width: 200,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Stack(
              children: [
                Image.asset(
                  "assets/${largeIcon}",
                  fit: BoxFit.fill,
                  //  color: Colors.white,
                  height: 60,
                  // width: 100,
                  //width: 200,
                ),
                Positioned.fill(
                  // right: 40,
                  // bottom: 18,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      value,

                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplainInProcess() {
    List<ComplainModel>? list =
        _homeCon.dashBoardInfoModel.value?.complain_in_process;

    return PageView.builder(
        pageSnapping: true,
        reverse: false,
        itemCount: list?.length,
        itemBuilder: (context, index) {
          return _buildComplainInProcessItem(index);
        });
  }

  Widget _buildOffers() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offerList.length,
        itemBuilder: (ctx, index) {
          return _buildOffersItem(index);
        });
  }

  Widget _buildInstallDue() {
    List<InstallationDueModel>? list =
        _homeCon.dashBoardInfoModel.value?.install_in_process;

    return PageView.builder(
        itemCount: list?.length,
        itemBuilder: (context, index) {
          return _buildInstallDueItem(index);
        });
  }

  Widget _buildInstallDueItem(int index) {
    List<InstallationDueModel>? list =
        _homeCon.dashBoardInfoModel.value?.install_in_process;
    // ComplainModel complainModel = list![index];
    return InkWell(
      onTap: () {
        // Get.find<ProductController>().selectedTab=1;
        // Get.find<HomeController>().pageIndex.value = 1;
        Get.toNamed(
            '${ComplainDetailsScreen.pageId}?ticketId=${list![index].ticketNo
                .toString()}&install_details=true');
      },
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.lightGreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '#${list![index].ticketNo}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20))
                            ),
                            child: Text(
                              '${list![index].status}',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Align(
                    //     alignment: Alignment.center,
                    //     child: FaIcon(FontAwesomeIcons.hammer,size:30,color: Colors.green,)),

                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            list![index].product ?? '',
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${languageMap['created_at'] ??
                                'Created At'}: ${list![index].createdAt != null
                                ? DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(list![index].createdAt!))
                                : ''}',
                            // '${languageMap['created_at']??'Created At'}: ${complainModel.createdAt}',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: '${languageMap['product_code'] ??
                                      'Product Code'} : ',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    new TextSpan(
                                      text: '${list![index].productSerialNumber ??
                                          ''}',
                                      style: TextStyle(
                                          color: Colors.green[500],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),

                                    ),
                                  ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: '${languageMap['updated_at'] ??
                                      'Updated At'} : ',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    new TextSpan(
                                      text: '${list![index].updatedAt != null
                                          ? DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(list![index].updatedAt!))
                                          : ''}',
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),

                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: '${languageMap['model_number'] ??
                                    'Model Number'} : ',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  new TextSpan(
                                    text: '${list![index].model ?? ''}',
                                    style: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),

                                  ),
                                ]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: '${languageMap['schedule_date'] ??
                                    'Schedule Date'} : ',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  new TextSpan(
                                    text: '${list![index].purchaseDate != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(
                                            list![index].purchaseDate!))
                                        : ''}',
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),

                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: '${languageMap['warranty_available'] ??
                                    'Warranty Available'} : ',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  new TextSpan(
                                    text: '${ (list![index].warrantyAvailable ==
                                        0
                                        ? AppStringKey.yes
                                        : AppStringKey.no)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),

                                  ),
                                ]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: '${languageMap['ticket_date'] ??
                                    'Ticket Date'} : ',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  new TextSpan(
                                    text: '${list![index].ticketDate != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(
                                            list![index].ticketDate!))
                                        : ''}',
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),

                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Hero(
          //   tag: list![index].complain_id,
          //   child: Image.asset('/assets/logo.png'),
          // ),
          // Positioned(
          //   right: 24,
          //   bottom: 60,
          //   child: Text(
          //     planets[index].position.toString(),
          //     style: TextStyle(
          //       fontFamily: 'Avenir',
          //       fontSize: 200,
          //       color: primaryTextColor.withOpacity(0.08),
          //       fontWeight: FontWeight.w900,
          //     ),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildComplainInProcessItem(int index) {
    List<ComplainModel>? list =
        _homeCon.dashBoardInfoModel.value?.complain_in_process;
    ComplainModel complainModel = list![index];
    return InkWell(
      onTap: () {
        // Get.find<ComplainController>().selectedTab=1;
        // Get.find<ComplainController>().selectedItemId = complainModel.productId.toString();
        // Get.find<HomeController>().pageIndex.value = 3;
        Get.toNamed(
            '${ComplainDetailsScreen.pageId}?ticketId=${complainModel.ticketNo
                .toString()}');
      },
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: StaticKey.SECONDARY_COLOR),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '#${complainModel.ticketNo}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25, vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Text(
                          '${complainModel.status}',
                          style: TextStyle(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Align(
                //     alignment: Alignment.center,
                //     child: FaIcon(FontAwesomeIcons.hammer,size:30,color: Colors.green,)),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        list![index].product ?? '',
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${languageMap['created_at'] ??
                            'Created At'}: ${complainModel.createdAt != null
                            ? DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(complainModel.createdAt!))
                            : ''}',
                        // '${languageMap['created_at']??'Created At'}: ${complainModel.createdAt}',
                        style: TextStyle(
                            color: black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['product_code'] ??
                                'Product Code'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${list![index].productSerialNumber ??
                                    ''}',
                                style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['updated_at'] ??
                                'Updated At'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${complainModel.updatedAt != null
                                    ? DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(complainModel.updatedAt!))
                                    : ''}',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['model_number'] ??
                                'Model Number'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${complainModel.model ?? ''}',
                                style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['schedule_date'] ??
                                'Schedule Date'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${complainModel.scheduleDate != null
                                    ? DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(complainModel.scheduleDate!))
                                    : ''}',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['warranty_available'] ??
                                'Warranty Available'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${ (complainModel.warrantyAvailable == 0
                                    ? AppStringKey.yes
                                    : AppStringKey.no)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '${languageMap['ticket_date'] ??
                                'Ticket Date'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                text: '${complainModel.ticketDate != null
                                    ? DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(complainModel.ticketDate!))
                                    : ''}',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOffersItem(int index) {
    List<dynamic> list =
        offerList;
    return InkWell(
      onTap: () async {
        final url = offerList[index]["url"];
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: false,
          );
        }
      },
      child: Container(
        width: 150,
        // height: 150,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: white),
        child: Column(
          children: <Widget>[
            Container(
              // width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: StaticKey.APP_MAINCOLOR),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.network(
                    StaticKey.BASE_URL + "/" + offerList[index]['image'] ??
                        'https://picsum.photos/250?image=9',
                    // height: 30,
                    // width: 30,
                    // fit: BoxFit.fill,

                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Align(
                  //     alignment: Alignment.center,
                  //     child: FaIcon(FontAwesomeIcons.hammer,size:30,color: Colors.green,)),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      offerList[index]['title'] ?? '',
                      maxLines: 2,
                      style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      offerList[index]['text'] ?? '',
                      maxLines: 3,
                      style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


