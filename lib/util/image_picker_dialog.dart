import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
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

    return Dialog(
      backgroundColor: Colors.transparent,
      child: RoundCornerShape(
        bgColor: Colors.white,
        radius: DimenConstants.eight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Ink(
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DimenConstants.eight),
                      topRight: Radius.circular(DimenConstants.eight))),
              child: Padding(
                padding: const EdgeInsets.all(DimenConstants.tweleve),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Choose From',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            GestureDetector(
              onTap: galleryClick,
              child: Padding(
                padding: const EdgeInsets.all(DimenConstants.tweleve),
                child: Text('Gallary', textAlign: TextAlign.center),
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cameraClick,
              child: Padding(
                padding: const EdgeInsets.all(DimenConstants.tweleve),
                child: Text('Capture', textAlign: TextAlign.center),
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cancelClick,
              child: Padding(
                padding: const EdgeInsets.all(DimenConstants.tweleve),
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
