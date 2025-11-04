import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/installation_due_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/complain_notcompleted_screen.dart';
import 'package:wts_customer/view/screen/feedback_screen.dart';
import 'package:wts_customer/widget/button_common.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

import 'complain_details_screen.dart';

class MyComplainScreen extends StatefulWidget {
  static const pageId = '/MyComplainScreen';

  @override
  _MyComplainScreenState createState() => _MyComplainScreenState();
}

class _MyComplainScreenState extends State<MyComplainScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MyComplainScreen> {
  late ComplainController _complainCon;

  late TabController _controller;
  int _selectedIndex = 0;
  String? itemId = Get.find<ComplainController>().selectedItemId;
  Map<String, dynamic> languageMap = Map();

  // List<Map<String, dynamic>> evaluationMap = [];

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.find<ComplainController>().selectedItemId = null;
    print(' ..............................product id ${itemId}');
    _selectedIndex = Get.find<ComplainController>().selectedTab;
    setLangueWiseContentInLocalMap();
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _complainCon = Get.find<ComplainController>();
    _controller.index = _selectedIndex;
    Get.find<ComplainController>().selectedTab = 0;
    // _controller.addListener(() {
    //   setState(() {
    //     if(Get.find<ComplainController>().selectedTab==1) {
    //
    //       _selectedIndex = _controller.index;
    //       _controller.animateTo(_selectedIndex += 1);
    //     }
    //   });
    //   print("Selected Index: " + _controller.index.toString());
    // });
    loadData();
  }

  loadData() async {
    await _complainCon.getComplainDueData(itemId);
    await _complainCon.getComplainData(itemId);
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
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
                          languageMap['complain_list'] ?? 'Complain List',
                          style: TextStyle(color: white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xE7C4D2AB),
                          border: Border.all(width: 0, color: grey),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: TabBar(
                        controller: _controller,
                        unselectedLabelColor: Color(0xE7020202),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xE76F9E1A), Color(0xE76F9E1A)]),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.redAccent),
                        tabs: [
                          Tab(
                            child: Text(
                                languageMap['all_complain'] ?? 'All Complain',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Tab(
                            child: Text(
                                languageMap['complain_in_process'] ??
                                    'Complain In Process',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFEFEFEF),
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      //Text('data'),
                      //Text('data'),
                      _buildComplainList(context),
                      _buildComplainInProcess(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //  ),
    );
  }

  Widget _buildComplainList(BuildContext context) {
    return Obx(() {
      switch (_complainCon.status.value) {
        case Status.LOADING:
          return Loading();
        case Status.SUCCESS:
          return Container(
            // Use ListView.builder
            margin: EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () {
                return _complainCon.getComplainData(itemId);
              },
              child: ListView.builder(
                  // the number of items in the list
                  itemCount: _complainCon.complainList?.value?.length,
                  // display each item of the product list
                  itemBuilder: (_, index) {
                    if (_complainCon.complainList.value != null) {
                      return _listItemAllComplainIn(
                          _complainCon.complainList.value![index], context);
                    } else {
                      return Container();
                    }
                  }),
            ),
          );

        default:
          return Center(
            child: Text(languageMap['no_data_found'] ?? "No data found"),
          );
      }
    });
  }

  Widget _buildComplainInProcess(BuildContext context) {
    return Obx(() {
      switch (_complainCon.status.value) {
        case Status.LOADING:
          return Loading();
        case Status.SUCCESS:
          return Container(
            // Use ListView.builder
            margin: EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () {
                return _complainCon.getComplainDueData(itemId);
              },
              child: ListView.builder(
                  // the number of items in the list
                  itemCount: _complainCon.complainDueList?.value?.length,
                  // display each item of the product list
                  itemBuilder: (_, index) {
                    return _listItemComplainInProcess(
                        _complainCon.complainDueList.value![index], context);
                  }),
            ),
          );

        default:
          return Center(
            child: Text(languageMap['no_data_found'] ?? "No data found"),
          );
      }
    });
  }

  Widget _listItemAllComplainIn(
      ComplainModel complainModel, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            '${ComplainDetailsScreen.pageId}?ticketId=${complainModel.ticketNo.toString()}');

        //'${ComplainDetailsScreen.pageId}?productId=${14}&complainId=${complainModel.complainId}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
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
                          complainModel.product ?? '',
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${languageMap['created_at'] ?? 'Created At'}: ${complainModel.createdAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.createdAt!)) : ''}',
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
                              text:
                                  '${languageMap['product_code'] ?? 'Product Code'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.productSerialNumber ?? ''}',
                                  style: TextStyle(
                                      color: Colors.red[300],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['updated_at'] ?? 'Updated At'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.updatedAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.updatedAt!)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
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
                              text:
                                  '${languageMap['model_number'] ?? 'Model Number'} : ',
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
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['schedule_date'] ?? 'Schedule Date'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.scheduleDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.scheduleDate)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
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
                              text:
                                  '${languageMap['warranty_available'] ?? 'Warranty Available'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${(complainModel.warrantyAvailable == 0 ? AppStringKey.yes : AppStringKey.no)}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['ticket_date'] ?? 'Ticket Date'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.ticketDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.ticketDate!)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: complainModel.toBeCompleted == 1 ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(
                                '${FeedBackScreen.pageId}?complainId=${complainModel.complainId.toString()}&ticketId=${complainModel.ticketNo.toString()}&support_engineer=${complainModel.supportEngineer.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                color: Colors.lightGreen[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['completed'] ?? 'Completed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // _showNotCompletedReasonDialog(
                            //     context, complainModel);

                            Get.toNamed(
                                '${ComplainNotCompletedScreen.pageId}?ticketId=${complainModel.ticketNo.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                color: Colors.red[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['not_completed'] ?? 'Not Completed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: complainModel.completed == 1 &&
                            complainModel.feedback_status != 1
                        ? true
                        : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(
                                '${FeedBackScreen.pageId}?complainId=${complainModel.complainId.toString()}&ticketId=${complainModel.ticketNo.toString()}&support_engineer=${complainModel.supportEngineer.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightGreen[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['feedback'] ?? 'Feedback',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemComplainInProcess(
      ComplainModel complainModel, BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(
        //     '${ComplainDetailsScreen.pageId}?productId=${complainModel.productId}&complainId=${complainModel.complainId}');
        //
        Get.toNamed(
            '${ComplainDetailsScreen.pageId}?ticketId=${complainModel.ticketNo.toString()}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
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
                          complainModel.product ?? '',
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${languageMap['created_at'] ?? 'Created At'}: ${complainModel.createdAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.createdAt!)) : ''}',
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
                              text:
                                  '${languageMap['product_code'] ?? 'Product Code'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.productSerialNumber ?? ''}',
                                  style: TextStyle(
                                      color: Colors.red[300],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['updated_at'] ?? 'Updated At'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.updatedAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.updatedAt!)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
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
                              text:
                                  '${languageMap['model_number'] ?? 'Model Number'} : ',
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
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['schedule_date'] ?? 'Schedule Date'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.scheduleDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.scheduleDate)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
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
                              text:
                                  '${languageMap['warranty_available'] ?? 'Warranty Available'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${(complainModel.warrantyAvailable == 0 ? AppStringKey.yes : AppStringKey.no)}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  '${languageMap['ticket_date'] ?? 'Ticket Date'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text:
                                      '${complainModel.ticketDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(complainModel.ticketDate!)) : ''}',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: complainModel.toBeCompleted == 1 ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(
                                '${FeedBackScreen.pageId}?complainId=${complainModel.complainId.toString()}&ticketId=${complainModel.ticketNo.toString()}&support_engineer=${complainModel.supportEngineer.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightGreen[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['completed'] ?? 'Completed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // _showNotCompletedReasonDialog(
                            //     context, complainModel);

                            Get.toNamed(
                                '${ComplainNotCompletedScreen.pageId}?ticketId=${complainModel.ticketNo.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.red[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['not_completed'] ?? 'Not Completed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: complainModel.completed == 1 &&
                            complainModel.feedback_status != 1
                        ? true
                        : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(
                                '${ComplainNotCompletedScreen.pageId}?ticketId=${complainModel.ticketNo.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightGreen[600]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                languageMap['feedback'] ?? 'Feedback',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNotCompletedReasonDialog(
      BuildContext context, ComplainModel complainModel) {
    TextEditingController textFieldComController = TextEditingController();

    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => SafeArea(
        child: LoadingOverlay(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white10),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel)),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Text(
                          languageMap['explain_your_reason_below'] ??
                              'Explain your reason below',
                          style: TextStyle(color: black, fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        maxLines: 1,
                        controller: textFieldComController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: languageMap['explain_reason'] ??
                              'Please Explain Reason...',
                        ),
                        onChanged: (text) {
                          setState(() {
                            //fullName = text;
                            //you can access nameController in its scope to get
                            // the value of text entered as shown below
                            //fullName = nameController.text;
                          });
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: TextButtonCommon(
                        fontSize: 15,
                        text: '${languageMap['submit'] ?? 'Submit'}',
                        callBack: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          // setState(() {
                          //   isOverFlowLoading = true;
                          // });

                          await _complainCon.installNotCompleted(
                              complainModel.complainId.toString(),
                              textFieldComController.text.toString().trim());

                          // setState(() {
                          //   isOverFlowLoading = false;
                          // });
                          switch (_complainCon.status.value) {
                            case Status.LOADING:
                              print(
                                  '..............LOADING LOADING..................');
                              break;
                            case Status.SUCCESS:
                              print(
                                  '..............SUCCESS SUCCESS..................');
                              Navigator.pop(context);
                              _complainCon.getComplainData(itemId);
                              break;
                            case Status.ERROR:
                              print(
                                  '..............APIERROR APIERROR..................');
                              break;
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            isLoading: Get.find<ComplainController>().isLoading.value),
      ),
    );
  }

  Future<void> _showFeedBackDialog(
      BuildContext context, ComplainModel complainModel) {
    int index = 0;
    TextEditingController textFieldComController = TextEditingController();
    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => Container(
        height: 300,
        width: double.infinity,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  color: green[900]),
              child: Center(
                  child: Text(
                '${languageMap['choose_option'] ?? 'Choose Option'}',
                style: TextStyle(color: white, fontSize: 15),
              )),
            ),
            // ...evaluationMap
            //     .map((e) => Container(
            //           height: 100,
            //           width: double.infinity,
            //           padding: EdgeInsets.all(10),
            //           margin: EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //               border: Border.all(width: 1),
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               color: Colors.white),
            //           child: Row(
            //             children: [
            //               // Text('${index+1}. ${e['question']}',
            //               //     style:TextStyle(color: Colors.black,
            //               //         fontSize: 18,fontWeight: FontWeight.bold)),
            //               // SizedBox(
            //               //   height: 10,
            //               // ),
            //               // Container(
            //               //     margin: EdgeInsets.all(10),
            //               //     child: TextField(
            //               //       maxLines: 1,
            //               //       controller: textFieldComController,
            //               //       decoration: InputDecoration(
            //               //         border: OutlineInputBorder(),
            //               //         labelText: languageMap['explain_reason'] ??
            //               //             'Please Explain Reason...',
            //               //       ),
            //               //       onChanged: (text) {
            //               //         setState(() {
            //               //           e['answer']=text;
            //               //           //fullName = text;
            //               //           //you can access nameController in its scope to get
            //               //           // the value of text entered as shown below
            //               //           //fullName = nameController.text;
            //               //         });
            //               //       },
            //               //     )),
            //             ],
            //           ),
            //         ))
            //     .toList()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
