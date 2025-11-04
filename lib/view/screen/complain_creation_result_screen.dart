import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/widget/button_common.dart';
import 'package:get/get.dart';
import 'package:wts_customer/widget/commons.dart';

class ComplainCreationResultScreen extends StatefulWidget {
  static const pageId = "/complainCreationResultScreen";

  //  String productId= Get.parameters['productId']!;
  @override
  _ComplainCreationResultScreenState createState() => _ComplainCreationResultScreenState();
}

class _ComplainCreationResultScreenState extends State<ComplainCreationResultScreen> {
  ComplainController _complainController = Get.find();
  Map<String, dynamic> languageMap = Map();

  @override
  void initState() {
    super.initState();
    setLangueWiseContentInLocalMap();
  }

  setLangueWiseContentInLocalMap() async{
    String? langCon = await MySharedPreference.getString(
        SharedPrefKey.LANGUAGE_WISE_CONTENT,
        defauleValue: null);
    if (langCon != null) {
      setState(() {
        setState(() {
          languageMap = jsonDecode(langCon.toString());
        });
      });
    }
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
                              languageMap['complain_created']?? 'Complain Created',
                            style: TextStyle(color: white,fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: LoadingOverlay(
                          child: Center(
                              child: Container(
                                margin: EdgeInsets.all(20),
                                child: Column(children: <Widget>[
                            SizedBox(
                                height: 20,
                            ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(5),
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(width: 0, color: grey),
                                    //     borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 20),
                                      child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.check,
                                          size: 120,
                                          color: StaticKey.APP_MAINCOLOR,
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(languageMap['complain_created_message']?? 'Your complain has been created successfully. One of our engineer will call you soon '
                               ,textAlign: TextAlign.center
                                ,style: TextStyle(color: Colors.red,

                              ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                            Center(
                                child: TextButtonCommon(
                                  backgroundColor: StaticKey.APP_MAINCOLOR,
                                  fontSize: 15,
                                  text: languageMap['create_another_complain']??'Create Another Complain',
                                  callBack: () {
                                    Get.back();
                                  },
                                ),
                            )
                          ]),
                              )),
                          isLoading: Get.find<ComplainController>().isLoading.value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
