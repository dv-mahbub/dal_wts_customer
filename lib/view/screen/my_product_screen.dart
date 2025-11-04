import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/home_controller.dart';
import 'package:wts_customer/controller/product_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/product_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/add_complain_screen.dart';
import 'package:wts_customer/view/screen/product_details_screen.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

class MyProductScreen extends StatefulWidget {
  static const pageId = '/MyProductScreen';

  @override
  _MyProductScreenState createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MyProductScreen> {
  ProductController _productCon = Get.find();
  late TabController _controller;
  List<ProductInfoModel> installedList = [];
  List<ProductInfoModel> installInProcessList = [];
  List<ProductInfoModel> allProductList = [];
  int _selectedIndex = 0;
  Map<String, dynamic> languageMap = Map();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

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
  void initState() {
    setLangueWiseContentInLocalMap();
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _productCon.getProductList();
    _selectedIndex = Get
        .find<ProductController>()
        .selectedTab;
    _controller.index = _selectedIndex;
    Get.find<ProductController>()
        .selectedTab = 0;
  }

  Widget _offsetPopup(int index) =>
      PopupMenuButton<int>(
          onSelected: (value) {
            switch (value) {
              case 1:
                Get.toNamed(
                    '${AddComplainScreen.pageId}?productId=${_productCon
                        .productList.value![index].id}&product_code=${_productCon.productList.value![index].productCode}');
                break;
              case 2:
                Get
                    .find<ComplainController>()
                    .selectedItemId =
                    _productCon.productList.value![index].productId.toString();
                Get
                    .find<HomeController>()
                    .pageIndex
                    .value = 3;
                // Get.toNamed(
                // '${ComplainDetailsScreen.pageId}?productId=${_productCon.productList.value![index].id}&complainId=${5}');
                //
                //
                break;
            }
          },
          itemBuilder: (context) =>
          [
            PopupMenuItem(
              value: 1,
              child: Text(
                languageMap['add_complain'] ?? "Add Complain",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            // PopupMenuItem(
            //   value: 2,
            //   child: Text(
            //     "Product Details",
            //     style:
            //         TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            //   ),
            // ),
            PopupMenuItem(
              value: 2,
              child: Text(
                languageMap['complain_history'] ?? "Complain History",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),


          ],
          icon: Icon(Icons.more_vert));


  Widget _imagePopup(String url) =>
      PopupMenuButton<int>(
        onSelected: (value) {

        },
        itemBuilder: (context) =>
        [

          PopupMenuItem(
            value: 2,
            child:    Container(
              height: 150,
              width: 100,
            //  color: ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  url ??
                      'https://picsum.photos/250?image=9',
                  // height: 30,
                  // width: 30,
                  fit: BoxFit.fill,

                ),
              ),
            ),
          ),


        ],
        child:   Container(
       //   height: 100,
          width: 55,
          color: Colors.grey,
          child: ClipRRect(
           // borderRadius: BorderRadius.circular(40.0),
            child: Image.network(
              url ?? 'https://picsum.photos/250?image=9',
              // height: 30,
              // width: 30,
             // fit: BoxFit.fill,
            ),
          ),
        ),);

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
                            languageMap['my_product'] ?? 'My Product',
                            style: TextStyle(color: white,fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color:  Color(0xE7C4D2AB),
                            border: Border.all(width: 0, color: grey),
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))),

