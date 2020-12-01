import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volt/Methods/Pref.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';

class Home2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState2();
}

class HomeState2 extends State<Home2> {
  String _planImage;
  String _rolePlan = "";
  String _planName = "";
  String _roleCategory = "";

  void initState() {
    getString(roleName)
        .then((value) => {_planName = value})
        .whenComplete(() => setState(() {}));

    getString(userPlanImage)
        .then((value) => {_planImage = value})
        .whenComplete(() => setState(() {}));

    getString(rolePlan)
        .then((value) => {_rolePlan = value})
        .whenComplete(() => setState(() {}));

    getString(roleCategory)
        .then((value) => {_roleCategory = value})
        .whenComplete(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Row(
          
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 27,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3.5) ,
                    height: SizeConfig.blockSizeVertical * 21.1,
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage(baseImageAssetsUrl + 'dummy.png',),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3.5) ,
                    height: SizeConfig.blockSizeVertical * 21.1,
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/gredient.png',),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SvgPicture.asset(
                      baseImageAssetsUrl + 'active.svg',
                    ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3.5),  
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 6,      
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      color: Color(0xff2C2C2C),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      )
                    ),
                    child: Text('Register', style: TextStyle(color: Colors.white),),
                  ))
                ],
              ),
            ),
             Container(
              height: SizeConfig.blockSizeVertical * 27,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2.5,left: SizeConfig.blockSizeHorizontal * 3.5) ,
                    height: SizeConfig.blockSizeVertical * 21.1,
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage(baseImageAssetsUrl + 'dummy.png',),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2.5,left: SizeConfig.blockSizeHorizontal * 3.5) ,
                    height: SizeConfig.blockSizeVertical * 21.1,
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/gredient.png',),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SvgPicture.asset(
                      baseImageAssetsUrl + 'active.svg',
                    ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                    margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2.5,left: SizeConfig.blockSizeHorizontal * 3.5),  
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 6,      
                    width: SizeConfig.blockSizeHorizontal * 45,
                    decoration: BoxDecoration(
                      color: Color(0xff2C2C2C),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      )
                    ),
                    child: Text('Register', style: TextStyle(color: Colors.white),),
                  ))
                ],
              ),
            ),

            ],
        ),
       
        SizedBox(
          height: 10.0,
        ),
        Divider(),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 3),
          child: Row(
            children: [
              SvgPicture.asset(
                baseImageAssetsUrl + 'active.svg',
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.0),
                child: Text('Gym MemberShip'),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.2,
                    horizontal: SizeConfig.blockSizeHorizontal * 0.9),
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 18,
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage(
                              baseImageAssetsUrl + 'dummy.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/gredient.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.blockSizeVertical * 1,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "3 Months",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Active Now",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.2,
                    horizontal: SizeConfig.blockSizeHorizontal * 1),
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 18,
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage(
                              baseImageAssetsUrl + 'dummy.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/gredient.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.blockSizeVertical * 1,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "3 Months",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Active Now",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.2,
                    horizontal: SizeConfig.blockSizeHorizontal * 1),
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 18,
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage(
                              baseImageAssetsUrl + 'dummy.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/gredient.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.blockSizeVertical * 1,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "3 Months",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Active Now",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Divider(),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 3),
          child: Row(
            children: [
              SvgPicture.asset(
                baseImageAssetsUrl + 'active.svg',
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.0),
                child: Text('Gym MemberShip'),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5),
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                image: DecorationImage(
                    image: AssetImage(
                      baseImageAssetsUrl + 'dummy.png',
                    ),
                    fit: BoxFit.cover),
              ),
            )),
      ],
    );
  }
}
