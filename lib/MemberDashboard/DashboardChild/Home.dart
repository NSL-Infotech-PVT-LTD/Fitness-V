import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/GroupClasses/group_classes.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../GroupClassses.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE0E0E0),
                          blurRadius: 8.0,
                        ),
                      ]),
                      child: SvgPicture.asset(
                        baseImageAssetsUrl + 'free.svg',
                        height: 23,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Free 1 Day Pass',
                      style: TextStyle(fontSize: 12, color: Color(0xff707070)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  baseImageAssetsUrl + 'couple.png',
                  height: 165,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
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
                    baseImageAssetsUrl + 'family.png',
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
                          'Upgrade',
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
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  baseImageAssetsUrl + 'filling_fast.svg',
                  height: 30,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  baseImageAssetsUrl + 'two_lady.jpg',
                  height: SizeConfig.blockSizeVertical * 25,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
      ],
    );
  }
}
