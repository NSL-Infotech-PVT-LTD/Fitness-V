import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Methods.dart';
import 'package:volt/AuthScreens/LoginScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<SignupScreen> {
  String baseImageUrl = 'assets/images/';
  String radioItem = '';
  String radioItemMarital = '';
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              backgroundColor: Colors.black,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Container(
                  margin: EdgeInsets.fromLTRB(0, topMargin, 0, 0),
                  height: 300,
                  width: SizeConfig.screenWidth,
                  color: Colors.black,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: 0,
                          right: 0,
                          top: padding50,
                          child: Image.asset(
                            baseImageUrl + 'exc_sign.png',
                            height: 111,
                          )),
                      Positioned(
                        left: 50,
                        bottom: padding50 + padding30,
                        child: Image.asset(baseImageUrl + 'user_sign.png'),
                      ),
                      Positioned(
                        left: 90,
                        bottom: padding50 + padding30,
                        child: Text(
                          signup,
                          style: TextStyle(
                              color: CColor.WHITE, fontSize: textSize24),
                        ),
                      ),
                      Positioned(
                        left: 90,
                        right: 60,
                        bottom: padding45,
                        child: Padding(
                          child: Text(
                            'Please give us your details to enjoy our premium experience',
                            style: TextStyle(
                                color: CColor.WHITE, fontSize: textSize12),
                          ),
                          padding: EdgeInsets.fromLTRB(5, 10, 20, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(
                    padding50, padding30, padding50, padding30),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Enter your personal details below: ',
                      style: TextStyle(
                          color: Color(0xFF707070), fontSize: textSize14),
                    ),
                    myText(firstname, false),
                    myText(midlename, false),
                    myText(lastname, false),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      radiobutton(male),
//                      radiobutton(female),
//                      radiobutton(child),
//                    ],
//                  ),
                    myText(mobile, true),
                    myText(emergencyContact, true),
                    myText(email, false),
                    Container(
                      margin: EdgeInsets.only(top: margin20, bottom: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(button_radius)),
                          border: Border.all(color: Colors.black26, width: 1)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                birthDate,
                                style: TextStyle(
                                    fontSize: textSize10,
                                    color: Colors.black45),
                              )),
                          Spacer(),
                          Container(
                            height: 50,
                            width: 40,
                            color: Color(0xFFDFDFDF),
                            child: Image(
                              image: AssetImage(baseImageUrl + 'calendar.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        radioMerital(single),
                        radioMerital(married),
                      ],
                    ),
                    myText(designation, false),
                    myText(emiratesId, false),
                    myText(address, false),
                    checkbox(iaccept, termsofService, acceptTerms),
                    fullWidthButton(context, signup, SizeConfig.screenWidth,
                        FontWeight.normal, LoginScreen())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myText(String hint, bool isNumber) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(fontSize: textSize10)),
      ),
    );
  }

  Widget radiobutton(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItem,
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItem = val;
          });
        },
      ),
    );
  }

  Widget radioMerital(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItemMarital,
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItemMarital = val;
          });
        },
      ),
    );
  }

  Widget checkbox(String title, String richTExt, bool boolValue) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                acceptTerms = value;
                if(value){
                  termsBottom('Terms of Services');
                }
              });
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new RichText(
                text: new TextSpan(
                  text: title,
                  style: TextStyle(fontSize: textSize10, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: richTExt,
                        style: TextStyle(
                            fontSize: textSize10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ],
                ),
              ),
            ),
            onTap: () {
              termsBottom('Terms of Services');
            },
          ),
        ],
      ),
    );
  }

  void termsBottom(String title) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(50.0),
                          topRight: const Radius.circular(50.0))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(loremIpsum,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                baseImageAssetsUrl + 'logo_black.png',
                                height: 90,
                                color: Color(0xff8B8B8B),
                                width: 120,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                baseImageAssetsUrl + 'vector_lady.svg',
                                height: 90,
                                width: 120,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              volt_rights,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff8B8B8B),
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: open_italic),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  )),
            ));
          });
        });
  }
}
