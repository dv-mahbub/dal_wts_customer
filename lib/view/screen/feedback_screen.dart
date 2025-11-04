import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
import 'package:wts_customer/widget/loading.dart';

class FeedBackScreen extends StatefulWidget {
  static const pageId = "/feedBackscreen";
  String complainId = Get.parameters['complainId'].toString();
  String support_engineer = Get.parameters['support_engineer'].toString();
  // List evList = jsonDecode(Get.parameters['evaluation'].toString());
  //
  String ticket = Get.parameters['ticketId'].toString();

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController textFieldComController = TextEditingController();
  ComplainController _complainCon = Get.find<ComplainController>();
  Map<String, dynamic> languageMap = Map();
  bool isLoading = false;
  bool isOverflowLoading = false;

  bool isYesClicked=false;

  List<Map<String, dynamic>> evaluationMap = [];

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

    var response = await _complainCon
        .supportCompletedToCustomer(widget.ticket.toString());
    print(
        '..........................evaluation..response.........${response}...................');
    if (response != null) {
      evaluationMap = response;

      // response.forEach((element) {
      //   evaluationMap.add(element);
      // });
      //
      // response.forEach((element) {
      //   evaluationMap.add(element);
      // });
      //
      // response.forEach((element) {
      //   evaluationMap.add(element);
      // });


      setState(() {
        isDataLoaded = false;
      });
    }
  }

  @override
  void initState() {
    // widget.evList.forEach((element) {
    //   evaluationMap.add(element);
    // });
    print(
        '..........................ticket..ticket.........${widget.ticket}...................');
    setLangueWiseContentInLocalMap();
    getData();
    super.initState();
  }

  bool isDissatisfay = false;

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
                          languageMap['give_your_feedback'] ?? 'Give Your FeedBack',
                          style: TextStyle(color: white,fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: LoadingOverlay(
                        child: isDataLoaded == false
                            ? Center(
                            child: Container(
                              child: Column(children: <Widget>[
                                Container(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height - 150,
                                          width: double.infinity,
                                          margin: EdgeInsets.all(20),
                                          child: ListView.builder(
                                              itemCount: evaluationMap.length,
                                              itemBuilder: (_, index) {
                                                // setState(() {
                                                //   evaluationMap[index]['isDissatisfay'] = false;
                                                // });
                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      margin: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(5)),
                                                          color: Colors.white),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              '${index + 1}. ${evaluationMap[index]['question']}',
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight.bold)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                              margin:
                                                              EdgeInsets.all(10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      evaluationMap[index]['isYesClicked']=true;
                                                                      evaluationMap[index]['rating'] =1;
                                                                      setState(() {
                                                                        evaluationMap[
                                                                        index]
                                                                        [
                                                                        'isDissatisfay'] =
                                                                        false;
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(5)),
                                                                            color: evaluationMap[index]['isYesClicked']==true? Colors.lightGreen[600]:Colors.lightGreen[400]),
                                                                        child: Text(languageMap['yes']?? 'Yes',style: TextStyle(color: Colors.white))),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      evaluationMap[index]['isYesClicked']=false;
                                                                      evaluationMap[index]['rating'] =0;
                                                                      setState(() {
                                                                        evaluationMap[
                                                                        index]
                                                                        [
                                                                        'isDissatisfay'] =
                                                                        true;
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(5)),
                                                                            color: evaluationMap[index]['isYesClicked']==false? Colors.red[600]:Colors.red[300]),
                                                                        child:  Text(languageMap['no']?? 'No',style: TextStyle(color: Colors.white),)),
                                                                  ),

                                                                ],
                                                              )),
                                                          // Container(
                                                          //     margin:
                                                          //     EdgeInsets.all(10),
                                                          //     child: RatingBar.builder(
                                                          //       initialRating: 0,
                                                          //       minRating: 1,
                                                          //       direction:
                                                          //       Axis.horizontal,
                                                          //       allowHalfRating: true,
                                                          //       itemCount: 5,
                                                          //       itemSize: 30,
                                                          //       itemPadding: EdgeInsets
                                                          //           .symmetric(
                                                          //           horizontal:
                                                          //           4.0),
                                                          //       itemBuilder:
                                                          //           (context, _) =>
                                                          //           Icon(
                                                          //             Icons.star,
                                                          //             color: Colors.green,
                                                          //           ),
                                                          //       onRatingUpdate:
                                                          //           (rating) {
                                                          //         evaluationMap[index]
                                                          //         ['rating'] =
                                                          //             rating;
                                                          //         if (rating <= 3.0) {
                                                          //           setState(() {
                                                          //             evaluationMap[
                                                          //             index]
                                                          //             [
                                                          //             'isDissatisfay'] =
                                                          //             true;
                                                          //           });
                                                          //         } else {
                                                          //           // evaluationMap[index]['dissatisfactory']=null;
                                                          //           setState(() {
                                                          //             evaluationMap[
                                                          //             index]
                                                          //             [
                                                          //             'isDissatisfay'] =
                                                          //             false;
                                                          //           });
                                                          //         }
                                                          //         print(
                                                          //             'rating ................${rating} visibility.....................${evaluationMap[index]['dissatisfactories'].length}');
                                                          //       },
                                                          //     )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Visibility(
                                                            visible: (evaluationMap[
                                                            index]
                                                            ['isDissatisfay'] ==
                                                                true),
                                                            child: Container(
                                                              height: 150,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    languageMap['dissatisfactory']?? "Dissatisfactory",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                  Expanded(
                                                                    child: ListView
                                                                        .builder(
                                                                        itemCount: evaluationMap[index]
                                                                        [
                                                                        'dissatisfactories']
                                                                            .length,
                                                                        itemBuilder:
                                                                            (_, i) {
                                                                          Map e = evaluationMap[
                                                                          index]
                                                                          [
                                                                          'dissatisfactories'][i];
                                                                          return Row(
                                                                            children: [
                                                                              Checkbox(
                                                                                value: e['isChecked'] == true
                                                                                    ? true
                                                                                    : false,
                                                                                onChanged:
                                                                                    (value) {
                                                                                  setState(() {
                                                                                    e['isChecked'] == true ? e['isChecked'] = false : e['isChecked'] = true;
                                                                                  });
                                                                                },
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text('${e['question']}')),
                                                                            ],
                                                                          );
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: index + 1 ==
                                                          evaluationMap.length
                                                          ? true
                                                          : false,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 5, horizontal: 5),
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: 0, horizontal: 5),
                                                        child: Center(
                                                          child: TextButtonCommon(
                                                            backgroundColor: StaticKey.APP_MAINCOLOR,
                                                            fontSize: 15,
                                                            text:
                                                            '${languageMap['submit'] ?? 'submit'}',
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
                                                                isOverflowLoading = true;
                                                              });
                                                              await _complainCon
                                                                  .submitEvaluation(
                                                                  jsonEncode(
                                                                      evaluationMap)
                                                                      .toString(),
                                                                  widget
                                                                      .complainId,widget.support_engineer);

                                                              setState(() {
                                                                isOverflowLoading = false;
                                                              });
                                                              switch (_complainCon
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
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : Loading(),
                        isLoading: Get.find<ComplainController>().isLoading.value),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
