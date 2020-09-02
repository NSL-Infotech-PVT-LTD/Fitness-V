import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:volt/Value/Strings.dart';
import 'dimens_constant.dart';
import 'round_corner_shape.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback galleryClick;
  final VoidCallback cameraClick;
  final VoidCallback cancelClick;

  ImagePickerDialog(
      {@required this.galleryClick,
      @required this.cameraClick,
      @required this.cancelClick});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: CupertinoActionSheet(
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "Choose From",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: open_semi_bold),
          ),
        ),
        message: Text(
          "Tap below to choose image from.",
          style: TextStyle(
              color: Colors.black.withOpacity(.4),
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Capture",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
            onPressed: cameraClick,
          ),
          CupertinoActionSheetAction(
              child: Text("Gallary",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300)),
              onPressed: galleryClick),
          CupertinoActionSheetAction(
            child: Text("Exit",
                style: TextStyle(
                    color: Color(0xFFB71C1C).withOpacity(.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
//
//    Dialog(
//      backgroundColor: Colors.transparent,
//      child: RoundCornerShape(
//        bgColor: Colors.white,
//        radius: DimenConstants.eight,
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Ink(
//              decoration: BoxDecoration(
//                  color: Colors.black,
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(DimenConstants.eight),
//                      topRight: Radius.circular(DimenConstants.eight))),
//              child: Padding(
//                padding: const EdgeInsets.all(DimenConstants.tweleve),
//                child: Align(
//                    alignment: Alignment.center,
//                    child: Text(
//                      'Choose From',
//                      style: TextStyle(color: Colors.white),
//                    )),
//              ),
//            ),
//            GestureDetector(
//              onTap: galleryClick,
//              child: Padding(
//                padding: const EdgeInsets.all(DimenConstants.tweleve),
//                child: Text('Gallary', textAlign: TextAlign.center),
//              ),
//            ),
//            Divider(
//              height: 1.0,
//              color: Colors.black,
//            ),
//            GestureDetector(
//              onTap: cameraClick,
//              child: Padding(
//                padding: const EdgeInsets.all(DimenConstants.tweleve),
//                child: Text('Capture', textAlign: TextAlign.center),
//              ),
//            ),
//            Divider(
//              height: 1.0,
//              color: Colors.black,
//            ),
//            GestureDetector(
//              onTap: cancelClick,
//              child: Padding(
//                padding: const EdgeInsets.all(DimenConstants.tweleve),
//                child: Text(
//                  'Cancel',
//                  textAlign: TextAlign.center,
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
