import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/ResponseModel/StatusResponse.dart';
import 'package:volt/TrainerPackage/TrainerDetail.dart';
import 'package:volt/Value/Strings.dart';

class Cardio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  List trainerList;
  var checkList;

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
                      trainerExperience: '6.5 Year Experinece',
                      imgLink: baseImageAssetsUrl + 'dummy2.png'));

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
    return Column(
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
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
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
                    'Recommended for your',
                    style: TextStyle(fontSize: 12),
                  ))
            ],
          ),
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      baseImageAssetsUrl + 'dummy2.png',
                      height: 200,
                      width: MediaQuery.of(context).size.width * .43,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Farley Willth',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('7 years experineced',
                        style:
                            TextStyle(fontSize: 7, color: Color(0xffc1c1c1))),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      baseImageAssetsUrl + 'dummy1.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * .43,
                      height: 200,
                    ),
                    Text(
                      'Neo Jones',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('6.5 years experineced',
                        style:
                            TextStyle(fontSize: 7, color: Color(0xffc1c1c1))),
                  ],
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: myDivider(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 20),
          child: Text('People also searched for these Trainers',
              style: TextStyle(fontSize: 12)),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 160,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: RecomendedTrainer(
                      trainerClass: trainerList[index],
                      callback: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => TrainerDetail(
                                      id: checkList[index]['id'],
                                    )));
                      },
                    ),
                  );
                },
                itemCount: trainerList == null ? 0 : trainerList.length,
                scrollDirection: Axis.horizontal,
              ),
            )),
      ],
    );
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
              Image.asset(
                trainerClass.imgLink,
                fit: BoxFit.cover,
                width: 110,
                height: 110,
              ),
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
                  trainerClass.trainerExperience,
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
