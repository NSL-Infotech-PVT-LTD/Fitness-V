import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/TrainerPackage/TrainerDetail.dart';
import 'package:volt/TrainerPackage/all_trainer.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class Cardio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  List trainerList;
  List checkList;

  @override
  void initState() {
    String auth = '';

    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {getList(auth)});
    super.initState();
  }

  void getList(String auth) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        Map<String, String> parms = {
          SEARCH: '',
          LIMIT: '10',
        };
        getTrainersListApi(auth, parms).then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null && response.data.data.length > 0) {
              checkList = response.data.data.toList();

              trainerList = List<RecomendedTrainerClass>.generate(
                  response.data.data.length,
                  (index) => RecomendedTrainerClass(
                      trainerName: response.data.data[index]['full_name'],
                      trainerExperience: response.data.data[index]['expirence'],
                      imgLink: response.data.data[index]['image']));

//              print(trainerExperiencerList[0]['full_name']);
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

  Widget checkImage1() {
    print("mjudhsg==" + checkList.toString());
    if (checkList != null) {
      if (checkList.length > 0) {
        return checkList[0]['image'] == null
            ? Image.asset(
                baseImageAssetsUrl + 'logo_black.png',
                height: 200,
                width: MediaQuery.of(context).size.width * .43,
              )
            : blackPlaceHolder('uploads/trainer-user/', checkList[0]['image'],
                200, MediaQuery.of(context).size.width * .43);
      }
    }
  }

  Widget checkImage2() {
    if (checkList != null) {
      if (checkList.length > 1) {
        return checkList[1]['image'] == null
            ? Image.asset(
                baseImageAssetsUrl + 'place_holder.png',
                height: 200,
                width: MediaQuery.of(context).size.width * .43,
              )
            : blackPlaceHolder('uploads/trainer-user/', checkList[1]['image'],
                200, MediaQuery.of(context).size.width * .43);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return trainerList != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      baseImageAssetsUrl + 'strongman.svg',
                      height: 22,
                      width: 22,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          personal_trainer,
                          style: TextStyle(fontSize: 24),
                        ))
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 57, right: 20),
                child: Text(
                  'We are proud to offer you fully certified, professional instructors, who are experts in many various areas. Our diverse and well rounded staff will be able to cater to your needs, no matter which style of fitness & wellness you require.',
                  style: TextStyle(fontSize: 8, color: Color(0xffc1c1c1)),
                ),
              ),
              Padding(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      baseImageAssetsUrl + 'popular.svg',
                      height: 28,
                      width: 55,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Recommended for you',
                          style: TextStyle(fontSize: 12),
                        ))
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Visibility(
                        visible: checkList != null && checkList.length > 0,
                        child: GestureDetector(
                          onTap: () {
                            if (checkList != null) {
                              if (checkList.length > 0) {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => TrainerDetail(
                                              id: checkList[0]['id'],
                                            )));
                              }
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              checkList != null &&
                                      checkList.length > 0 &&
                                      checkList[0]['image'] != null
                                  ? blackPlaceHolder(
                                      'uploads/trainer-user/',
                                      checkList[0]['image'],
                                      200,
                                      MediaQuery.of(context).size.width * .43)
                                  : Image.asset(
                                      baseImageAssetsUrl + 'logo_black.png',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                    ),
                              Text(
                                checkList != null && checkList.length > 0
                                    ? checkList[0]['full_name']
                                    : 'Farley Willth',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                  checkList != null && checkList.length > 0
                                      ? checkList[0]['expirence'] +
                                          ' years experineced'
                                      : '',
                                  style: TextStyle(
                                      fontSize: 7, color: Color(0xffc1c1c1))),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: checkList != null && checkList.length > 1,
                        child: GestureDetector(
                          onTap: () {
                            if (checkList != null) {
                              if (checkList.length > 0) {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => TrainerDetail(
                                              id: checkList[0]['id'],
                                            )));
                              }
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              checkList != null &&
                                      checkList.length > 1 &&
                                      checkList[1]['image'] != null
                                  ? blackPlaceHolder(
                                      'uploads/trainer-user/',
                                      checkList[1]['image'],
                                      200,
                                      MediaQuery.of(context).size.width * .43)
                                  : Image.asset(
                                      baseImageAssetsUrl + 'logo_black.png',
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                    ),
                              Text(
                                checkList != null && checkList.length > 1
                                    ? checkList[1]['full_name']
                                    : 'Farley Willth',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                  checkList != null && checkList.length > 1
                                      ? checkList[1]['expirence'] +
                                          ' years experineced'
                                      : '',
                                  style: TextStyle(
                                      fontSize: 7, color: Color(0xffc1c1c1))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: myDivider(),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text('People also searched for these Trainers',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
              Visibility(
                visible: trainerList != null && trainerList.length > 2,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      height: 160,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            child: RecomendedTrainer(
                              trainerClass: trainerList[index + 2],
                              callback: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => TrainerDetail(
                                              id: checkList[index + 2]['id'],
                                            )));
                              },
                            ),
                          );
                        },
                        itemCount: trainerList != null && trainerList.length > 2
                            ? trainerList.length - 2
                            : 0,
                        scrollDirection: Axis.horizontal,
                      ),
                    )),
              ),
              Visibility(
                visible: trainerList != null && trainerList.length > 5,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context, SizeRoute(page: AllTrainersView()));
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(button_radius)),
                        child: Center(
                          child: Text(
                            'View All',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          )
        : setNoDataContent();
  }
}

class RecomendedTrainerClass {
  final String imgLink;
  final String trainerName;
  final String trainerExperience;

  const RecomendedTrainerClass(
      {this.imgLink, this.trainerName, this.trainerExperience});
}

class RecomendedTrainer extends StatelessWidget {
  final VoidCallback callback;
  final RecomendedTrainerClass trainerClass;

  const RecomendedTrainer({Key key, @required this.trainerClass, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              trainerClass.imgLink == null
                  ? Image.asset(
                      baseImageAssetsUrl + 'logo_black.png',
                      width: 125,
                      height: 110,
                    )
                  : blackPlaceHolder('uploads/trainer-user/',
                      trainerClass.imgLink, 110.0, 125.0),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 5),
                child: Text(
                  trainerClass.trainerName,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  trainerClass.trainerExperience == null
                      ? 'No expirence'
                      : trainerClass.trainerExperience + " Years",
                  style: TextStyle(fontSize: 7, color: Color(0xffc1c1c1)),
                ),
              ),
            ],
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          elevation: 2,
        ));
  }
}
