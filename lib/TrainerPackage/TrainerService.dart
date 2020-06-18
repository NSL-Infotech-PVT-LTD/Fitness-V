import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class TrainerService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TrainerServiceState();
}

class TrainerServiceState extends State<TrainerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(padding20, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        personal_trainer,
                        style: TextStyle(fontSize: textSize20),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: .5,
              color: CColor.PRIMARYCOLOR,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                height: SizeConfig.blockSizeVertical * 25,
                child: Stack(children: <Widget>[
                  Positioned(
                    bottom: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset(
                        baseImageAssetsUrl + 'dummy2.png',
                        fit: BoxFit.cover,
                        height: SizeConfig.blockSizeVertical * 25,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    baseImageAssetsUrl + 'popular.svg',
                  ),
                ])),
            Container(
                width: SizeConfig.blockSizeHorizontal * 35,
                height: SizeConfig.blockSizeVertical * 25,
                padding: EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Farley Willth',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          baseImageAssetsUrl + 'check_circle.svg',
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('7 years Experineced', style: TextStyle(fontSize: 10)),
                    Text('1022 Trainees (789 Reviews)',
                        style: TextStyle(fontSize: 10)),
                    Padding(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black12,
                            size: 20,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 10),
                    ),

                  ],
                )),
            Container(
              color: Color(0xffE1E1E1),
              width: SizeConfig.screenWidth,
              height: 50,
              padding: EdgeInsets.only(left: 20),
              child: Text('Select Services'),
            )
          ],
        ),
      ),
    );
  }
}
