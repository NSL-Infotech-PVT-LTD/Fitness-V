import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Bookings/YourBooking.dart';
import 'package:volt/MemberDashboard/DashboardChild/Cardio.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/TrainerPackage/TrainerService.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Methods.dart';

class TrainerDetail extends StatefulWidget {
  final int id;

  TrainerDetail({@required this.id});

  @override
  State<StatefulWidget> createState() => TrainerDetailState();
}

class TrainerDetailState extends State<TrainerDetail> {
  String fullName = '', services = '', about = '';
  int trainees = 0, reviewsCount = 0;
  String rating;

  @override
  void initState() {
    String auth = '';
    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {getTrainerDetail(auth)});
    super.initState();
  }

  void getTrainerDetail(String auth) async {
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
              services = response.data.trainer.services;
              about = response.data.trainer.about;
              reviewsCount = response.data.trainer.booking_reviewed_cnt;
              rating = response.data.trainer.rating_avg;
              trainees = response.data.trainer.booking_cnt;
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

  final trainerList = List<RecomendedTrainerClass>.generate(
      10,
      (index) => RecomendedTrainerClass(
          trainerName: 'Neo Faith',
          trainerExperience: '6.5 Year Experinece',
          imgLink: baseImageAssetsUrl + 'dummy2.png'));

  final reviewList = List<Reviews>.generate(
      10,
      (i) => Reviews(
          imageUrl: baseImageAssetsUrl + 'dummy2.png',
          title:
              "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text",
          text1: 'Posted on Thursday, 22/02/2020'));

  void handleClick(String value) {
    switch (value) {
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id.toString() + "=====>TrainerId");
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
                    PopupMenuButton<String>(
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return {'Settings'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              fullName.isEmpty ? 'Farley Willth' : fullName,
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
                        Text('7 years Experineced',
                            style: TextStyle(fontSize: 10)),
                        Text(
                            trainees.toString() +
                                ' Trainees ($reviewsCount Reviews)',
                            style: TextStyle(fontSize: 10)),
                        Padding(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                        fullWidthButton(context, book_now, 150,
                            FontWeight.normal, TrainerService())
                      ],
                    ))
              ],
            ),
            DefaultTabController(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Color(0xffE1E1E1),
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 1.0),
                              insets: EdgeInsets.symmetric(horizontal: 16.0)),
                          indicatorColor: Colors.black,
                          isScrollable: true,
                          unselectedLabelColor: Colors.black26,
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reviews',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: SizeConfig.blockSizeVertical * 90,
                        minHeight: 56.0),
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 20, 20),
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 20),
                                  child: Text(
                                    'About Trainer',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 20),
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
                                  padding: EdgeInsets.only(
                                      left: 20, top: 20, right: 20),
                                  child: Text(
                                    'Certifications & Specifications',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 20),
                                  child: Text(
                                    'Personal Trainer REPS Level 2, Stability Ball, Kettle Bell, TRX Suspension training Level 1.',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontStyle: FontStyle.italic),
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
                                  padding: EdgeInsets.only(
                                      left: 20, top: 20, right: 20),
                                  child: Text(
                                    'Specialities',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 20),
                                  child: Text(
                                    services == null
                                        ? 'Body building. Fitness. Strength and Conditioning. Diet and Nutrition. Supplementation. Contest Prep.'
                                        : services,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Divider(
                                    height: .5,
                                    color: CColor.PRIMARYCOLOR,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text('Related Trainers',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 0),
                                    child: Container(
                                      height: 160,
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
                                                            TrainerDetail()));
                                              },
                                            ),
                                          );
                                        },
                                        itemCount: trainerList.length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    )),
                              ],
                            )),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 200, minHeight: 56.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(20),
                              physics: BouncingScrollPhysics(),
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: reviewList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: CustomReviews(
                                    items: reviewList[index],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              length: 2,
            )
          ],
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
              items.imageUrl,
              width: 35,
              height: 35,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Text(
                    items.title,
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
                Padding(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 10,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15, top: 10),
                ),
                Padding(
                  child: Text(
                    items.text1,
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
}
