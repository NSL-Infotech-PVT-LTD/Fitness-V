import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/PlansScreen/ChoosedMemberShip.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

// ignore: must_be_immutable
class GymMemberPlan extends StatefulWidget {
  List response;

  GymMemberPlan({this.response});

  @override
  State<StatefulWidget> createState() => GymMemberState();
}

class GymMemberState extends State<GymMemberPlan> {
  CarouselSlider carouselSlider;
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

  @override
  void initState() {
    print("CheckResponse " + widget.response.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int limit = widget.response.length;
    List<Container> imgList = [];

    var value = [];

    for (var i = 0; i < limit; i++) {
      value = widget.response[i]['plan_detail'];
      plansList = List<PlansDetails>.generate(
          value.length,
          (j) => PlansDetails(
              fee_type: value[j]['fee_type'], fee: value[j]['fee'].toString()));

      imgList.add(cardView(
          widget.response[i]['image'],
          widget.response[i]['category'],
          widget.response[i]['name'],
          plansList,
          widget.response[i]));
    }

    indexValue = indexValue + 1;
    print(indexValue);
    //  print((indexValue++).toString() + " nfkjsdfkds");
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
                child: Text(
                    'Selection of one plan Atleast is important to proceed in Gym Membership.',
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
                          height: SizeConfig.screenHeight * .9,
                          initialPage: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          reverse: false,
                          enableInfiniteScroll: false,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 2000),
                          pauseAutoPlayOnTouch: Duration(seconds: 5),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
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
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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

  Widget cardView(String imageLink, String planType, String planDetail,
      List plans, response) {
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
                                  ? FadeInImage.assetNetwork(
                                      placeholder:
                                          baseImageAssetsUrl + 'logo_white.png',
                                      image: BASE_URL + IMAGE_URL + imageLink,
                                      fit: BoxFit.cover,
                                      height: SizeConfig.screenHeight * .25,
                                    )
                                  : Image.asset(baseImageAssetsUrl + 'gym.png',
                                      fit: BoxFit.cover,
                                      height: SizeConfig.screenHeight * .25)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 12, 10, 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  planType,
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
                          return Container(
                              child: CustomPlansDetails(
                            items: plans[index],
                          ));
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
                          checkbox("Pay For", ' Pool & Beaches', family, 2),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: fullWidthButton(
                            context,
                            choosePlan,
                            SizeConfig.screenWidth,
                            FontWeight.bold,
                            ChooseMemberShip(
                              response: response,
                            )))
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

  const PlansDetails({this.fee_type, this.fee});
}

class CustomPlansDetails extends StatelessWidget {
  final PlansDetails items;

  const CustomPlansDetails({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Row(
          children: <Widget>[
            Text(
              items.fee_type,
              style: TextStyle(
                  fontSize: textSize12, fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Text(
              items.fee + ' AED',
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
