import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/AuthScreens/SignupScreen.dart';
import 'package:volt/Bookings/select_session.dart';
import 'package:volt/MemberDashboard/DashboardChild/Cardio.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/util/starDisplay.dart';

import '../Methods.dart';

class TrainerDetail extends StatefulWidget {
  final int id;
  final bool fromForm;

  TrainerDetail({@required this.id, this.fromForm});

  @override
  State<StatefulWidget> createState() => TrainerDetailState();
}

class TrainerDetailState extends State<TrainerDetail>
    with SingleTickerProviderStateMixin {
  String fullName = '',
      expirence = '',
      services = '',
      specialities = '',
      about = '',
      imgLink;
  int valueHolder = 0;
  int trainees = 0, reviewsCount = 0;
  bool is_booked_by_me = false;
  TabController controller;
  String rating;
  List<Reviews> reviewList = List<Reviews>();
  List<RecomendedTrainerClass> trainerList = List<RecomendedTrainerClass>();
  int myId = 0;
  String auth = '';
  var _checkList;
  String _roleType = '';
  String deleteId = "";

  @override
  void initState() {
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {_getTrainerDetail(auth)});

    getString(roleType).then((value) => {_roleType = value});

    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  void _deleteBooking(String id) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Cancelling....");

        Map<String, String> parms = {
          'id': id,
        };
        bookingDeleteApi(auth, parms).then((response) {
          if (response.status) {
            if (response.data != null) {
              print(response.data.message);
              is_booked_by_me = false;
              setState(() {});
            }
          } else {
            if (response.error != null) ;
            showDialogBox(context, "Error!", response.error);
          }
        }).whenComplete(() => dismissDialog(context));
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
      }
    });
  }

  void doYoWantToCntinue() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Booking cancel"),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Do you want to continue ?",
                  style: TextStyle(wordSpacing: 1)),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                  if (is_booked_by_me) {
                    _deleteBooking(deleteId);
                  }
                },
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });

