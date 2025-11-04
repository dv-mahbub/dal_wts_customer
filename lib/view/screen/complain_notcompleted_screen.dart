import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wts_customer/controller/complain_controller.dart';
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

class ComplainNotCompletedScreen extends StatefulWidget {
  static const pageId = "/complainnotcompletedscreen";

  String ticketId = Get.parameters['ticketId'].toString();


  @override
  _ComplainNotCompletedScreenState createState() =>
      _ComplainNotCompletedScreenState();
}

class _ComplainNotCompletedScreenState
    extends State<ComplainNotCompletedScreen> {
  TextEditingController textFieldComController = TextEditingController();

  ComplainController _complainController = Get.find();
  Map<String, dynamic> languageMap = Map();
  ComplainController _complainCon = Get.find<ComplainController>();

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

    print(
        '..........................productId...........${widget.ticketId}...................');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        body: Obx(
          () => SafeArea(
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
                            languageMap['complain_not_completed_title'] ??
                                'Complain Not Completed Reason',
                            style: TextStyle(color: white,fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoadingOverlay(
                      child: Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       Navigator.pop(context);
                                  //     },
                                  //     child: Icon(Icons.cancel)),
                                  SizedBox(
                                    width: 10,
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
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 150,
                                child: TextButtonCommon(
                                  fontSize: 15,
                                  backgroundColor: StaticKey.APP_MAINCOLOR,
                                  text: '${languageMap['submit'] ?? 'Submit'}',
                                  callBack: () async {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    // setState(() {
                                    //   isOverFlowLoading = true;
                                    // });

                                    await _complainCon.supportNotCompleted(
                                        widget.ticketId.toString(),
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
                                        Get.back();
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
                      )),
                      isLoading: Get.find<ComplainController>().isLoading.value),
                ],
              ),
            ),
          ),
        ));
  }
}
