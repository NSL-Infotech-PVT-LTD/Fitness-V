import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/GroupClasses/group_classes.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  String _planImage;
  String _rolePlan = "";
  String _planName = "";
  String _roleCategory = "";
  String textFind ;
  List result;

  void initState() {
    getString(roleName)
        .then((value) => {_planName = value})
        .whenComplete(() => setState(() {}));

    getString(userPlanImage)
        .then((value) => {_planImage = value})
        .whenComplete(() => setState(() {}));

    getString(rolePlan)
        .then((value) => {_rolePlan = value})
        .whenComplete(() => setState(() {

       result = _rolePlan.split(":");
      print("print "+ result[0]);

      //_rolePlan == "quarterly"?"3 months":_rolePlane == "half_yearly"?"6 months":_rolePlan == "yearly"?"Annual":_rolePlan,

    }));

    getString(roleCategory)
        .then((value) => {_roleCategory = value})
        .whenComplete(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),

  Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical * 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 6,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: _planImage == null
                      ? Image.asset(
                    baseImageAssetsUrl + 'two_lady.jpg',
                    height: SizeConfig.blockSizeVertical * 25,
                    width: SizeConfig.blockSizeHorizontal * 90,
                    fit: BoxFit.cover,
                  )
                      : blackPlaceHolder(
                      baseImageAssetsUrl,
                      _planImage,
                      SizeConfig.blockSizeVertical * 25,
                      SizeConfig.blockSizeHorizontal * 90),
                ),
              ),
              Positioned(
                bottom: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset(
                      'assets/images/gredient.png',
                      height: SizeConfig.blockSizeVertical * 25,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                bottom: 65,
                left: 40,
                child: Text(
                  "Active Plan",
                  style: TextStyle(color: Colors.white, fontSize: textSize22),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 40,
                child: Text(
                  "Plan Name : ${_planName == null || _planName.isEmpty ? "Not found" : _planName}",
                  style: TextStyle(color: Colors.white, fontSize: textSize14),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 40,
                child: Text(
                  _roleCategory != null && _roleCategory.isNotEmpty?"Category : $_roleCategory":"",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.9), fontSize: 10),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 40,
                child: Text(

                  "${_rolePlan == null || _rolePlan.isEmpty ? "" : result[0].toString() == "quarterly"?"3 months : ${result[1].toString()}":result[0].toString() == "half_yearly"?"6 months : ${result[1].toString()}":result[0].toString() == "yearly"?"Annual : ${result[1].toString()}":_rolePlan}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8), fontSize: 10),
                ),
              ),
            ])),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: .5,
          color: CColor.PRIMARYCOLOR,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical * 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 6,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Image.asset(
                    baseImageAssetsUrl + 'dummy.png',
                    height: SizeConfig.blockSizeVertical * 25,
                    width: SizeConfig.blockSizeHorizontal * 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SvgPicture.asset(
                baseImageAssetsUrl + 'active.svg',
              ),
              Positioned(
                bottom: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset(
                      'assets/images/gredient.png',
                      height: SizeConfig.blockSizeVertical * 25,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                bottom: 85,
                left: 40,
                child: Text(
                  groupClasses,
                  style: TextStyle(color: Colors.white, fontSize: textSize22),
                ),
              ),
              Positioned(
                bottom: 70,
                left: 40,
                child: Text(
                  'Check out our group classes and best offers',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                width: SizeConfig.blockSizeHorizontal * 90,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => GroupClass()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff2C2C2C),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7))),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )),
                ),
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        Divider(
          height: .5,
          color: CColor.PRIMARYCOLOR,
        ),

        SizedBox(
          height: 20,
        ),


//        Container(
//            padding: EdgeInsets.all(20),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SvgPicture.asset(
//                  baseImageAssetsUrl + 'filling_fast.svg',
//                  height: 30,
//                  fit: BoxFit.cover,
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                _planImage == null
//                    ? Image.asset(
//                        baseImageAssetsUrl + 'logo.png',
//                        height: SizeConfig.blockSizeVertical * 25,
//                        width: SizeConfig.blockSizeHorizontal * 90,
//                        fit: BoxFit.fill,
//                      )
//                    : blackPlaceHolder(
//                        IMAGE_URL,
//                        _planImage,
//                        SizeConfig.blockSizeVertical * 25,
//                        SizeConfig.blockSizeHorizontal * 90),
//                Text(_planName == null || _planName.isEmpty ? "" : _planName),
//                Text(_rolePlan == null || _rolePlan.isEmpty ? "" : _rolePlan),
//                SizedBox(
//                  height: 5,
//                ),
//              ],
//            )),
      ],
    );
  }
}