                        child: TabBar(
                          controller: _controller,
                          unselectedLabelColor: Color(0xE7020202),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xE76F9E1A), Color(0xE76F9E1A)]),
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
                              color: Colors.redAccent),
                          tabs: [

                            Tab(
                              child:    Text(languageMap['installed_product'] ?? 'Installed Products',
                        style: TextStyle(fontSize: 14)),
                            ),
                            Tab(
                              child:    Text(languageMap['installation_in_process'] ??
                                  'Installation In Process', style: TextStyle(fontSize: 14)),
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
                    child: RefreshIndicator(
                      onRefresh: _productCon.getProductList,
                      child: TabBarView(
                        controller: _controller,
                        children: [_buildBody(true), _buildBody(false)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBody(bool isInstalled) {
    return Obx(() {
      switch (_productCon.status.value) {
        case Status.LOADING:
          keyRefresh.currentState?.show();
          return Loading();
        case Status.SUCCESS:
          installInProcessList = [];
          installedList = [];
          allProductList = [];
          _productCon.productList?.value?.forEach((element) {
            //   print('.....................product code ${element.productCode}..................');
            allProductList.add(element);
            if (element.installedStatus == 0) {
              installInProcessList.add(element);
            } else {
              installedList.add(element);
            }
          });
          if (isInstalled) {
            return Container(
              // Use ListView.builder

              margin: EdgeInsets.all(10),
              child: RefreshIndicator(
                onRefresh: _productCon.getProductList,
                child: ListView.builder(
                  // the number of items in the list
                    itemCount: allProductList.length,
                    // display each item of the product list
                    itemBuilder: (_, index) {
                      return _listItem(allProductList, index,
                          allProductList[index].installedStatus == 1);
                    }),
              ),
            );
          } else {
            return Container(
              // Use ListView.builder
              margin: EdgeInsets.all(10),
              child: RefreshIndicator(
                onRefresh: _productCon.getProductList,
                child: ListView.builder(
                  // shrinkWrap: true,
                  // primary: false,
                  // the number of items in the list
                    itemCount: installInProcessList.length,
                    // display each item of the product list
                    itemBuilder: (_, index) {
                      return _listItem(
                          installInProcessList, index, isInstalled);
                    }),
              ),
            );
          }
        default:
          return Center(
            child: Text(languageMap['no_data_found'] ?? "No data found"),
          );
      }
    });
  }

  Widget _listItem(List<ProductInfoModel> list, int index, bool isInstalled) {
    return GestureDetector(
      onTap: () {
        if (isInstalled)
          Get.toNamed(
              '${InstallationCheckListScreen
                  .pageId}?installationCheckList=${jsonEncode(
                  list[index].spareParts).toString()}'
                  '&name=${list[index].name}&isInstalled=${isInstalled}'
                  '&preparation_done=${list[index].preparationDone}'
                  '&product_id=${list[index].productId}&product_code=${list[index].productCode}');
        else {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InstallationCheckListScreen(installationCheckList: list[index]?.installationRequirements,
              name: list[index]?.name,isInstalled: '${isInstalled}',preparation_done: '${list[index]?.preparationDone}',
              product_code: '${list[index].productCode}',product_id: '${list[index].productId}', )),
          );

          // Get.toNamed(
          //     '${InstallationCheckListScreen
          //         .pageId}?installationCheckList=${jsonEncode(
          //         (list[index]?.installationRequirements?.map((e) =>
          //             e.toJson()))).toString()}'
          //         '&name=${list[index].name}&isInstalled=${isInstalled}'
          //         '&preparation_done=${list[index].preparationDone}'
          //         '&product_id=${list[index]
          //         .productId}&product_code=${list[index].productCode}');
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: grey),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isInstalled)
            Container(
              decoration: BoxDecoration(
                  color:  Colors.amber,
                  border: Border.all(width: 0, color: grey),
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15),topRight:Radius.circular(10))),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                child: Text(
                  ' ${list[index].status}',
                  //  list![index].invoice_no.toString().toString(),
                //     ${languageMap['status'] ??
                // // 'Status'}: ${languageMap['pending'] ?? 'Pending'}',
              //  'Status'}:
                  style: TextStyle(
                  color: black,
                  fontSize: 12,
                //  fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),

            if (isInstalled)  SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imagePopup( list[index].image),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          '${list[index].name ?? ''} ${isInstalled==true? '(${languageMap['support']??'Support'}:${list[index].supportToken})':''}',
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RichText(
                          text: TextSpan(
                            text: '${languageMap['model_number'] ?? 'Model Number'} : ',
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            children: [
                              new TextSpan(
                                  text: '${list[index].model ?? ''}',
                                style: TextStyle(
                                    color: blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),

                                 ),
                            ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RichText(
                          text: TextSpan(
                              text: '${languageMap['product_code'] ??
                                  'Product Code'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text: '${list[index].productSerialNumber ?? ''}',
                                  style: TextStyle(
                                      color: blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),

                                ),
                              ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: RichText(
                          text: TextSpan(
                              text: '${languageMap['purchase_date'] ??
                                  'Purchase Date'} : ',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: [
                                new TextSpan(
                                  text: '${list[index].purchaseDate.toString() ?? ''}',
                                  style: TextStyle(
                                      color: blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),

                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isInstalled) _offsetPopup(index),

              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
