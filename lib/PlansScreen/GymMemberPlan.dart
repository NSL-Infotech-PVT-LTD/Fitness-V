import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/PlansScreen/ChoosedMemberShip.dart';
import 'package:volt/PlansScreen/spousetype.dart';
import 'package:volt/Screens/view_personal_trainer.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

// ignore: must_be_immutable
class GymMemberPlan extends StatefulWidget {
  List response;
  final gymMembers;

  GymMemberPlan({this.response, this.gymMembers});

  @override
  State<StatefulWidget> createState() => GymMemberState();
}

class GymMemberState extends State<GymMemberPlan> {
  CarouselSlider carouselSlider;
  CarouselController _carouselController;
  int _current = 0;

  var plansList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  bool signle = false;
  bool couple = false;
  bool family = false;
  int indexValue = 0;
  int currentSelectedIndex = -1;
  int slider = -1;
  int plan_index = 0;

  @override
  void initState() {
    super.initState();
    print("che" + widget.gymMembers);
  }

  List<PlansDetails> plansLists;
  List limit;
  String planIdS;
  String rolePlanIdS;

  @override
  Widget build(BuildContext context) {
    var response;
    int limiti = widget.response.length;
    List<Container> imgList = [];
    var value = [];

    for (var i = 0; i < limiti; i++) {
      value = widget.response[i]['plan_detail'];
      plansList = List<PlansDetails>.generate(value.length, (j) => PlansDetails(
          fee_type: value[j]['fee_type'],
          fee: value[j]['fee'].toString(),
          planId: value[j]['id'].toString(),
          rolePlanId: value[j]['role_id'].toString()));
      response = widget.response[i];
      imgList.add(cardView(
          widget.response[i]['image'],
          widget.response[i]['category'],
          widget.response[i]['name'],
          plansList,
          widget.response[i]));
    }

    limit = response['plan_detail'];
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
      body: SingleChildScrollView(
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
                              height: SizeConfig.screenHeight * .9,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              reverse: false,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 2000),
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
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

  Widget cardView(String imageLink, String planType, String planDetail, List<PlansDetails> plans, response) {
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
                              //  : Image.asset(baseImageAssetsUrl + 'logo_black.png',
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
                                  planType == "single"
                                      ? "Single"
                                      : planType == "couple"
                                      ? "Couple"
                                      : planType == "family_with_2"
                                      ? "Family"
                                      : planType,
                                  style: TextStyle(
                                      fontSize: textSize16,
                                      fontWeight: FontWeight.bold),
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
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
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
                                          });


                                        },
                                        child: Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child:index == currentSelectedIndex && _current == slider? ScaleAnimatedWidget(
                                              duration: Duration(milliseconds: 150),
                                              enabled:index == currentSelectedIndex && _current == slider,
                                              child: SvgPicture.asset('assets/icons/icon_selected.svg')) : SvgPicture.asset('assets/icons/icon_unselected.svg'),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                                      Text(
                                        plans[index].fee_type == "quarterly"
                                            ? "3 months"
                                            : plans[index].fee_type == "half_yearly"
                                            ? "6 months"
                                            : plans[index].fee_type == "yearly"
                                            ? "Annual"
                                            : plans[index].fee_type,
                                        style: TextStyle(
                                            fontSize: textSize12, fontWeight: FontWeight.normal),
                                      ),
                                      Spacer(),
                                      Text(
                                        plans[index].fee + ' AED',
                                        style:
                                        TextStyle(fontSize: textSize12, fontWeight: FontWeight.bold),
                                      ),
                                    ],
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
                    //     child: fullWidthButton(context, proceed, SizeConfig.screenWidth, FontWeight.bold, ChooseMemberShip(response: response, gymMembers: widget.gymMembers)
                    //     )),

                    Padding(
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

                              currentSelectedIndex == -1
                                  ? showDialogBox(context, "Choose Plan Alert",
                                  'Please choose your plan type')
                                  : checkRoll(response);
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(button_radius)),
                            child: Text(
                              'Proceed',
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

  checkRoll(response) {
    print('check ${response['category'].toString()}');
    if (response['category'].toString().toLowerCase() == 'couple') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => SpouseType(
                response: response['plan_detail'],
                plan_index: plan_index,
                type: "member",
                roleId: rolePlanIdS,
                rolePlanIds: planIdS,
                memberCount:
                response['member'] != null ? response['member'] : 0,
                gym_members: widget.gymMembers,
              )));
    } else if (response['category'].toString().toLowerCase() ==
        'family_with_2') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => SpouseType(
                response: response['plan_detail'],
                plan_index: plan_index,
                type: "member",
                roleId: rolePlanIdS,
                rolePlanIds: planIdS,
                memberCount: response['member'] != null ? response['member'] : 0,
                gym_members: widget.gymMembers,
              )));
    } else {
      //  plansList.forEach((element) {
      //   print(element.planId[0]);
      // });

      Navigator.push(
          context,
          ScaleRoute(
              page: SignupScreen(
                response: response['plan_detail'],
                planIndex: plan_index,
                isCityTrue: true,
                type: "member",
                isSingle: true,
                formType: "",
                roleId: planIdS,
                rolePlanId: rolePlanIdS,
              )));
    }
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


