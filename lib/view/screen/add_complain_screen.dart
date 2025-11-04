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

class AddComplainScreen extends StatefulWidget {
  static const pageId = "/addcomplainscreen";

    String productId= Get.parameters['productId']!;
    String product_code= Get.parameters['product_code'].toString()!;
  @override
  _AddComplainScreenState createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  TextEditingController textFieldComController = TextEditingController();

  ComplainController _complainController = Get.find();
  Map<String, dynamic> languageMap = Map();


  setLangueWiseContentInLocalMap() async{
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

    print('..........................productId...........${widget.productId}...................');
    print('..........................product_code...........${widget.product_code}...................');

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StaticKey.APP_MAINCOLOR,
        body: Obx(
          () => LoadingOverlay(
              child: SafeArea(
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
                                      languageMap['create_a_new_complain']?? 'Create a New Complain',
                                      style: TextStyle(color: white,fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(children: <Widget>[
                        SizedBox(
                            height: 20,
                        ),
                        Container(
                              child: TextField(
                                maxLines: 6,
                                controller: textFieldComController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: languageMap['write_your_complain_here']??'Write your complain here...',
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
                          Text('${languageMap['complain_instruction']??'Write Your complain here, if you do not know about  your complain,please submit blank field, we will contact with you soon. '}'
                            ,textAlign: TextAlign.center
                            ,style: TextStyle(color: Colors.red,

                          ),),
                              SizedBox(
                                height: 10,
                              ),
                        Center(
                            child: TextButtonCommon(
                              fontSize: 15,
                              backgroundColor: StaticKey.APP_MAINCOLOR,
                              text: '${languageMap['create_complain']??'Create Complain'}',
                              callBack: () async {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                await _complainController.addComplain(
                                    widget.productId,widget.product_code,
                                    textFieldComController.text.toString().trim());

                                switch (_complainController.status.value) {
                                  case Status.LOADING:
                                    print(
                                        '..............LOADING LOADING..................');
                                    break;
                                  case Status.SUCCESS:
                                    print(
                                        '..............SUCCESS SUCCESS..................');
                                    Get.offAndToNamed(ComplainCreationResultScreen.pageId);
                                    break;
                                  case Status.ERROR:
                                    print(
                                        '..............APIERROR APIERROR..................');
                                    break;
                                }
                              },
                            ),
                        )
                      ]),
                          )),
                    ],
                  ),
                ),
              ),
              isLoading: Get.find<ComplainController>().isLoading.value),
        ));
  }
}
