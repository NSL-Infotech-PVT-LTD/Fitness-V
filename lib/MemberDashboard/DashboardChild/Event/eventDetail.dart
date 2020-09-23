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
  String _about = '';
  String _eventName = '';
  bool _isBookedByMe = false;
  String _eventLocation = '';
  String _eventTime = '';
  String auth = '';

  @override
  void initState() {
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
            if (response.data != null &&
                response.data.location_detail != null) {
              _eventName = response.data.name;
              _imageLink = response.data.image;
              _isBookedByMe = response.data.is_booked_by_me;
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
        showDialogBox(context, internetError, pleaseCheckInternet);
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
                          fontSize: 17,
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
                      _eventLocation == null ? '' : _eventLocation,
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
                    padding: const EdgeInsets.fromLTRB(25.0, 10, 25.0, 20),
                    child: Text(
                      _about == null ? loremIpsum : _about,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize12,
                          fontFamily: open_light),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: _isBookedByMe
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: widget.status != recent,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: padding15),
                            height: button_height,
                            width: 150,
                            child: RaisedButton(
                              onPressed: () {
                                if (!_isBookedByMe)
                                  bookingFunction(auth, context, eventKey,
                                      widget.id.toString(), '');
                              },
                              color:
                                  _isBookedByMe ? Colors.black54 : Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(button_radius)),
                              child: Text(
                                _isBookedByMe ? alreadyBooked : book_now,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _isBookedByMe ? 13 : 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.status != recent && _isBookedByMe,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: padding15),
                            height: button_height,
                            width: 150,
                            child: RaisedButton(
                              onPressed: () {},
                              color: Color(0xFFD50000),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(button_radius)),
                              child: Text(
                                cancelBooking,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ])));
  }

  Widget setImage(String status, String imgLink) => status == recent
      ? ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
          child: FadeInImage.assetNetwork(
            placeholder: baseImageAssetsUrl + 'logo_black.png',
            image: BASE_URL + imageUrlEvent + imgLink,
            width: SizeConfig.screenWidth,
            fit: BoxFit.fill,
            height: SizeConfig.screenHeight * .35,
          ))
      : FadeInImage.assetNetwork(
          placeholder: baseImageAssetsUrl + 'logo_black.png',
          image: BASE_URL + imageUrlEvent + imgLink,
          fit: BoxFit.fill,
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * .35,
        );
}
// FadeInImage.assetNetwork(
//      placeholder: baseImageAssetsUrl + 'logo_black.png',
//      image: BASE_URL + roleUrl + imageLink,
//      width: width,
//      fit: BoxFit.cover,
//      height: height,
//    );
