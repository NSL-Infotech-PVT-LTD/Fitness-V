import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:flutter_html/flutter_html.dart';

import 'Bookings/BookingConfirmed.dart';
import 'Methods/Method.dart';
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
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                back,
                style: TextStyle(fontSize: 16),
              ),
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
          SvgPicture.asset(imageUrl,)
        ],
      ),
      padding: EdgeInsets.fromLTRB(padding10, padding5, padding10, padding10),
    );

Widget bottomDialogLog() => CupertinoActionSheet(
      title: Text("Cupertino Action Sheet"),
      message: Text("Select any action "),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Action 1"),
          isDefaultAction: true,
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Text("Action 2"),
          isDestructiveAction: true,
          onPressed: () {},
        )
      ],
    );

void termsBottom(String title, String msg, context) {
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
                    Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )),
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
                        padding: EdgeInsets.all(20), child: Html(data: msg)),
                    SizedBox(
                      height: 5,
                    ),
                    footer(),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
          )));
        });
      });
}

Widget setNoDataContent() => Align(
    alignment: Alignment.center,
    child: Image.asset(baseImageAssetsUrl + 'place_holder.png'));

Widget fullWidthButton(context, String title, double setWidth, FontWeight bold, StatefulWidget whereToGO) =>
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

Widget finishAllScreenButton(context, String title, double setWidth,
        FontWeight bold, StatefulWidget whereToGO) =>
    Container(
      margin: EdgeInsets.only(top: padding15),
      height: button_height,
      width: setWidth,
      child: RaisedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context, ScaleRoute(page: whereToGO), (r) => false);
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

Future<bool> bookingFunction(String auth, context, String model_type,
    String model_id, String hours) async {
  print("modal Type "+model_type);
  bool isBooked = false;
  isConnectedToInternet().then((internet) {
    if (internet != null && internet) {
      showProgress(context, "Please wait.....");
      Map<String, String> parms = {
        "model_type": model_type,
        "model_id": model_id,
        if (model_type == trainerUsers) "hours": hours,
        if (model_type == classSchedules) "session": hours,
        if (model_type == sessionType) "session": hours,
      };

      bookingApi(auth, parms).then((response) {
        dismissDialog(context);

        print(response.status); 
        print(response.error); 

        if (response.status) {
          if (response.data != null && response.data.booking != null) {
            var name = '';

            if (response.data.booking.model_type == 'events' && response.data.booking.model_type != "") {
              name = response.data.booking.model_detail.name;
            } else if (response.data.booking.model_type == 'class_schedules') {
              name = response.data.booking.model_detail.class_detail.name;
            } else {
              name = response.data.booking.model_detail != null && response.data.booking.model_detail.full_name != null?response.data.booking.model_detail.full_name:"Sessions";
            }

            model_type == sessionType? Navigator.pushAndRemoveUntil(
                context,
                ScaleRoute(
                    page: BookingConfirmed(

                      createdAt: response.data.booking.created_at,
                      hours: hours,
                     // image: response.data.booking.model_type == 'class_schedules' ? response.data.booking.model_detail.class_detail.image : response.data.booking.model_detail.image,
                      name: "Session",
                     bookingId: response.data.booking.id.toString(),
//                  hours: response.data.booking.id.toString(),
                   //   modelType: response.data.booking.model_type,
                    )),
                    (r) => false): Navigator.pushAndRemoveUntil(
                context,
                ScaleRoute(
                    page: BookingConfirmed(
                  createdAt: response.data.booking.created_at,
                  hours: hours,
                  image: response.data.booking.model_type == 'class_schedules' ? response.data.booking.model_detail.class_detail.image : response.data.booking.model_detail.image,
                  name: name,
                      bookingId: response.data.booking.id.toString(),
//                  hours: response.data.booking.id.toString(),
                  modelType: response.data.booking.model_type,
                )),
                (r) => false);
          }
        } else {
          dismissDialog(context);
          if (response.error != null)
            showDialogBox(context, "Error!", response.error);
        }
      });
    } else {
      showDialogBox(context, internetError, pleaseCheckInternet);
      dismissDialog(context);
    }
  }).whenComplete(() => dismissDialog(context));
  return isBooked;
}

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
Widget footer(){
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.center,
        child: Image.asset(
          baseImageAssetsUrl + 'logo.png',
          height: 70,
          color: Colors.black,
          width: 120,
        ),
      ),
      Align(
          alignment: Alignment.center,
          child: Text(
            volt_rights,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 8,
                fontStyle: FontStyle.italic,
                fontFamily: open_italic),
          )),
      SizedBox(
        height: 20,
      ),
    ],
  ) ;
}

// void customBottomSheet({Widget widget, context}) {
//    showModalBottomSheet(
//      isScrollControlled: true,
//      backgroundColor: Colors.transparent,
//      context: context, builder: (context) {
//       return  widget;
//    },);
// }