import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/PlansScreen/spousetype.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

// ignore: must_be_immutable
class UpgradePlan extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GymMemberState();
}

class GymMemberState extends State<UpgradePlan> {

  CarouselSlider carouselSlider;
  CarouselController _carouselController = CarouselController();
  int _current = 0;

  List<PlansDetails> plansList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }


  bool signle = false;
  String auth;
  bool couple = false;
  bool family = false;
  int indexValue = 0;
  int currentSelectedIndex = 0;//-1;
  int userCurrentFee;
  int userCurrentFeePlanId;
  int slider = 0;
  int plan_index = 0;
  List _response;
  String gymMembers;
  String roleCateType;
  int roleCateIndex;
  bool isLoading = true;
  int limiti;
  List<Container> imgList = [];
  var value = [];

  void upgradePlanFun() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        print('Upgrade Start');
        getString(USER_AUTH).then((value){
          auth = value;
        Map<String, String> parms = {
          ROLE_PLAN_ID: planIdS.toString(),
        };
        print("$parms");
        print("$auth");
        upGradePlan(auth,parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            print(response.status);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                LoginScreen()), (Route<dynamic> route) => false);
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  String _category = "";
  String _nameFilter ="";
  @override
  void initState() {
    getString(USER_AUTH).then((value) => {auth = value});
   getString(roleCategory).then((value) => _category = value);
   getString(poolOrGym).then((value) => _nameFilter = value);
    readUserData(userData).then((value){
      print(_category);
      print(_nameFilter);
      if(value != null && (value as List).length > 0){
        _response = (value as List).where((element) => element['category'] == _category && element['name_filter'] == _nameFilter).toList();
      }
    }).whenComplete(() {
      setState((){});
    });
    getString(UserFeeType).then((value) {
      userCurrentFee = int.parse(value);
      print("user Current fee " + userCurrentFee.toString());
    });
    getString(userCurrentRoleID).then((value) {
      userCurrentFeePlanId = int.parse(value);
      print("userCurrentRoleID" + userCurrentFeePlanId.toString());
    });
    getString(poolOrGym).then((value) => gymMembers = value);
    getString(roleCategory).then((value) => roleCateType = value).then((value) {
      setState(() {
        roleCateIndex =  roleCateType == "single"?0:roleCateType == "couple"?1:roleCateType == "family_with_2"?2:0;
      });
    });
    //getRoleApi(context);
    super.initState();
    // print("che" + widget.gymMembers);
  }
  // void _getProfileDetail(String auth) async {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //       showProgress(context, "Please wait.....");
  //
  //       getProfileDetailApi(auth).then((_response) {
  //         dismissDialog(context);
  //         if (_response.status) {
  //           if (_response.data != null) {
  //
  //           }
  //         } else {
  //           dismissDialog(context);
  //           if (_response.error != null)
  //             showDialogBox(context, "Error!", _response.error);
  //         }
  //       });
  //     } else {
  //       showDialogBox(context, internetError, pleaseCheckInternet);
  //       dismissDialog(context);
  //     }
  //   });
  // }
  // Future<Status_response> getRoleApi(context) {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //       showProgress(context, "Loading....");
  //       getRoles().then((_response) {
  //         dismissDialog(context);
  //         if (_response.status) {
  //           // gym_list = _response.data.gym_members;
  //           // pool_and_beach_list = _response.data.pool_and_beach_members;
  //           // guest_list = _response.data.local_guest;
  //           // fairMont_list = _response.data.fairmont_hotel_guest;
  //         } else {
  //           showDialogBox(context, "Error!", _response.error);
  //         }
  //       }).whenComplete(() => dismissDialog(context));
  //     } else {
  //       showDialogBox(context, internetError, pleaseCheckInternet);
  //       dismissDialog(context);
  //     }
  //     dismissDialog(context);
  //   });
  // }

  List<PlansDetails> plansLists;
  List limit;
  String planIdS;
  String rolePlanIdS;
  String planPrice;
  String feeType;
  int indexOfSlider;
  int currentFee;
  @override
  Widget build(BuildContext context) {

    if(_response!=null){
      imgList.clear();
      isLoading = false;
      var response;
      limiti = _response.length;
//userCurrentFee
      for (var i = 0; i < limiti; i++) {
        value = _response[i]['plan_detail'] ;
        plansList.clear();
        for(int j = 0; j<value.length;j++){

          if(value[j]['fee'] >= userCurrentFee ){ //&& value[j]['role_id'] == //&&  userCurrentFeePlanId == value[j]['role_id']
            plansList.add(PlansDetails(
                fee_type: value[j]['fee_type'],
                fee:  value[j]['fee'].toString(),
                planId: value[j]['id'].toString(),
                rolePlanId: value[j]['role_id'].toString()
            ));
            // plansList = List<PlansDetails>.generate(j, (k)
            // {
            //   return PlansDetails(
            //       fee_type: value[k]['fee_type'],
            //       fee:  value[k]['fee'].toString(),
            //       planId: value[k]['id'].toString(),
            //       rolePlanId: value[k]['role_id'].toString()
            //   );
            // });
          }
        }

        response = _response[i];
        if(_response[i]['category'] == roleCateType){
          imgList.add(
              cardView(
                  _response[i]['image'],
                  _response[i]['category'],
                  _response[i]['name'],
                  plansList,
                  _response[i]));
        }
      }
      setState(() {
        imgList;
      });


      limit = response['plan_detail'];
    }

    // plansList = new List<PlansDetails>();
    //
    // for (int i = 0; i < limit.length; i++) {
    //   plansList.add(PlansDetails(
    //       fee_type: limit[i]['fee_type'],
    //       fee: limit[i]['fee'].toString(),
    //       planId: limit[i]['id'].toString(),
    //       rolePlanId: limit[i]['role_id'].toString(),
    //       choosePlan: false));
    // }

    indexValue = indexValue + 1;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: CColor.WHITE,
      body: isLoading?Column(children: [ SizedBox(height: SizeConfig.screenHeight * 0.50,),Center(child: Text("Something went wrong please",style: TextStyle(color:Colors.red),),),
      RaisedButton.icon(onPressed:()=> Navigator.pop(context), icon: Icon(Icons.settings_backup_restore) , label: Text("Back For Retry"))
      ]): SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.fromLTRB(padding20, padding10, padding20, 0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Choose Plan Type',
                        style: TextStyle(fontSize: textSize20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: padding50),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  height: 1,
                  child: myDivider(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 60, right: 60),
                child: Text('Please choose a plan.',
                    style: TextStyle(fontSize: textSize10, color: Colors.grey)),
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: indexValue % 2 == 0
                            ? SizeConfig.blockSizeVertical * 40
                            : SizeConfig.blockSizeVertical * 35,
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    ),
                    Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          carouselSlider = CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: SizeConfig.screenHeight * .8,
                              initialPage: 0,//roleCateIndex,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              reverse: false,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 2000),
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                _carouselController.animateToPage(roleCateIndex);
                                setState(() {
                                  _current = index;
                                  print("current index " + _current.toString());
                                });
                              },
                            ),
                            items: imgList,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(imgList, (index, url) {
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(width: 1, color: Colors.white),
                                  color: _current == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PlansDetails> planDetailList = List();

  Widget checkbox(
      String title, String richTExt, bool boolValue, int planValue) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Checkbox(
//            checkColor: Colors.white,
//            activeColor: Colors.black,
//            value: boolValue,
//            onChanged: (bool value) {
//              setState(() {
//                switch (planValue) {
//                  case 0:
//                    signle = value;
//                    break;
//                  case 1:
//                    couple = value;
//                    break;
//                  case 2:
//                    family = value;
//                    break;
//                }
//              });
//            },
//          ),
          new RichText(
              text: new TextSpan(
                  text: title,
                  style: TextStyle(fontSize: textSize12, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: richTExt,
                        style: TextStyle(
                            fontSize: textSize12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ])),
        ],
      ),
    );
  }

  Widget cardView(String imageLink, String planType, String planDetail, List<PlansDetails> plans, _response) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Card(
            color: CColor.WHITE,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(padding10),
                      decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: imageLink != null
                                  ? whitePlaceHolder(IMAGE_URL, imageLink,
                                  SizeConfig.screenHeight * .25, 0.0)
                              //  : Image.asset(baseImageAssetsUrl + 'logo.png',
                                  : Image.asset(
                                  baseImageAssetsUrl + 'poolBeach.jpg',
                                  width: SizeConfig.screenWidth * .6,
                                  fit: BoxFit.fitWidth,
                                  height: SizeConfig.screenHeight * .25)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 12, 10, 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  planType == "single" ? "Single" : planType == "couple" ? "Couple" : planType == "family_with_2" ? "Family" : planType,
                                  style: TextStyle(fontSize: textSize16, fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  planDetail,
                                  style: TextStyle(
                                      fontSize: textSize10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          // Expanded(
                          //   flex: 1,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //
                          //       setState(() {
                          //         print("dksjn ${plans[index].planId}");
                          //         currentSelectedIndex = index;
                          //         plan_index = index;
                          //         planIdS = plans[index].planId;
                          //         rolePlanIdS = plans[index].rolePlanId  ;
                          //       });
                          //       print(
                          //           "$currentSelectedIndex + ${plansList[index].planId} + $index");
                          //     },
                          //     child: Container(
                          //       height: 20.0,
                          //       width: 20.0,
                          //       child: currentSelectedIndex == index
                          //           ? ScaleAnimatedWidget(
                          //               duration: Duration(milliseconds: 150),
                          //               enabled: currentSelectedIndex == index,
                          //               child: SvgPicture.asset(
                          //                   'assets/icons/icon_selected.svg'))
                          //           : SvgPicture.asset(
                          //               'assets/icons/icon_unselected.svg'),
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //   flex: 2,
                          //child:
                          return  Container(
                              child:Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        slider = _current;
                                        currentSelectedIndex = index;
                                        print(currentSelectedIndex);
                                        print(plans[index].planId);
                                        print(plans[index].rolePlanId);
                                        currentSelectedIndex = index;
                                        plan_index = index;
                                        planIdS = plans[index].planId;
                                        rolePlanIdS = plans[index].rolePlanId;
                                        planPrice = plans[index].fee;
                                        feeType = plans[index].fee_type;
                                        print("check fee"+plans[index].fee_type);
                                      });

                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child:index == currentSelectedIndex && _current == slider? ScaleAnimatedWidget(
                                              duration: Duration(milliseconds: 150),
                                              enabled:true,
                                              child: SvgPicture.asset('assets/icons/icon_selected.svg')) : SvgPicture.asset('assets/icons/icon_unselected.svg'),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                                        Text(
                                          plans[index].fee_type == "quarterly" ? "3 months" : plans[index].fee_type == "half_yearly" ? "6 months"
                                              : plans[index].fee_type == "yearly"
                                              ? "Annual"
                                              : plans[index].fee_type,
                                          style: TextStyle(
                                              fontSize: textSize12, fontWeight: FontWeight.normal),
                                        ),
                                        Container(width: SizeConfig.screenWidth* 0.25,color: Colors.white,height: SizeConfig.screenHeight * 0.03,),
                                        Spacer(),
                                        Text(
                                          plans[index].fee + ' AED',
                                          style:
                                          TextStyle(fontSize: textSize12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                myDivider()
                              ])
                            // CustomPlansDetails(
                            //   items: plans[index],
                            //   currentIndex:index,
                            //   // currentIndex: ,
                            //   // index: ,
                            // )
                          );
                          //),
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                      child: Column(
                        children: <Widget>[
                          checkbox("Free", ' Group Classes', signle, 0),
                          checkbox("Pay For", ' Personal Trainer', couple, 1),
                          //   checkbox("Pay For", ' Pool & Beaches', family, 2),
                        ],
                      ),
                    ),
                    // Padding(
                    //     padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    //     child: fullWidthButton(context, proceed, SizeConfig.screenWidth, FontWeight.bold, ChooseMemberShip(_response: _response, gymMembers: widget.gymMembers)
                    //     )),

                    Visibility(
                      visible: feeType == "yearly",
                      child: Padding(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: Container(
                            margin: EdgeInsets.only(top: padding15),
                            height: 50,
                            width: SizeConfig.screenWidth,
                            child: RaisedButton(
                              onPressed: () {
//                        Navigator.pushReplacement(
//                            context,
//                            new MaterialPageRoute(builder: (context) =>FamilyWithTwo()));     //SpouseType()));
                                currentSelectedIndex == -1 ? showDialogBox(context, "Choose Plan Alert", 'Please choose your plan type') :upgradePlanFun();
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(button_radius)),
                              child: Text(
                                'Upgrade',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          )
//                fullWidthButton(
//                context,
//                'Proceed',
//                SizeConfig.screenWidth,
//                FontWeight.bold,
//              )
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget plans(String fee_type, String fee) {
    Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Row(
        children: <Widget>[
          Text(
            fee_type,
            style:
            TextStyle(fontSize: textSize12, fontWeight: FontWeight.normal),
          ),
          Spacer(),
          Text(
            fee + ' AED',
            style: TextStyle(fontSize: textSize12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

}

class PlansDetails {
  final String fee_type;
  final String fee;
  final String planId;
  final String rolePlanId;
  bool choosePlan;

  PlansDetails(
      {this.fee_type, this.fee, this.choosePlan, this.planId, this.rolePlanId});
}


