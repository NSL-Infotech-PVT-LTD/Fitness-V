import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class EventDetail extends StatefulWidget {
  final int id;
  final String status;

  EventDetail({@required this.id, this.status});

  @override
  State<StatefulWidget> createState() => EventDetailState();
}

class EventDetailState extends State<EventDetail> {
  String _imageLink;
  String _about='';
  String _eventName='';
  String _eventLocation='';
  String _eventTime='';

  @override
  void initState() {
    String auth = '';
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {getEventDetail(auth)});
    super.initState();
  }

  void getEventDetail(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        Map<String, String> parms = {
          ID: widget.id.toString(),
        };
        getEventDetailsApi(auth, parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              print("Even=====>"+response.toJson().toString());
              _eventName = response.data.name;
              _imageLink = response.data.image;
              _about = response.data.description;
              _eventLocation = response.data.location_detail.location;
              _eventTime = "From : " +
                  response.data.start_date +
                  "\nTo      : " +
                  response.data.end_date;

              setState(() {});
            }
          } else {
            dismissDialog(context);
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, 'Internet Error', pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  backWithArrow(context),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.status,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize18,
                                  fontFamily: open_light),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              baseImageAssetsUrl + 'cardio.svg',
                              height: 18,
                              width: 18,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  ),
                  _imageLink == null
                      ? Image.asset(baseImageAssetsUrl + 'logo_black.png')
                      : setImage(widget.status, _imageLink),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10, 8.0, 5),
                    child: Text(
                      _eventName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize14,
                          fontFamily: open_light),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10, 8.0, 5),
                    child: Text(
                      _eventTime,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize14,
                          fontFamily: open_light),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 8.0, 10),
                    child: Text(
                      _eventLocation,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize12,
                          fontFamily: open_light),
                    ),
                  ),
                  Container(
                    color: CColor.PRIMARYCOLOR,
                    height: 50,
                    width: SizeConfig.screenWidth,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "About",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: textSize18,
                            fontFamily: open_light),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10, 8.0, 10),
                    child: Text(
                      _about == null ? loremIpsum : _about,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize12,
                          fontFamily: open_light),
                    ),
                  ),
                ])));
  }

  Widget setImage(String status, String imgLink) => status == recent
      ? ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
          child: blackPlaceHolder(imageUrlEvent,
              imgLink, SizeConfig.screenHeight * .25, SizeConfig.screenWidth))
      : blackPlaceHolder(
      imageUrlEvent,  imgLink, SizeConfig.screenHeight * .25, SizeConfig.screenWidth);
}
