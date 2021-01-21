import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/TrainerPackage/TrainerDetail.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import '../Value/SizeConfig.dart';

class ChoosePersonalTrainer extends StatefulWidget {
  @override
  _ChoosePersonalTrainerState createState() => _ChoosePersonalTrainerState();
}

class _ChoosePersonalTrainerState extends State<ChoosePersonalTrainer> {
  int page = 1;
  int totalPage = 1;
  ScrollController _sc = ScrollController();
  bool isLoading = false;
  List users = List();
  String auth = '';
  int valueHolder = 1;
  int trainerPrice = 250;

  void _getList(String auth, int index) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });

          Map<String, String> parms = {
            SEARCH: '',
            LIMIT: '10',
            PAGE: index.toString()
          };
          getTrainersListApi(auth, parms).then((response) {
            dismissDialog(context);
            if (response.status) {
              if (response.data != null && response.data.data.length > 0) {
                totalPage = response.data.last_page;
                List tList = List();
                for (int i = 0; i < response.data.data.length; i++) {
                  tList.add(response.data.data[i]);
                }
                setState(() {
                  isLoading = false;
                  users.addAll(tList);
                  print("Check Data" + users.toList().toString());
                  page++;
                });
              }
            } else {
              dismissDialog(context);
              if (response.error != null)
                showDialogBox(context, "Error!", response.error);
            }
          });
        }
      } else {
        showDialogBox(context, internetError, pleaseCheckInternet);
        dismissDialog(context);
      }
    });
  }

  @override
  void initState() {
    //var authS = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImE0YWMxMmViZDYyZjQ0OGZkOWM3MTA5MWU1YTU3ZTUzZDk3NTBlMjM3NTkyZDlmMTdjZThjNjk2YjgzYWRkODkwNmI1MjcxMmVhYjMyZGYyIn0.eyJhdWQiOiIxIiwianRpIjoiYTRhYzEyZWJkNjJmNDQ4ZmQ5YzcxMDkxZTVhNTdlNTNkOTc1MGUyMzc1OTJkOWYxN2NlOGM2OTZiODNhZGQ4OTA2YjUyNzEyZWFiMzJkZjIiLCJpYXQiOjE2MDg1NDY5NDIsIm5iZiI6MTYwODU0Njk0MiwiZXhwIjoxNjQwMDgyOTQyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.PetjuS4uxwzdHxGh08slP-xo32DouLvjhC9a7yWu77hjOndT00wwhMhmbJoN7Co5PgbbNR5HdOd0XWbus8cBB02i6Ks7FHgsSkLqouKzM7EB_KiYQOKlicbAlvYv6UOaNJDRjmqwsHRaZRNRetuCr0k1fbLhdU6GUDx_IFM_u6B-xzMP3KX9sh4Qgkhxbl1LB0TEEDkdfelLZkHoMK2XWr6XaQAkaD2VajGDc3aGHiybzFv3Y1boW_yZu81CEdSCQp37uewEK9FSpCoUZLrdmoFlSI1ewX6n5fiEEty79a9I4PvKv92T7Pcog0L44ENcXPRDbZSYunmSF8h79ReOsELUwsS2bTBY_ii2GfYeSJLAJmur8Ho1tyMHzFBk6TUmoILKhMZk9F4mogr9-WA5G4In4cRF_RCzA-0Mir-igRJAUFkQxh810538Y6qMGi2Eg7By_q4dKA9ao-0gz7pqs2V-LUn5IKZd7objQD3oelDIirTemKGqCpbbUY249RZemIYQGYc-i0cqFokzZ4PAas7V8FFi261m2GheXRweDGrLFjJaaWXgNnG2N6ihuaslfMIOnRmBnVDohRfOkpoyCxB4B3w82fegEbU0DRHEh1JUTWEoSS_bMCxEoKNbQe6XcJYZEwtNa2MV__eHY9fF93JqhMc7XSVgUyBnVy8k0xE";
    String auth = '';
    _getList(auth, page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        if (page <= totalPage) _getList(auth, page);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    page = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _currVal = 1;

    var _character = "0";
    SizeConfig().init(context);
    var mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: mediaHeight * 0.08,
          backgroundColor: Colors.white,
          titleSpacing: -10,
          leading: InkWell(onTap: (){Navigator.pop(context);  },child: Icon(Icons.arrow_back_ios_sharp)),
          title: InkWell(
            child: Text("Back"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 15.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "SKIP",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/strongman.svg"),
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Choose your Personal Trainer",
                          style: TextStyle(
                              fontFamily: "fonts/regular.ttf", fontSize: 22),
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: Text(
                              "We are proud to offer you fully certified, professional instructors, who are experts in many ways to help you feel your best.",
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              isLoading
                  ? Padding(
                padding: EdgeInsets.only(top: mediaHeight * 0.20),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              )
                  :

              ListView.builder(
                  itemExtent: 130.0,
                  itemCount: users.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, i) {
                    return
                      Padding(padding:EdgeInsets.only(bottom:12),child: ListTile(
                          tileColor: Colors.grey.shade200,
                          leading: users[i]['image'] == null ? Image.asset(baseImageAssetsUrl + 'logo_black.png') :
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 100,
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: baseImageAssetsUrl + 'logo_black.png',
                              image: BASE_URL +
                                  'uploads/trainer-user/' + users[i]['image'],
                              height: 200,
                                fit: BoxFit.contain,
                            ),
                          ),

                          trailing: Align(
                            widthFactor: 1.0,// for width between trailing and leading
                            child: _myRadioButton(
                              title: "",
                              value: i,
                              onChanged: (newValue) => setState(() {
                                myBottom(i);
                                setState(() {
                                  _groupValue = newValue;
                                });

                              }),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(users[i]["first_name"],style: TextStyle(fontSize: 15),),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),

                              // InkWell(
                              //    child: Text(
                              //      "View Profile",
                              //      style: TextStyle(
                              //          color: Colors.white,
                              //          fontWeight: FontWeight.bold),
                              //    ),
                              //    onTap: () => Navigator.push(
                              //      context,
                              //      MaterialPageRoute(
                              //          builder: (context) => TrainerDetail(
                              //              fromForm: true,
                              //              id: users[i]["id"])),
                              //    ),
                              //  ),
                            ],
                          ),
                          // trailing: Radio(
                          //   value: users[i]["id"],
                          //   groupValue: _character,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _character = value;
                          //     });
                          //   },
                          // ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(users[i]["expirence"] + " years of experience",style: TextStyle(fontSize: 13),),
                              Text("${users[i]["booking_cnt"]} Trainees (${users[i]["booking_reviewed_cnt"]}" + " Reviews)"),
                              Padding(
                                padding: const EdgeInsets.only(top:6.0),
                                child: Container(

                                  width: MediaQuery.of(context).size.width *
                                      0.27,
                                  height: MediaQuery.of(context).size.height *
                                      0.03,

                                  child:  RaisedButton(
                                    color: Colors.grey.shade500
                                    ,onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TrainerDetail(
                                              fromForm: true,
                                              id: users[i]["id"])),
                                    );
                                  }, shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(07.0),
                                    // side: BorderSide(color: Colors.grey)
                                  ),
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            myBottom(i);
                          }
                        //   trailing: Icon(Icons.more_vert),
                      ));

                  }),
            ],
          ),
        ),),

        );
  }

  myBottom(index) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState
                /*You can rename this!*/) {
          return Container(
            height: 400,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Text("Back"),
                      ],
                    ),
                  ),
                  const Text('Choose Your Personal Trainer'),
                  const Text('Session (in Hours)',
                      style: TextStyle(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25, top: 0, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        new RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: "Session",
                                style: TextStyle(
                                    fontSize: textSize12, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "\n(In hour)",
                                      style: TextStyle(
                                          fontSize: textSize8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45))
                                ])),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 50),
                              width: SizeConfig.screenWidth * .68,
                              child: Slider(
                                  value: valueHolder.toDouble() == 0
                                      ? 1
                                      : valueHolder.toDouble(),
                                  min: 1,
                                  max: 24,
                                  divisions: 4,
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                 label: '${valueHolder.round() == 0 ? 1 : valueHolder}',
                                  onChanged: (double newValue) {
                                    setState(() {
                                      print("cehckcehckcehck " + newValue.toString());
                                      valueHolder = newValue.round();
                                      if(valueHolder == 7){
                                        valueHolder = 6;
                                      } else if(valueHolder == 13){
                                        valueHolder = 12;
                                      }else if(valueHolder == 18){
                                        valueHolder = 24;
                                      }
                                      print("cehckcehckcehck " + valueHolder.toString());
                                      trainerPrice = sendValue();
                                    });
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()}';
                                  }),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: SizeConfig.screenWidth * .68,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: SizeConfig.screenWidth * .17,
                                    child: Text(
                                      '1',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * .17,
                                    child: Text(
                                      '6',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * .17,
                                    child: Text(
                                      '12',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Visibility(
                                    visible: /* widget.isGroupClass */ true,
                                    child: Container(
                                      width: SizeConfig.screenWidth * .17,
                                      child: Text(
                                        '24',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  new RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: "Price",
                                          style: TextStyle(
                                              fontSize: textSize12,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "",
                                                style: TextStyle(
                                                    fontSize: textSize8,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45))
                                          ])),
                                  // SizedBox(
                                  //   width: SizeConfig.screenWidth * 0.2,
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    width: SizeConfig.screenWidth * 0.50,
                                    height: button_height,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(button_radius))),
                                    child: Center(
                                        child: Text(
                                      '${sendValue()} $aed',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 10),
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '/ Hour',
                                        style: TextStyle(color: Colors.grey),
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                            Radius.circular(button_radius))),
                    margin: EdgeInsets.only(top: padding25,left: 30,right:30 ),
                    height: button_height,
                    width: SizeConfig.screenWidth,
                    // width: 100,
                    child: RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(
                            context, [users[index], valueHolder, trainerPrice]);
                        //  print("${widget.id}  ${valueHolder}");
                      },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(button_radius)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Text('Done',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
           //   color: Colors.black,

              ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  int sendValue() {
    int value = 0;
    if (valueHolder == 1) {
      value = 250;
    } else if (valueHolder == 6) {
      value = 1400;
    } else if (valueHolder == 12) {
      value = 2600;
    } else if (valueHolder == 24) {
      value = 5000;
    }
    print('$valueHolder =====> $value');

    return value;
  }

  int _groupValue = -1;

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return Radio(
      activeColor: Colors.black,
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
    );
  }
}
