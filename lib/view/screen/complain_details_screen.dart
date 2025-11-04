import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:wts_customer/model/complain_details_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';
import 'package:get/get.dart';

class ComplainDetailsScreen extends StatefulWidget {
  static const pageId = '/complainDetailsScreen';

  // String productId = Get.parameters['productId']!;
  // String complainId = Get.parameters['complainId']!;
  String ticketId = Get.parameters['ticketId']!;
  bool isInstalledDetails = Get.parameters['install_details']!=null;

  @override
  _ComplainDetailsScreenState createState() => _ComplainDetailsScreenState();
}

class _ComplainDetailsScreenState extends State<ComplainDetailsScreen> {
  ComplainController _complainCon = Get.find();
  late ComplainDetailsModel? _complainDetailsModel;

  Map<String, dynamic> languageMap = Map();
  bool isLoading= false;

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
  //  print(
   //     '........................ticketId.........${widget.ticketId}............');
    if (widget.isInstalledDetails==true)
      getInstallDetailsData();
    else
      getComplainDetailsData();
  }

  getComplainDetailsData() async {
    setState(() {
      isLoading=true;
    });
    _complainDetailsModel=  await _complainCon.getComplainDetails(widget.ticketId);
    print(
        '........................ticketId.........${widget.ticketId}............');
    setState(() {
      isLoading=false;
    });
  }

  getInstallDetailsData() async {
    setState(() {
      isLoading=true;
    });
    _complainDetailsModel= await _complainCon.getInstallDetails(widget.ticketId);
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        body: SafeArea(
          child:
          isLoading ==true? Loading():Container(
            // Use ListView.builder
              height: double.infinity,
              width: double.infinity,
             // margin: EdgeInsets.all(10),
              child: _buildMainBody()),


          // Obx(() {
          //   switch (_complainCon.status.value) {
          //     case Status.LOADING:
          //       return Loading();
          //     case Status.SUCCESS:
          //       _complainDetailsModel = _complainCon.complainDetailsModel.value;
          //       return
          //
          //     default:
          //       return Center(
          //         child: Text(languageMap['no_data_found'] ?? "No data found"),
          //       );
          //   }
          // }),
        ));
  }

  Widget _buildMainBody() {
    return Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 10,top: 10),
                            child: Icon(Icons.arrow_back_outlined,color: white,)),
                      ),
                      Center(
                        child: Text(
                          languageMap['complain_details'] ?? 'Complain Details',
                          style: TextStyle(color: white,fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(


                    children: [
                      Visibility(
                        visible: false,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            _complainDetailsModel?.image ??
                                'https://picsum.photos/250?image=9',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: double.infinity,
                              child: Container(
                                child: Text(
                                  '${ languageMap['product_details'] ?? 'Product Details'}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              // width: double.infinity,
                              child: Container(
                                child: Text(
                                  '#${widget.ticketId}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(languageMap['product'] ?? 'Product',
                                        _complainDetailsModel?.product_name),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['invoice_no'] ?? 'Invoice No',
                                        _complainDetailsModel?.invoice_no.toString()),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['product_id'] ?? 'Product Id',
                                        _complainDetailsModel?.product_id.toString()),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: double.infinity,
                                  child: _buildtem(
                                      languageMap['product_serial_number'] ??
                                          'Product Serial Number',
                                      _complainDetailsModel?.product_serial_number
                                          .toString()),
                                )),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(languageMap['brand'] ?? 'brand',
                                        _complainDetailsModel?.brand ?? ''),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['model_number'] ?? 'Model Number',
                                        _complainDetailsModel?.model),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(languageMap['voltage'] ?? 'Voltage',
                                        _complainDetailsModel?.voltage),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['warranty_period'] ?? 'Warranty Period',
                                        _complainDetailsModel?.warranty_period),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['warranty_available'] ??
                                            'Warranty Available',
                                        _complainDetailsModel?.warranty_availalbe),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                        height: 70,
                    width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                           // width: double.infinity,
                            child: Container(
                              child: Text(
                                '${ languageMap['service_details'] ?? 'Service Details'}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['service_note'] ?? 'service_note',
                                        _complainDetailsModel?.service_note ?? ''),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['installation_note'] ??
                                            'Installation Note',
                                        _complainDetailsModel?.installation_note ?? ''),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['support_engineer'] ??
                                            'Support Engineer',
                                        _complainDetailsModel?.support_engineer),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['assigned_date'] ?? 'Assigned Date',
                                        _complainDetailsModel?.assigned_date),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(languageMap['slot'] ?? 'slot',
                                        _complainDetailsModel?.slot),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['ticket_status'] ?? 'Ticket Status',
                                        _complainDetailsModel?.ticket_status),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['complete_date'] ?? 'Complete Date',
                                        _complainDetailsModel?.complete_date),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: double.infinity,
                                    child: _buildtem(
                                        languageMap['support_setup_note'] ??
                                            'Support Setup Note',
                                        _complainDetailsModel?.support_setup_note),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildtem(String title, String? value) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    value ?? '',
                    style: TextStyle(
                        color: black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: grey,
          )
        ],
      ),
    );
  }
}
