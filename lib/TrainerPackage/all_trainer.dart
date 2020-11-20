import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

import 'TrainerDetail.dart';

class AllTrainersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AllTrainersViewState();
}

class AllTrainersViewState extends State<AllTrainersView> {
  int page = 1;
  int totalPage = 1;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();

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
                List tList = new List();
                for (int i = 0; i < response.data.data.length; i++) {
                  tList.add(response.data.data[i]);
                }

                setState(() {
                  isLoading = false;
                  users.addAll(tList);
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
    String auth = '';

    getString(USER_AUTH)
        .then((value) => {auth = value})
        .whenComplete(() => {_getList(auth, page)});

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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trainers",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildList() {
    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        controller: _sc,
        children: List.generate(users.length + 1, (index) {
          if (index == users.length) {
            return buildProgressIndicator(isLoading);
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => TrainerDetail(
                              id: users[index]['id'],
                            )));
              },
              child: Container(
                child: Center(
                    child: Card(
                  child: Column(
                    crossAxisAlignment : CrossAxisAlignment.stretch,
//                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: <Widget>[
                      users[index]['image'] == null
                          ? Image.asset(
                              baseImageAssetsUrl + 'logo_black.png',
                              width: SizeConfig.screenWidth / 2,
                              height: SizeConfig.screenWidth / 2.65,
                            )
                          : FadeInImage.assetNetwork(
                              placeholder:
                                  baseImageAssetsUrl + 'logo_black.png',
                              image: BASE_URL +
                                  'uploads/trainer-user/' +
                                  users[index]['image'],
                              fit: BoxFit.scaleDown,
                              width: double.maxFinite,
                              height: SizeConfig.screenWidth / 2.65,
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          (users[index]['full_name']),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          users[index]['expirence'] == null
                              ? 'No experience'
                              : ("${users[index]['expirence']} years of experience"),
                          style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc1c1c1)),
                        ),
                      ),
                    ],
                  ),
//            semanticContainer: true,
//            clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  elevation: 2,
                )),
              ),
            );
          }
        })

//        ListView.builder(
//          itemCount: users.length + 1, // Add one more item for progress indicator
//          padding: EdgeInsets.symmetric(vertical: 8.0),
//          itemBuilder: (BuildContext context, int index) {
//            if (index == users.length) {
//              return buildProgressIndicator(isLoading);
//            } else {
//              return new ListTile(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (context) => TrainerDetail(
//                            id: users[index]['id'],
//                          )));
//                },
//                ``leading``: users[index]['image'] == null
//                    ? CircleAvatar(
//                    radius: 30.0,
//                    child: Image.asset(
//                      baseImageAssetsUrl + 'logo_black.png',
//                    ))
//                    : CircleAvatar(
//                  radius: 30.0,
//                  backgroundImage: NetworkImage(
//                    BASE_URL + trainerUser + users[index]['image'],
//                  ),
//                ),
//                title: Text((users[index]['full_name'])),
//                subtitle: Text(("${users[index]['expirence']} years expirenced")),
//              );
//            }
//          },
//          controller: _sc,
//        ),
        );
  }
}
