import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';

import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailAddressFieldController = TextEditingController();
  bool _validate1 = false;

  final _formKey = GlobalKey<FormState>();

  void forgotPassword() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        Map<String, String> parms = {
          EMAIL: _emailAddressFieldController.text,
        };
        resetPassword(parms).then((response) {

          dismissDialog(context);
          if (response.status) {


            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Check your inbox",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal)),
                    content: Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Text("Password reset link sent, please check inbox",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal)),
                    ),
                    actions: <Widget>[

                      CupertinoDialogAction(
                        child: Text("OK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        isDestructiveAction: true,
                      ),
                    ],
                  );
                });

          } else {
            var message = '';
            dismissDialog(context);
            //need to change
            if (response.error != null && response.error != "") {
              message = response.error.toString();
            } else if (response.errors != null) {
              message = response.errors.email;
            }
            if (message.isNotEmpty) {
              showDialogBox(context, "Error!", message);
            }
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
        key: _formKey,
        child: Scaffold(
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
                                    'assets/images/logo.png',
                                    height: SizeConfig.blockSizeVertical * 20,
                                    width: SizeConfig.blockSizeHorizontal * 60,
                                    fit: BoxFit.fill,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  'Forgot Password ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: textSize16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: open_light),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(bottom: 3),
                                  width: SizeConfig.screenWidth,
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        baseImageAssetsUrl + 'user.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: TextFormField(
                                            cursorColor: Colors.black,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            key: new Key('email'),
                                            controller:
                                                _emailAddressFieldController,
                                            decoration: new InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.error,
                                                    color: _validate1
                                                        ? Colors.red
                                                        : Colors.transparent,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 10),
                                                hintText: email),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (_emailAddressFieldController
                                          .text.isEmpty) {
                                        setState(() {
                                          _validate1 = true;
                                        });
                                      } else {
                                        _validate1 = false;
                                        forgotPassword();
                                      }
                                    },
                                    color: Color(0xff484848),
                                    padding: EdgeInsets.all(0.0),
                                    textColor: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      height: 50.0,
                                      width: SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                        gradient:LinearGradient(
                                          colors: [
                                             Color(0xff484848),
                                            Color(0xffCCCCCC)
                                          ]
                                        ),
                                        color: Color(0xff484848),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                      ),
                                      child: Text(
                                        'Submit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: textSize16,
                                            fontFamily: open_semi_bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}
