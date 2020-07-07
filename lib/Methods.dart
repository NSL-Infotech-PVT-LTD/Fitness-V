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
          GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
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

void termsBottom(String title, context) {
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
Widget fullWidthButton(context, String title, double setWidth, FontWeight bold,
        StatefulWidget whereToGO) =>
    Container(
      margin: EdgeInsets.only(top: padding15),
      height: button_height,
      width: setWidth,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: whereToGO));
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

class SizeRoute extends PageRouteBuilder {
  final Widget page;

  SizeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}



class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
