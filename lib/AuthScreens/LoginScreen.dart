import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Screens/ProfileScreen.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  bool passwordVisible = true;

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CColor.WHITE,
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/splash_boy.png',
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/gredient.png',
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    color: Colors.black54,
                  ),
                  Positioned(
                    top: SizeConfig.blockSizeVertical * 20,
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                              child: Image.asset(
                                'assets/images/logo_white.png',
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              localGuest,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize16,
                                  fontFamily: open_light),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              existingAcc,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize16,
                                  fontFamily: open_light),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(bottom: 3),
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white10,
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    baseImageAssetsUrl + 'user.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:EdgeInsets.only(top: 8),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            hintText: userName),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(bottom: 15),
                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white10,
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    baseImageAssetsUrl + 'lock.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: passwordVisible,
                                        decoration: new InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Padding(
                                                padding: EdgeInsets.only(bottom: 10),
                                                child: Icon(
                                                  // Based on passwordVisible state choose the icon
                                                  passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: CColor.DividerCOlor,
                                                )),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });
                                            },
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, bottom: 13,top: 12),
                                          hintText: password,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen()));
                                },
                                color: Color(0xff484848),
                                padding: EdgeInsets.all(0.0),
                                textColor: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.only(top: 15),
                                  height: 50.0,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xff484848),
                                        Color(0xffCCCCCC)
                                      ],
                                    ),
                                    color: Color(0xff484848),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textSize16,
                                        fontFamily: open_semi_bold),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.group,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    'Guest Menu',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ProfileScreen()));
                              },
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
