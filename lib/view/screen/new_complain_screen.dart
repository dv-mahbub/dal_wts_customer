import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/product_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/model/product_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

import 'add_complain_screen.dart';

class NewComplainScreen extends StatefulWidget {
  static const pageId = '/NewComplainScreen';

  @override
  _NewComplainScreenState createState() => _NewComplainScreenState();
}

class _NewComplainScreenState extends State<NewComplainScreen> {
  ProductController _productCon = Get.find();
  List<ProductInfoModel> installedList = [];
  Map<String, dynamic> languageMap = Map();


  @override
  void initState() {
    setLangueWiseContentInLocalMap();
    super.initState();

    _productCon.getProductList();
  }

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

  // Widget _imagePopup(String url) =>
  //     PopupMenuButton<int>(
  //       onSelected: (value) {
  //
  //       },
  //       itemBuilder: (context) =>
  //       [
  //
  //         PopupMenuItem(
  //           value: 2,
  //           child:    Container(
  //             height: 150,
  //             width: 100,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(40.0),
  //               child: Image.network(
  //                 url ??
  //                     'https://picsum.photos/250?image=9',
  //                 // height: 30,
  //                 // width: 30,
  //                 fit: BoxFit.fill,
  //               ),
  //             ),
  //           ),
  //         ),
  //
  //
  //       ],
  //       child:   Container(
  //        // height: 100,
  //         width: 55,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(40.0),
  //           child: Image.network(
  //             url ?? 'https://picsum.photos/250?image=9',
  //             // height: 30,
  //             // width: 30,
  //             fit: BoxFit.none,
  //           ),
  //         ),
  //       ),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        body: Obx(() {
          switch (_productCon.status.value) {
            case Status.LOADING:
              return Loading();
            case Status.SUCCESS:
              installedList = [];
              _productCon.productList?.value?.forEach((element) {
                if (element.installedStatus == 0) {
                } else {
                  installedList.add(element);
                }
              });

              return SafeArea(
                child: Container(
                  // Use ListView.builder
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
                                  languageMap['create_new_complain']?? 'Create New Complain',
                                  style: TextStyle(color: white,fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: RefreshIndicator(
                            onRefresh: (){
                            return  _productCon.getProductList();
                            },
                            child: ListView.builder(
                                // the number of items in the list
                                itemCount: installedList.length,
                                // display each item of the product list
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(
                                        //     '${AddComplainScreen.pageId}?productId=${_productCon
                                        //         .productList.value![index].id}&product_code=${_productCon.productList.value![index].productCode}');
                                        //

                                        Get.toNamed(
                                            '${AddComplainScreen.pageId}?productId=${installedList[index].id}&product_code=${installedList[index].productCode}');

                                      },
                                      child: _listItem(index));
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return Center(
                child: Text(languageMap['no_data_found']??"No data found"),
              );
          }
        }));
  }

  Widget _listItem(int index) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: grey),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              _imagePopup(installedList[index].image),
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
                        installedList[index].name ?? '',
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        '${languageMap['model_number']??'Model Number'} : ${installedList[index].model ?? ''}',
                        // list![index].quantity.toString(),

                        style: TextStyle(
                            color: black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),

                      // child: Text(
                      //   '${AppStringKey.quantity.tr}: ' +
                      //       _productCon.productList.value![index].qty.toString(),
                      //   style: TextStyle(
                      //       color: black, fontSize: 12, fontWeight: FontWeight.w500),
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${languageMap['product_code']??'Product Code'} : ${installedList[index].productCode ?? ''}',
                            //  list![index].invoice_no.toString().toString(),
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Column(
                            children: [
                              Text(
                                '${languageMap['warranty']??'Warranty'}',
                                //  list![index].invoice_no.toString().toString(),
                                style: TextStyle(
                                    color: black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${installedList[index].warrantyAvailable ?? ''}',
                                //  list![index].invoice_no.toString().toString(),
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Text(
                      //   '${AppStringKey.purchase_date.tr}: ' +
                      //       _productCon.productList.value![index].purchase_date
                      //           .toString(),
                      //   style: TextStyle(
                      //       color: black, fontSize: 12, fontWeight: FontWeight.w500),
                      // ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Text(
                            '${languageMap['purchase_date']??'Purchase Date'}: ' +
                                installedList[index].purchaseDate.toString(),
                            style: TextStyle(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Text(
                            '${installedList[index].warranty_note ?? ''}',
                            style: TextStyle(
                                color: red,
                                fontSize: 8,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

