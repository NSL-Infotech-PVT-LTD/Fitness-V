import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Value/CColor.dart';

import 'Value/Dimens.dart';
import 'Value/Strings.dart';

Widget myDivider() => Divider(
      height: 2,
      color: CColor.DividerCOlor,
    );

Widget backWithArrow(context) => Container(
      child: Row(
        children: <Widget>[
         GestureDetector(child:  Icon(Icons.arrow_back_ios),onTap: (){
           Navigator.pop(context);
         },),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              back,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(padding10, padding5, 0, 10),
    );

Widget backWithArrowAndIcon(String imageUrl) => Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.arrow_back_ios),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              back,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(),
          SvgPicture.asset(imageUrl)
        ],
      ),
      padding: EdgeInsets.fromLTRB(padding10, padding5, padding10, padding10),
    );

Widget fullWidthButton(context, String title, double setWidth, FontWeight bold,
        StatefulWidget whereToGO) =>
    Container(
      margin: EdgeInsets.only(top: padding15),
      height: button_height,
      width: setWidth,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => whereToGO));
        },
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(button_radius)),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: bold, fontSize: 16),
        ),
      ),
    );