// class CustomPlansDetails extends StatelessWidget {
//   final PlansDetails items;
//   final index;
//   final currentIndex;
//
//   const CustomPlansDetails({Key key, @required this.items,this.index,this.currentIndex}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Padding(
//         padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//         child: Row(
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                   // currentSelectedIndex = index;
//                   // plan_index = index;
//                   // planIdS = plans[index].planId;
//                   // rolePlanIdS = plans[index].rolePlanId;
//                 },
//               child: Container(
//                 height: 20.0,
//                 width: 20.0,
//                 child:true// currentSelectedIndex == index
//                     ? ScaleAnimatedWidget(
//                     duration: Duration(milliseconds: 150),
//                     enabled:true ,//currentSelectedIndex == index,
//                     child: SvgPicture.asset(
//                         'assets/icons/icon_selected.svg'))
//                     : SvgPicture.asset(
//                     'assets/icons/icon_unselected.svg'),
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
//             Text(
//               items.fee_type == "quarterly"
//                   ? "3 months"
//                   : items.fee_type == "half_yearly"
//                       ? "6 months"
//                       : items.fee_type == "yearly"
//                           ? "Annual"
//                           : items.fee_type,
//               style: TextStyle(
//                   fontSize: textSize12, fontWeight: FontWeight.normal),
//             ),
//             Spacer(),
//             Text(
//               items.fee + ' AED',
//               style:
//                   TextStyle(fontSize: textSize12, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       myDivider()
//     ]);
//   }
// }


class CustomPlansDetails extends StatefulWidget {

  final PlansDetails items;
  final currentIndex;

  const CustomPlansDetails({Key key, @required this.items,this.currentIndex}) : super(key: key);


  @override
  _CustomPlansDetailsState createState() => _CustomPlansDetailsState();
}

class _CustomPlansDetailsState extends State<CustomPlansDetails> {

  var index = -1;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {

                  index = widget.currentIndex;

                  print(widget.currentIndex);
                  print(widget.items.planId);
                  print(widget.items.rolePlanId);
                  // currentSelectedIndex = index;
                  // plan_index = index;
                  // planIdS = plans[index].planId;
                  // rolePlanIdS = plans[index].rolePlanId;
                });


              },
              child: Container(
                height: 20.0,
                width: 20.0,
                child:index == widget.currentIndex ? ScaleAnimatedWidget(
                    duration: Duration(milliseconds: 150),
                    enabled:index == widget.currentIndex?true:false,
                    child: SvgPicture.asset('assets/icons/icon_selected.svg')) : SvgPicture.asset('assets/icons/icon_unselected.svg'),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
            Text(
              widget.items.fee_type == "quarterly"
                  ? "3 months"
                  : widget.items.fee_type == "half_yearly"
                  ? "6 months"
                  : widget.items.fee_type == "yearly"
                  ? "Annual"
                  : widget.items.fee_type,
              style: TextStyle(
                  fontSize: textSize12, fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Text(
              widget.items.fee + ' AED',
              style:
              TextStyle(fontSize: textSize12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      myDivider()
    ]);
  }
}