//  showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text(title),
//          content: Text(message),
//          actions: <Widget>[
//            FlatButton(
//              child: const Text('OK'),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ],
//        );
//      });
  }

  void _getTrainerDetail(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");
        Map<String, String> parms = {
          ID: widget.id.toString(),
        };
        getTrainersDetailApi(auth, parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null && response.data.trainer != null) {
              fullName = response.data.trainer.full_name;
              imgLink = response.data.trainer.image;
              services = response.data.trainer.certifications;
              specialities = response.data.trainer.specialities;
              about = response.data.trainer.about;
              reviewsCount = response.data.trainer.booking_reviewed_cnt;
              rating = response.data.trainer.rating_avg;
              expirence = response.data.trainer.expirence;
              trainees = response.data.trainer.booking_cnt;
              is_booked_by_me = response.data.trainer.is_booked_by_me;
              print("isALready $is_booked_by_me");
              deleteId =
                  response.data.trainer.is_booked_by_me_booking_id.toString();

              if (response.data.related.length > 0) {
                _checkList = response.data.related;
                trainerList = List<RecomendedTrainerClass>.generate(
                    response.data.related.length,
                    (index) => RecomendedTrainerClass(
                        trainerName: response.data.related[index]['full_name'],
                        trainerExperience: '',
                        imgLink: response.data.related[index]['image']));
              }
              _getTrainerReview();
              setState((){});
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

  void _getTrainerReview() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        Map<String, String> parms = {
          trainer_id: widget.id.toString(),
        };
        getTrainerReviewsApi(auth, parms).then((response) {
          if (response.status) {
            if (response.data != null && response.data.data != null) {
              reviewList = List<Reviews>.generate(
                  response.data.data.length,
                  (i) => Reviews(
                      imageUrl: response.data.data[i]['created_by_detail']
                          ['image'],
                      title: response.data.data[i]['review'],
                      text1: 'Posted on ' +
                          DateFormat("dd/MM/yyyy").format(
                              DateFormat("yyyy-MM-dd").parse(
                                  response.data.data[i]['created_at']))));
              setState(() {});
            }
          } else {
            if (response.error != null)
              showDialogBox(context, "Error!", response.error);
          }
        });
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
      }
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    myId = widget.id;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              iconTheme: IconThemeData(color: Colors.transparent),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 35,
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
                            Spacer(),
//                            PopupMenuButton<String>(
//                              onSelected: handleClick,
//                              itemBuilder: (BuildContext context) {
//                                return {'Settings'}.map((String choice) {
//                                  return PopupMenuItem<String>(
//                                    value: choice,
//                                    child: Text(choice),
//                                  );
//                                }).toList();
//                              },
//                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: .5,
                      color: CColor.PRIMARYCOLOR,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: SizeConfig.blockSizeHorizontal * 50,
                            height: SizeConfig.blockSizeVertical * 25,
                            child: Stack(children: <Widget>[
                              Positioned(
                                bottom: imgLink == null ? 60 : 6,
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: imgLink == null
                                        ? Image.asset(
                                            baseImageAssetsUrl +
                                                'place_holder.png',
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    15,
                                          )
                                        : FadeInImage.assetNetwork(
                                            placeholder: baseImageAssetsUrl +
                                                'logo_black.png',
                                            image: BASE_URL +
                                                'uploads/trainer-user/' +
                                                imgLink,
//                                    fit: BoxFit.cover,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    50,
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    25,
                                          )),
                              ),
//                      SvgPicture.asset(
//                        baseImageAssetsUrl + 'popular.svg',
//                      ),
                            ])),
                        Container(
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: SizeConfig.blockSizeVertical * 30,
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        fullName.isEmpty ? '' : fullName,
                                        style: TextStyle(fontSize: 17),
                                      ),
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
                                Text(
                                    expirence == null
                                        ? 'No experience'
                                        : expirence + " years of experience",
                                    style: TextStyle(fontSize: 10)),
                                Text(
                                    trainees.toString() +
                                        ' Trainees ($reviewsCount Reviews)',
                                    style: TextStyle(fontSize: 10)),
                                Padding(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StarDisplayWidget(
                                        value: rating == null
                                            ? 0.0
                                            : double.parse(rating),
                                        filledStar: Icon(Icons.star,
                                            color: Colors.black, size: 20),
                                        unfilledStar: Icon(Icons.star,
                                            color: CColor.PRIMARYCOLOR,
                                            size: 20),
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: padding15),
                                  height: 45,
                                  width: 150,
                                  child:Visibility(
                                    visible:!widget.fromForm,
                                    child: RaisedButton(
                                            onPressed: () {
                                             if(!is_booked_by_me){
                                               Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectSession(
                                                 id: widget.id,
                                                 image: imgLink,
                                                 isGroupClass: false,
                                                 name: fullName,
                                                 roleType: _roleType,
                                               )));
                                             }
                                            else{
                                               doYoWantToCntinue();
                                             }
                                            },
                                            color: is_booked_by_me
                                                ? CColor.CancelBTN
                                                : Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        button_radius)),
                                            child: Text(
                                              is_booked_by_me
                                                  ? alreadyBooked
                                                  :  book_now,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      is_booked_by_me ? 8 : 16),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight: SizeConfig.blockSizeVertical * 43,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10.0),
                // Add this code
                child: Container(
                  color: Color(0xffE1E1E1),
                  width: SizeConfig.screenWidth,
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 1.0),
                        insets: EdgeInsets.symmetric(horizontal: 16.0)),
                    indicatorColor: Colors.black,
                    isScrollable: true,
                    controller: controller,
                    unselectedLabelColor: Colors.black26,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Tab(
                          child: Text(
                            'Reviews',
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: DefaultTabController(
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        'About Trainer',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        about == null
                            ? 'Farly has 30 years’ experience in the fitness industry and in body building competitions. Mr. Phil-Asia 2015. Runner Up NABBA universe 2015. Mr. Philippines 2013. Mr. Asia-Pacific 2011.'
                            : about,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Divider(
                        height: .5,
                        color: CColor.PRIMARYCOLOR,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Text(
                        'Certifications',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        services == null
                            ? 'Personal Trainer REPS Level 2, Stability Ball, Kettle Bell, TRX Suspension training Level 1.'
                            : services,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Divider(
                        height: .5,
                        color: CColor.PRIMARYCOLOR,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Text(
                        'Specialities',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        specialities == null
                            ? 'Body building. Fitness. Strength and Conditioning. Diet and Nutrition. Supplementation. Contest Prep.'
                            : specialities,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Column(
                      children: [],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Divider(
                        height: .5,
                        color: CColor.PRIMARYCOLOR,
                      ),
                    ),
                    Visibility(
                      visible: !widget.fromForm,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                            trainerList.length > 0 ? 'Related Trainers' : '',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    Visibility(
                      visible: !widget.fromForm,
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 0, bottom: 20),
                          child: Container(
                            height: 200,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  child: RecomendedTrainer(
                                    trainerClass: trainerList[index],
                                    callback: () {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  TrainerDetail(
                                                    fromForm: false,
                                                    id: _checkList[index]['id'],
                                                  )));
                                    },
                                  ),
                                );
                              },
                              itemCount:
                                  trainerList == null ? 0 : trainerList.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              reviewList.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),
                      physics: BouncingScrollPhysics(),
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: reviewList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: reviewList.length > 0
                              ? CustomReviews(
                                  items: reviewList[index],
                                )
                              : Image.asset(
                                  baseImageAssetsUrl + 'no_reviews.png',
                                  height: 50,
                                  width: 50,
                                ),
                        );
                      })
                  : Visibility(visible: false,child: Image.asset(baseImageAssetsUrl + 'no_reviews.png')),
            ],
          ),
          length: 2,
        ),
      ),
    );
  }
}

class Reviews {
  final String imageUrl;
  final String title;
  final int rating;
  final String text1;

  const Reviews({this.imageUrl, this.title, this.rating, this.text1});
}

class CustomReviews extends StatelessWidget {
  final Reviews items;

  const CustomReviews({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              items.imageUrl == null
                  ? baseImageAssetsUrl + 'logo_black.png'
                  : BASE_URL + IMAGE_URL + items.imageUrl,
              width: 35,
              height: 35,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Text(
                    items.title == null ? 'No Review Found' : items.title,
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
                Padding(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StarDisplayWidget(
                        value: items.rating == null ? 0 : items.rating,
                        filledStar:
                            Icon(Icons.star, color: Colors.black, size: 20),
                        unfilledStar: Icon(Icons.star,
                            color: CColor.PRIMARYCOLOR, size: 20),
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15, top: 10),
                ),
                Padding(
                  child: Text(
                    items.text1 == null ? '' : items.text1,
                    style: TextStyle(fontSize: 6, color: Colors.black26),
                    textAlign: TextAlign.start,
                  ),
                  padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                )
              ],
            ))
          ],
        ));
  }

//  Widget _showSession(context, String _imageLink,var valueHolder) => ;
//
}
