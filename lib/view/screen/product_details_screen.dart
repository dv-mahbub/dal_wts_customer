import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/product_controller.dart';
import 'package:wts_customer/helping/appStringFile.dart';
import 'package:wts_customer/model/product_info_model.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/complain_creation_result_screen.dart';
import 'package:wts_customer/widget/button_common.dart';
import 'package:get/get.dart';
import 'package:wts_customer/widget/commons.dart';
import 'package:wts_customer/widget/loading.dart';

class InstallationCheckListScreen extends StatefulWidget {
  static const pageId = "/installationCheckListScreen";
  // String installationCheckList =
  //     Get.parameters['installationCheckList'].toString();
  List<InstallationRequirements>? installationCheckList;
  String? name = Get.parameters['name'].toString();
  String isInstalled = Get.parameters['isInstalled'].toString();
  String preparation_done = Get.parameters['preparation_done'].toString();
  String product_code = Get.parameters['product_code'].toString();
  String product_id = Get.parameters['product_id'].toString();

  InstallationCheckListScreen({required this.installationCheckList,required this.name,required this.isInstalled,
    required this.preparation_done,required this.product_code,required this.product_id});

  @override
  _InstallationCheckListScreenState createState() =>
      _InstallationCheckListScreenState();
}

class _InstallationCheckListScreenState
    extends State<InstallationCheckListScreen> {
  TextEditingController textFieldComController = TextEditingController();
  ProductController _productCon = Get.find<ProductController>();
  Map<String, dynamic> languageMap = Map();
  bool isLoading = false;
  bool isOverflowLoading = false;

  //List<dynamic> evaluationMap = [];
  List<InstallationRequirements> evaluationMap=[];
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

  int index = 0;
  bool isDataLoaded = false;

  getData() async {
    setState(() {
      isDataLoaded = true;
    });
    // print(
    //     '..........................evaluation..response.........${widget.complainId}...................');

    //evaluationMap = jsonDecode(widget.installationCheckList);
    evaluationMap = widget.installationCheckList!;
    if(evaluationMap.length>0)
      evaluationMap[0].isExpanded=true;


    print(
        '..........................evaluation..response.........${evaluationMap}...................');
    setState(() {
      isDataLoaded = false;
    });
  }

  @override
  void initState() {
    // widget.evList.forEach((element) {
    //   evaluationMap.add(element);
    // });
    print(
        '..........................ticket..ticket.........${widget.installationCheckList}...................');
    print('.....................product code ${widget.product_code}..................');
    print('.....................product product_id ${widget.product_id}..................');
    setLangueWiseContentInLocalMap();
    getData();
    super.initState();
  }

  bool isDissatisfay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        // appBar: AppBar(
        //   backgroundColor: StaticKey.APP_MAINCOLOR,
        //   title: Text(
        //     //languageMap['installation_check_flist'] ?? 'Installation Check List',
        //     widget.name!,
        //     style: TextStyle(color: white),
        //   ),
        // ),
        body: LoadingOverlay(
            child: SafeArea(
              child: Container(
                color: Colors.white,
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
                              widget.name!,
                              style: TextStyle(color: white,fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: isDataLoaded == false
                              ? Center(
                                child: Container(
                                  child: Column(children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      child: Text(
                                          widget.isInstalled == 'false'
                                              ? '${languageMap['installation_requirements'] ?? 'Installation Requirements'}'
                                              : '${languageMap['spare_parts'] ?? 'Spare Parts'}',
                                          style: TextStyle(
                                              color: StaticKey.APP_MAINCOLOR,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              height:
                                              MediaQuery.of(context).size.height - 200,
                                              width: double.infinity,
                                              margin: EdgeInsets.all(20),
                                              child:evaluationMap.length>0? ListView.builder(
                                                  itemCount: evaluationMap.length,
                                                  itemBuilder: (_, index) {
                                                    // setState(() {
                                                    //   evaluationMap[index]['isDissatisfay'] = false;
                                                    // });
                                              print('...........................fsdfsdfsdfsdfsdfdsfsdfsdfddfdsff');

                                                    return GestureDetector(
                                                      onTap: (){
                                                        _expandView(evaluationMap[index]);
                                                        // setState(() {
                                                        //   evaluationMap[index].isExpanded=!evaluationMap[index].isExpanded;
                                                        // });
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width: double.infinity,
                                                              padding: EdgeInsets.all(10),
                                                              margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(width: 1,color: StaticKey.APP_MAINCOLOR,),
                                                                  borderRadius:
                                                                  BorderRadius.all(

                                                                      Radius.circular(5)),

                                                                  color: Colors.white),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    // padding: EdgeInsets.all(10),
                                                                    // margin: EdgeInsets.all(1),
                                                                    // decoration: BoxDecoration(
                                                                    //     border: Border.all(width: 1),
                                                                    //     borderRadius:
                                                                    //     BorderRadius.all(
                                                                    //         Radius.circular(5)),
                                                                    //     color: Colors.white),
                                                                    child: Text(
                                                                        '${index + 1}. ${evaluationMap[index].name}',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 18,
                                                                            fontWeight:
                                                                            FontWeight.bold)),
                                                                  ),

                                                                  Visibility(
                                                                    visible: evaluationMap[index].isExpanded==true?true:false,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child: Text(
                                                                              '${evaluationMap[index].description}',
                                                                              style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 15,
                                                                                  fontWeight:
                                                                                  FontWeight.normal)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: index + 1 ==
                                                                  evaluationMap
                                                                      .length &&
                                                                  widget.isInstalled ==
                                                                      'false'&& widget.preparation_done=='0'
                                                                  ? true
                                                                  : false,
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 5, horizontal: 5),
                                                                margin: EdgeInsets.symmetric(
                                                                    vertical: 0, horizontal: 5),
                                                                child: Center(
                                                                  child: TextButtonCommon(
                                                                    fontSize: 15,
                                                                    text:
                                                                    '${languageMap['preparation_done'] ?? 'Preparation Done'}',
                                                                    callBack: () async {
                                                                      FocusScopeNode
                                                                      currentFocus =
                                                                      FocusScope.of(
                                                                          context);
                                                                      if (!currentFocus
                                                                          .hasPrimaryFocus) {
                                                                        currentFocus.unfocus();
                                                                      }

                                                                      setState(() {
                                                                        isOverflowLoading =
                                                                        true;
                                                                      });
                                                                      await _productCon
                                                                          .submitPreparetion(widget.product_id,widget.product_code);

                                                                      setState(() {
                                                                        isOverflowLoading =
                                                                        false;
                                                                      });
                                                                      switch (_productCon
                                                                          .status.value) {
                                                                        case Status.LOADING:
                                                                          print(
                                                                              '..............LOADING LOADING..................');
                                                                          break;
                                                                        case Status.SUCCESS:
                                                                          print(
                                                                              '..............SUCCESS SUCCESS..................');

                                                                          Get.back();
                                                                          //  Get.offAndToNamed(
                                                                          //     ComplainCreationResultScreen.pageId);
                                                                          break;
                                                                        case Status.ERROR:
                                                                          print(
                                                                              '..............APIERROR APIERROR..................');
                                                                          break;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }):Center(child: Text(languageMap['no_data_found'] ?? "No data found")),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )
                              : Loading(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoading: Get.find<ComplainController>().isLoading.value));
  }


  _expandView(InstallationRequirements selectedItem){
    evaluationMap.forEach((element) {

      if(element==selectedItem){
        setState(() {
         // evaluationMap[index].isExpanded=!evaluationMap[index].isExpanded;
          element.isExpanded=true;
        });
      }else{
        setState(() {
          element.isExpanded=false;
        });
      }


    });

  }

}
