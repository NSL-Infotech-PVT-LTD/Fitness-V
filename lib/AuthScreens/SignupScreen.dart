import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:volt/Firebase/FirebaseNotification.dart';
import 'package:volt/MemberDashboard/Dashboard.dart';
import 'package:volt/Methods/Method.dart';
import 'package:volt/Methods/api_interface.dart';
import 'package:volt/Screens/Choose_Personal_Trainer.dart';
import 'package:volt/Screens/SplashScreenWithLady.dart';
import 'package:volt/Value/CColor.dart';
import 'package:volt/Value/Dimens.dart';
import 'package:volt/Value/SizeConfig.dart';
import 'package:volt/Value/Strings.dart';
import 'package:volt/util/number_format.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:volt/Methods/Pref.dart';
import '../Methods.dart';
import '../Methods/api_interface.dart';
import '../Value/Strings.dart';
import '../lifecycycle.dart';
import 'SuccessScreen.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  final gymMemberType;
  final List response;
  final String type;
  final int planIndex;
  final String formType;
  final bool isSingle;
  final bool isEmailError;
  final bool isCityTrue;
  final int memberIndex;
  final Map<String, String> editData;
  final String roleId;
  final String rolePlanId;
  final String planPrice;
  var profileImage;

  static MyInheritedData of(BuildContext context) =>
      context. dependOnInheritedWidgetOfExactType<MyInheritedData>() as MyInheritedData;


  SignupScreen({this.response,
    this.planIndex,
    this.type,
    this.formType,
    this.memberIndex,
    this.editData,
    this.isCityTrue,
    this.isEmailError,
    this.isSingle,
    this.roleId,
    this.rolePlanId,
    this.profileImage,
    this.planPrice,
    this.gymMemberType});

  @override
  State<StatefulWidget> createState() => SignupState();

}

class SignupState extends State<SignupScreen> {


  String baseImageUrl = 'assets/images/';
  String radioItem = "";
  String radioItemMarital = '';
  bool acceptTerms = false;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  File file;

  /// @AuthScreens Controllers
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middletNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emergencyController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var dobController = TextEditingController();
  var designationController = TextEditingController();
  var workPlaceController = TextEditingController();
  var nationalityController = TextEditingController();

  var aboutUsController = TextEditingController();
  var emiratesController = TextEditingController();
  var addressController = TextEditingController();
  var hotelController = TextEditingController();
  var durationController = TextEditingController();
  List<String> _cities = [];
  String selectedCity;
  var selectedTrainer;

  bool _isIos;
  String deviceType = '';
  String roleId;


  var fromDate;
  var checkInViewdate;
  var checkOutViewdate;
  var checkInDate;
  var checkOutDate;
  DateTime initCheckIn = DateTime.now();
  var myDate, sendDate;
  var formatter = new DateFormat("dd/MM/yyyy");
  var sendDateFormat = new DateFormat("yyyy-MM-dd");
  final picker = ImagePicker();
  bool imageLoader = false;

  Map<String, String> parms;

  void fromDatePicker() {
    getData();
  }

  void checkOutFun() {
    checkOut();
  }

  void checkInFun() {
    checkIN();
  }

  String rolePlanId;

  String myField;

  void onMyFieldChange(String newValue) {
    setState(() {
      myField = newValue;
    });
  }

  Future<DateTime> checkIN() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(actions: <Widget>[
            CupertinoActionSheetAction(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.black87),
                    ),
                  )),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (myDate != null) {
                    checkInDate = sendDateFormat.format(myDate);
                    checkInViewdate = formatter.format(myDate);

                    //    print("check In + check out " + checkInDate + checkOutDate);
                  }
                });
              },
            ),
            Container(
              height: 300.0,
              color: Colors.white,
              child: CupertinoDatePicker(
                use24hFormat: true,
                //  maximumDate: new DateTime(2019, 12, 30),
                minimumDate: DateTime.now(),
                minimumYear: DateTime.now().year,
                //maximumYear: DateTime.now().year,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                backgroundColor: Colors.white,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    myDate = dateTime;
                    initCheckIn = dateTime;
                  });

                  // print("$myDate");
//                setState(() {
//                  if (dateTime != null) fromDate = formatter.format(dateTime);
//                });
                },
              ),
            ),
          ]);
        });

//    return showDatePicker(
//        context: context,
//        initialDate: DateTime(2019),
//        firstDate: DateTime(1980),
//        lastDate: DateTime(2020),
//        builder: (BuildContext context, Widget child) {
//          return Theme(
//            data: ThemeData.fallback(),
//            child: child,
//          );
//        });
  }

  Future<DateTime> checkOut() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(actions: <Widget>[
            CupertinoActionSheetAction(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.black87),
                    ),
                  )),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (myDate != null) {
                    checkOutDate = sendDateFormat.format(myDate);
                    checkOutViewdate = formatter.format(myDate);
                    //    print("check In + check out " + checkInDate + checkOutDate);
                  }
                });
              },
            ),
            Container(
              height: 300.0,
              color: Colors.white,
              child: CupertinoDatePicker(
                use24hFormat: true,
                minimumDate: initCheckIn != null
                    ? initCheckIn.add(Duration(days: 1))
                    : DateTime.now(),

                //    maximumDate: new DateTime(2019, 12, 30),
                minimumYear: initCheckIn.year != null
                    ? initCheckIn.year
                    : DateTime
                    .now()
                    .year,
                //   maximumYear:DateTime.now().year,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initCheckIn != null
                    ? initCheckIn.add(Duration(days: 1))
                    : DateTime.now(),
                backgroundColor: Colors.white,
                onDateTimeChanged: (dateTime) {
                  myDate = dateTime;
                  // print("$myDate");
//                setState(() {
//                  if (dateTime != null) fromDate = formatter.format(dateTime);
//                });
                },
              ),
            ),
          ]);
        });

//    return showDatePicker(
//        context: context,
//        initialDate: DateTime(2019),
//        firstDate: DateTime(1980),
//        lastDate: DateTime(2020),
//        builder: (BuildContext context, Widget child) {
//          return Theme(
//            data: ThemeData.fallback(),
//            child: child,
//          );
//        });
  }

  Future<DateTime> getData() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(actions: <Widget>[
            CupertinoActionSheetAction(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.black87),
                    ),
                  )),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (myDate != null) {
                    fromDate = formatter.format(myDate);
                    sendDate = sendDateFormat.format(myDate);
                    //    print("check In + check out " + checkInDate.toString() + checkOutDate);
                  }
                });
              },
            ),
            Container(
              height: 300.0,
              color: Colors.white,
              child: CupertinoDatePicker(
                use24hFormat: true,
                maximumDate: new DateTime(2019, 12, 30),
                minimumYear: 1920,
                maximumYear: 2019,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2018),
                backgroundColor: Colors.white,
                onDateTimeChanged: (dateTime) {
                  myDate = dateTime;
                  // print("$myDate");
//                setState(() {
//                  if (dateTime != null) fromDate = formatter.format(dateTime);
//                });
                },
              ),
            ),
          ]);
        });

//    return showDatePicker(
//        context: context,
//        initialDate: DateTime(2019),
//        firstDate: DateTime(1980),
//        lastDate: DateTime(2020),
//        builder: (BuildContext context, Widget child) {
//          return Theme(
//            data: ThemeData.fallback(),
//            child: child,
//          );
//        });
  }

  bool passwordVisible = true;

  @override
  void initState() {
    FirebaseIn.initNoti(context);
//     _cities = [
//       'Dubai',
//       'Sharjah',
//       'Abu Dhabi',
//       'Ajman',
//       'Ras al-khaimah',
// //    'Musaffah City',
//       'Fujairah City',
// //    'Khalifah A City',
// //    'Reef AI Fujairah City',
// //    'Bani Yas City',
// //    'Zayed City',
//       'Umm al-Quwain',
//     ];

    List<String> _cities = [
      'Abu Dhabi',
      'Dubai',
      'Ajman',
      'Fujairah',
      'Ras al Khaimah ',
      'Sharjah',
      'Umm al Quwain',
    ];


    _cities.sort((a,b){
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    print("profile image " + widget.profileImage.toString());
    passwordVisible = true;
    if (widget.type != null) print("form type " + widget.type);
    rolePlanId = widget.rolePlanId;
    roleId = widget.roleId;
    print("panId " + rolePlanId.toString());
    print("roleId " + roleId.toString());
    print("check index " + widget.editData.toString());
    _isIos = Platform.isIOS;
    deviceType = _isIos ? 'ios' : 'android';

    if (widget.editData != null) {
      print('mydata ${widget.editData}');
      // if (widget.editData.containsKey(FIRSTNAME + "_1")) {
      //   _setData("_1");
      // } else if (widget.editData.containsKey(FIRSTNAME + "_2")) {
      //   _setData("_2");
      // } else if (widget.editData.containsKey(FIRSTNAME + "_3")) {
      //   _setData("_3");
      // } else {
      //   _setData("");
      // }
      _setData(widget.memberIndex.toString());
    }
    // getString(fireDeviceToken).then((value) {
    //   deviceTok = value;
    // });
    super.initState();
  }

//  @override
//  void dispose(){
//    firstNameController.dispose();
//    middletNameController.dispose();
//    lastNameController.dispose();
//    mobileController.dispose();
//    emergencyController.dispose();
//    emailController.dispose();
//    passwordController.dispose();
//    designationController.dispose();
//    emiratesController.dispose();
//    addressController.dispose();
//    super.dispose();
//  }
//
  _setData(String ind) {
    print("kjhrfikrhf ${widget.editData}  $ind");

    if (ind == '0') {
      result = [];
      file = widget.profileImage;
      firstNameController.text = widget.editData[FIRSTNAME];
      radioItem = widget.editData[CHILD];
      fromDate = widget.editData[BIRTH_DATE];
      sendDate = widget.editData[BIRTH_DATE];
      middletNameController.text = widget.editData[MIDDLENAME];
      lastNameController.text = widget.editData[LASTNAME];
      mobileController.text = widget.editData[MOBILE];
      emergencyController.text = widget.editData[EMEREGENCY_NUMBER];
      emailController.text = widget.editData[EMAIL];
      passwordController.text = widget.editData[PASSWORD];
      // fromDate = widget.editData[BIRTH_DATE];
      designationController.text = widget.editData[DESIGNATION];
      aboutUsController.text = widget.editData[about_us];
      nationalityController.text = widget.editData[nationality];
      workPlaceController.text = widget.editData[workplace];
      radioItemMarital = widget.editData[marital_status];
      emiratesController.text = widget.editData[EMIRATES_ID];
      addressController.text = widget.editData[ADDRESS];
      selectedCity = widget.editData[CITY];
      selectedTrainer = widget.editData[trainerIds];

      nameTrainer = widget.editData[tName];
      yearsExpTrainer = widget.editData[tExp];
      traineesBookedTrainer = widget.editData[tTrainess];
      reviewTrainer = widget.editData[tReview];
      priceTrainer = widget.editData[tPrice];
      imageTrainer = widget.editData[timage];
      sessionSlotTrainer = widget.editData[trainer_slot];
      idTrainer = widget.editData[trainer_id];

      // result =jsonDecode(widget.editData[trainerData+ '_' + ind]);

      // durationController.text = widget.editData[durationOfStay];
      // hotelController.text = widget.editData[hotelNo];
      // selectedTrainer = widget.editData[trainerIds + '_' + ind];
      print("price " + priceTrainer.toString());
    } else {
      result = [];
      firstNameController.text = widget.editData[FIRSTNAME + '_' + ind];
      radioItem = widget.editData[CHILD + '_' + ind];
      fromDate = widget.editData[BIRTH_DATE + '_' + ind];
      sendDate = widget.editData[BIRTH_DATE + '_' + ind];
      middletNameController.text = widget.editData[MIDDLENAME + '_' + ind];
      lastNameController.text = widget.editData[LASTNAME + '_' + ind];
      mobileController.text = widget.editData[MOBILE + '_' + ind];
      emergencyController.text = widget.editData[EMEREGENCY_NUMBER + '_' + ind];
      emailController.text = widget.editData[EMAIL + '_' + ind];
      passwordController.text = widget.editData[PASSWORD + '_' + ind];
      // fromDate = widget.editData[BIRTH_DATE + "_$ind"];
      designationController.text = widget.editData[DESIGNATION + '_' + ind];
      emiratesController.text = widget.editData[EMIRATES_ID + '_' + ind];
      addressController.text = widget.editData[ADDRESS + '_' + ind];
      selectedCity = widget.editData[CITY + '_' + ind];
      selectedTrainer = widget.editData[trainerIds + '_' + ind];
      if (trainerData != "trainerData")
        jsonDecode(widget.editData[trainerData + '_' + ind]);
      nameTrainer = widget.editData[tName + '_' + ind];
      yearsExpTrainer = widget.editData[tExp + '_' + ind];
      traineesBookedTrainer = widget.editData[tTrainess + '_' + ind];
      reviewTrainer = widget.editData[tReview + '_' + ind];
      priceTrainer = widget.editData[tPrice + '_' + ind];
      imageTrainer = widget.editData[timage + '_' + ind];
      sessionSlotTrainer = widget.editData[trainer_slot + '_' + ind];
      idTrainer = widget.editData[trainer_id + '_' + ind];
      print("price " + priceTrainer.toString());
      print("price " + tPrice + '_' + ind.toString());
      //result =jsonDecode(widget.editData[trainerData+ '_' + ind]) as List;

      // durationController.text = widget.editData[durationOfStay];
      // hotelController.text = widget.editData[hotelNo];
    }
  }

  @override
  Widget build(BuildContext context) {
    //[{id: 1, fee: 250, fee_type: Monthly, role_id: 1, role_plan: Monthly: AED 250},
    // {id: 2, fee: 1700, fee_type: Quarterly, role_id: 1, role_plan: Quarterly: AED 1700},
    // {id: 3, fee: 3200, fee_type: Half yearly, role_id: 1, role_plan: Half yearly: AED 3200},
    // {id: 4, fee: 6000, fee_type: Yearly, role_id: 1, role_plan: Yearly: AED 6000}]

    // [{id: 25, fee: 400, fee_type: Monthly, role_id: 7, role_plan: Monthly: AED 400},
    // {id: 26, fee: 700, fee_type: Quarterly, role_id: 7, role_plan: Quarterly: AED 700},
    // {id: 27, fee: 1300, fee_type: Half yearly, role_id: 7, role_plan: Half yearly: AED 1300},
    // {id: 28, fee: 1900, fee_type: Yearly, role_id: 7, role_plan: Yearly: AED 1900}]
    if (widget.type != null) {
      //  roleId = widget.response[0]['id'].toString();
      if (widget.type != 'guest') {
        List plans = widget.response;
        if (plans.length > 0) {
          //  rolePlanId = plans[widget.planIndex]['id'].toString();
          //   rolePlanId = widget.rolePlanId;
          //   roleId = widget.roleId;
          //roleId = widget.response[widget.planIndex]['role_id'].toString();
        }
      }
    }
    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('Are you sure to exit?'),
          content: new Text(
              'kindly save your  details  otherwise some data will be vanished'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.pop(context),
              child: new Text('Cancel'),
            ),
            new FlatButton(
              onPressed: () {
                parms = {};
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
              child: new Text(
                'Confirm',
                style: TextStyle(
                    color: CColor.CancelBTN, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )) ??
          false;
    }

    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () {
          _onWillPop();
          //Navigator.p
          // op(context, widget.editData);
          return new Future(() => false);
        },
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: CColor.WHITE,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 300.0,
                    floating: false,
                    backgroundColor: Colors.black,
                    pinned: true,
                    iconTheme: IconThemeData(color: Colors.white),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 400,
                        width: SizeConfig.screenWidth,
                        color: Colors.black,
                        child: Stack(
                          children: <Widget>[
                        // Positioned(
                        //     left: 0,
                        //     right: 0,
                        //     top: padding50,
                        //     child: Image.asset(
                        //       baseImageUrl + 'exc_sign.png',
                        //       height: 111,
                        //     )),
                        Positioned(
                        // left: 50,
                        // bottom: padding50 + padding30,
                        child: Image.asset(
                          'assets/images/voltLogoBanner.png',
                          width: SizeConfig.screenWidth,
                          height: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black26,
                        ),
                      ),

                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 260,

                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left:0,
                        right:0,
                        bottom: padding30,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 15.0),
                          child: Row(
                              children: [
                          Image.asset(baseImageUrl + 'user_sign.png'),
                          SizedBox(
                              width: SizeConfig.screenWidth * 0.02),
                          Text(
                            "Register",
                            style: TextStyle(
                                color: CColor.WHITE,
                                fontSize: textSize20),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Visibility(
                              visible: widget.isSingle && widget.type != 'fairMont' && widget.type != 'guest',
                              child: Text(
                                  "AED ${planPrice != null? planPrice.toString():widget.planPrice}",
                              style: TextStyle(
                              color: CColor.WHITE,
                                  fontSize: textSize14),
                            ),
                        ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   //top: ,
                  //   left: 90,
                  //   right: 60,
                  //   bottom: 20,
                  //   child: Padding(
                  //     child: Text(
                  //       'Please give us your details to enjoy our premium experience',
                  //       style: TextStyle(
                  //           color: CColor.WHITE,
                  //           fontSize: textSize12),
                  //     ),
                  //     padding: EdgeInsets.fromLTRB(5, 10, 20, 0),
                  //   ),
                  // ),
                ],
                ),
                ),
                ),
                ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          padding50, padding30, padding50, padding30),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Enter your personal details below: ',
                              style: TextStyle(
                                  color: Color(0xFF707070), fontSize: 15),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter(
                                    RegExp("[a-zA-Z]"))
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fieldIsRequired;
                                }
                                return null;
                              },
                              controller: firstNameController,
                              decoration: InputDecoration(
                                  hintText: firstname + '*',
                                  hintStyle: TextStyle(fontSize: textSize12)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter(
                                    RegExp("[a-zA-Z]"))
                              ],
                              controller: middletNameController,
                              decoration: InputDecoration(
                                  hintText: midlename,
                                  hintStyle: TextStyle(fontSize: textSize12)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                //WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"))
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fieldIsRequired;
                                }
                                return null;
                              },
                              controller: lastNameController,
                              decoration: InputDecoration(
                                  hintText: lastname + '*',
                                  hintStyle: TextStyle(fontSize: textSize12)),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              radiobutton('Male'),
                              radiobutton('Female'),
                            ],
                          ),
                          Visibility(
                            visible: true,//widget.type != 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  // ignore: deprecated_member_use
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  CardNumberInputFormatter()
                                ],
                                maxLength: 15,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  } else if (value.length < 9) {
                                    return 'Please Enter Valid Number';
                                  }
                                  return null;
                                },
                                controller: mobileController,
                                decoration: InputDecoration(
                                    hintText: mobile,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: (widget.memberIndex == 0 ||
                                  widget.memberIndex == null) &&
                                  widget.type != 'guest' &&
                                  widget.type != 'fairMont',
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  // ignore: deprecated_member_use
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  CardNumberInputFormatter()
                                ],
                                maxLength: 15,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  } else if (value.length < 9) {
                                    return 'Please enter valid number';
                                  }
                                  return null;
                                },
                                controller: emergencyController,
                                decoration: InputDecoration(
                                    hintText: emergencyContact,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              )),
                          TextFormField(
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return fieldIsRequired;
                              } else if (!validateEmail(value)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: email + '*',
                                hintStyle: TextStyle(fontSize: textSize12)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fieldIsRequired;
                                } else if (value.length < 5) {
                                  return 'Password must be more than 6 words';
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          // Based on passwordVisible state choose the icon
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: CColor.DividerCOlor,
                                        )),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: password + '*',
                                  hintStyle: TextStyle(fontSize: textSize12)),
                            ),
                          ),

                          Container(
                            margin:
                            EdgeInsets.only(top: margin20, bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(button_radius)),
                                border: Border.all(
                                    color: Colors.black26, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      fromDate == null
                                          ? birthDate
                                          : fromDate.toString(),
                                      style: TextStyle(
                                          fontSize: textSize12,
                                          color: fromDate == null
                                              ? Colors.black45
                                              : Colors.black),
                                    )),
                                Spacer(),
                                GestureDetector(
                                  onTap: fromDatePicker,
                                  child: Container(
                                    height: 50,
                                    width: 40,
                                    color: Color(0xFFDFDFDF),
                                    child: Image(
                                      image: AssetImage(
                                          baseImageUrl + 'calendar.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 ||
                                widget.memberIndex == null) &&
                                widget.type != 'guest' &&
                                widget.type != 'fairMont',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                radioMerital(single),
                                radioMerital(married),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 || widget.memberIndex == null) && widget.type != 'guest' && widget.type != 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: designationController,
                                decoration: InputDecoration(
                                    hintText: designation,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.type == 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: hotelController,
                                decoration: InputDecoration(
                                    hintText: "Hotel Room Number",
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.type == 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: durationController,
                                decoration: InputDecoration(
                                    hintText: "Duration of Stay",
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 ||
                                widget.memberIndex == null) &&
                                widget.type != 'guest' &&
                                widget.type != 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: aboutUsController,
                                decoration: InputDecoration(
                                    hintText: "How did you hear about us?",
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 || widget.memberIndex == null) && !(widget.type == "guest"),
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: nationalityController,
                                decoration: InputDecoration(
                                    hintText: "Nationality",
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 || widget.memberIndex == null) && !(widget.type == "guest"),
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: workPlaceController,
                                decoration: InputDecoration(
                                    hintText: "Work place",
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 || widget.memberIndex == null) &&
                                widget.type != 'guest',
                            child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: emiratesController,
                                decoration: InputDecoration(
                                    hintText: emiratesId,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.type == 'fairMont',
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                child: Text(
                                  "Check In",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.type == 'fairMont',
                            child: Container(
                              margin: EdgeInsets.only(top: margin15, bottom: 6),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(button_radius)),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        checkInDate == null
                                            ? checkIn
                                            : checkInViewdate.toString(),
                                        style: TextStyle(
                                            fontSize: textSize12,
                                            color: checkInDate == null
                                                ? Colors.black45
                                                : Colors.black),
                                      )),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: checkInFun,
                                    child: Container(
                                      height: 50,
                                      width: 40,
                                      color: Color(0xFFDFDFDF),
                                      child: Image(
                                        image: AssetImage(
                                            baseImageUrl + 'calendar.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01),
                          Visibility(
                              visible: widget.type == 'fairMont',
                              child: Align(
                                child: Text(
                                  "Check Out",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                ),
                                alignment: Alignment.centerLeft,
                              )),
                          Visibility(
                            visible: widget.type == 'fairMont',
                            child: Container(
                              margin: EdgeInsets.only(top: margin15, bottom: 6),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(button_radius)),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        checkOutViewdate == null
                                            ? checkOutt
                                            : checkOutViewdate.toString(),
                                        style: TextStyle(
                                            fontSize: textSize12,
                                            color: checkOutViewdate == null
                                                ? Colors.black45
                                                : Colors.black),
                                      )),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: checkOutFun,
                                    child: Container(
                                      height: 50,
                                      width: 40,
                                      color: Color(0xFFDFDFDF),
                                      child: Image(
                                        image: AssetImage(
                                            baseImageUrl + 'calendar.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 ||
                                widget.memberIndex == null) &&
                                widget.type != 'guest' &&
                                widget.type != 'fairMont',
                            child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fieldIsRequired;
                                  }
                                  return null;
                                },
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: address,
                                    hintStyle: TextStyle(fontSize: textSize12)),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: !(widget.type == "guest") && !(widget.type == "fairMont"),
                            child: Padding(
                                padding: EdgeInsets.only(top: 18),
                                child: DropdownButton(
                                  hint: selectedCity == null
                                      ? Text('Select Emirates')
                                      : Text(
                                    selectedCity,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(fontSize: 12),
                                  items: _cities.map(
                                        (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(
                                          val,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                          () {

                                        selectedCity = val;
                                        print(selectedCity);
                                      },
                                    );
                                  },
                                )),
                          ),
                          SizedBox(
                            height:
                            MediaQuery //widget.type != 'fairMont' && widget.type != 'guest'
                                .of(context)
                                .size
                                .height *
                                0.02,
                          ),
                          Visibility(
                            visible: (widget.memberIndex == 0 ||
                                widget.memberIndex == null) &&
                                widget.type != 'fairMont' &&
                                widget.type != 'guest',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.06,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: file == null
                                        ? Text('Choose A Profile Photo')
                                        : Text("Photo Selected"),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.07,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.06,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.14,
                                  child: RaisedButton.icon(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    color: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    onPressed: () {
                                      _showMyDialog();
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            color: Colors.white,
                                            size: 35,
                                          )),
                                    ),
                                    label: Text(""),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: widget.type != 'fairMont' &&
                                widget.type != 'guest',
                            child: Column(
                              children: [
                                SizedBox(height: 35),
                                Divider(),
                                Align(
                                  child: Text(
                                    "Choose Trainer (Optional)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 12),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(height: 12),
                                Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.06,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text("Choose Trainer"),
                                        Spacer(),
                                        InkWell(
                                          onTap: () =>
                                              _navigateAndDisplaySelection(
                                                  context),
                                          child: result != null &&
                                              result.length > 0
                                              ? Text(
                                            "Change my trainer",
                                            style: TextStyle(
                                                color: Colors.indigo),
                                          )
                                              : Container(
                                            height: 28,
                                            child: Center(
                                                child: Icon(
                                                  Icons.navigate_next,
                                                  color: Colors.white,
                                                )),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        5)),
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Divider(),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: result != null && nameTrainer != "",
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Card(
                                color: Color(0xffF8F8F8),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            result != null
                                                ? nameTrainer
                                                : "No Trainer Selected",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            result != null
                                                ? "$yearsExpTrainer Years Experience"
                                                : "0 Years Experience",
                                            style:
                                            TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              "${result != null
                                                  ? traineesBookedTrainer
                                                  : "0"} Trainees (${result !=
                                                  null
                                                  ? reviewTrainer
                                                  : "0"} Reviews)",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          Text(
                                              "Session Period - ${result != null
                                                  ? sessionSlotTrainer
                                                  : "0"} Hours",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Trainer Price -  ${result != null
                                                  ? priceTrainer.toString()
                                                  : "0"} AED",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    SizedBox(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.04),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.15,
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: result == null
                                            ? Image.asset(
                                          baseImageAssetsUrl + 'logo.png',
                                        )
                                            : FadeInImage.assetNetwork(
                                          placeholder:
                                          baseImageAssetsUrl +
                                              'logo.png',
                                          image: BASE_URL +
                                              'uploads/trainer-user/' +
                                              imageTrainer,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Visibility(
                          //   visible: widget.form
                          //   Type.isEmpty ? true : false,
                          //   child: Padding(
                          //       padding: EdgeInsets.only(top: 18),
                          //       child: DropdownButton(
                          //         hint: selectedCity == null
                          //             ? Text('Select Trainer') : Text(selectedCity,
                          //           style: TextStyle(fontSize: 12),
                          //               ),
                          //         isExpanded: true,
                          //         iconSize: 30.0,
                          //         style: TextStyle(fontSize: 12),
                          //         items: _cities.map(
                          //           (val) {
                          //             return DropdownMenuItem<String>(
                          //               value: val,
                          //               child: Text(
                          //                 val,
                          //                 style: TextStyle(color: Colors.black),
                          //               ),
                          //             );
                          //           },
                          //         ).toList(),
                          //         onChanged: (val) {
                          //           setState(
                          //             () {
                          //               selectedCity = val;
                          //             },
                          //           );
                          //         },
                          //       )),
                          // ),
                          Visibility(
                              visible: widget.isSingle,
                              child: checkbox(
                                  iaccept, termsofService, acceptTerms)),
                          Container(
                            margin: EdgeInsets.only(top: padding25),
                            height: button_height,
                            width: SizeConfig.screenWidth,
                            child: _isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)) :RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if(widget.isSingle ) _isLoading = true;
                                });

                                // parms = {
                                //   "trainerPrice": result != null && result.length > 2 ? result[2].toString() : "0",
                                //   if (widget.memberIndex != null)"memberIndex": widget.memberIndex.toString(),
                                //   FIRSTNAME: firstNameController.text.toString().trim(),
                                //   MIDDLENAME: middletNameController.text.toString().trim(),
                                //   LASTNAME: lastNameController.text.toString().trim(),
                                //   CHILD: radioItem,
                                //   MOBILE: mobileController.text.toString().trim(),
                                //   EMAIL: emailController.text.toString().trim(),
                                //   PASSWORD: passwordController.text.toString().trim(),
                                //   BIRTH_DATE: sendDate,
                                //   EMIRATES_ID: emiratesController.text.toString().trim(),
                                //   if (widget.isSingle)ROLE_ID: rolePlanId.toString(),
                                //   if (widget.isSingle && roleId != null)ROLE_PLAN_ID: roleId.toString(),
                                //   EMEREGENCY_NUMBER: emergencyController.text.toString().trim(),
                                //   DESIGNATION: designationController.text.toString().trim(),
                                //   ADDRESS: addressController.text.toString().trim(),
                                //   CITY: selectedCity,
                                //   DEVICE_TYPE: deviceType,
                                //   GENDER: radioItem.toLowerCase(),
                                //   DEVICE_TOKEN: "deviceTok",
                                //   nationality: nationalityController.text,
                                //   workplace: workPlaceController.text,
                                //   marital_status: radioItemMarital.toLowerCase(),
                                //   about_us: aboutUsController.text,
                                //   trainer_id : result != null ? result[0]["id"].toString() : "",
                                //   trainer_slot : result != null ? result[1].toString() : "",
                                //   if(widget.type == 'fairMont') durationOfStay: durationController.text,
                                //   if(widget.type == 'fairMont') hotelNo: hotelController.text,
                                // };
                                //   print("$parms");
//                                _buildMagnifierScreen();

                                //  print("$fromDate");
                                print("check");
                               print("check form chekc2 $result");

                                if (formKey.currentState.validate()) {
                                  if ((widget.type != 'fairMont' &&
                                      widget.type != "guest") &&
                                      fromDate == null) {
                                    showDialogBox(context, 'Date of Birth',
                                        'Please fill your date of birth');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else if (radioItem == "") {
                                    showDialogBox(context, 'Gender',
                                        'Please select gender');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else if (((widget.memberIndex == 0 || widget.memberIndex == null) && selectedCity == null &&
                                      widget.type != 'fairMont' &&
                                      widget.type != "guest")) {
                                    showDialogBox(context, 'City',
                                        'Please select your city');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else if (radioItemMarital.isEmpty && widget.type != "guest" && widget.type != "fairMont" && (widget.memberIndex == 0 || widget.isSingle)) {
                                    showDialogBox(context, "Error!",
                                        'Please select marital status');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else if (widget.isSingle && !acceptTerms) {
                                    showDialogBox(context, termsofService,
                                        'Please read & accept our terms of services');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } else {
                                    if (widget.memberIndex == 0 || widget.memberIndex == null) {

                                      parms = {
                                        "trainerPrice":
                                        result != null && result.length > 2
                                            ? result[2].toString()
                                            : "0",
                                        if (widget.memberIndex != null)
                                          "memberIndex":
                                          widget.memberIndex.toString(),
                                        FIRSTNAME: firstNameController.text
                                            .toString()
                                            .trim(),
                                        MIDDLENAME: middletNameController.text
                                            .toString()
                                            .trim(),
                                        LASTNAME: lastNameController.text
                                            .toString(),
                                        CHILD: radioItem,
                                        MOBILE: mobileController.text
                                            .toString()
                                            .trim(),
                                        EMAIL: emailController.text
                                            .toString()
                                            .trim(),
                                        PASSWORD: passwordController.text
                                            .toString()
                                            .trim(),
                                        BIRTH_DATE: sendDate,
                                        trainerPriceNew: priceTrainer,
                                        EMIRATES_ID: emiratesController.text
                                            .toString()
                                            .trim(),
                                        if (widget.isSingle &&
                                            widget.type == "guest")
                                          ROLE_ID: 8.toString(),
                                        //rolePlanId.toString(),
                                        if (widget.isSingle &&
                                            widget.type != "fairMont" &&
                                            widget.type != "guest")
                                          ROLE_ID: rolePlanId.toString(),
                                        //rolePlanId.toString(),
                                        if (widget.isSingle &&
                                            widget.type == "fairMont")
                                          ROLE_ID: 9.toString(),
                                        //rolePlanId.toString(),
                                        if (widget.isSingle && roleId != null)
                                          ROLE_PLAN_ID: roleId.toString(),
                                        EMEREGENCY_NUMBER: emergencyController
                                            .text
                                            .toString()
                                            .trim(),
                                        DESIGNATION: designationController.text
                                            .toString()
                                            .trim(),
                                        ADDRESS: addressController.text
                                            .toString()
                                            .trim(),
                                        CITY: selectedCity,
                                        DEVICE_TYPE: deviceType,
                                        GENDER: radioItem.toLowerCase(),
                                        DEVICE_TOKEN: deviceTok != null ? deviceTok : "deviceTok",
                                        nationality: nationalityController.text,
                                        workplace: workPlaceController.text,
                                        marital_status:
                                        radioItemMarital.toLowerCase(),
                                        about_us: aboutUsController.text,
                                        trainer_id:
                                        result != null ? idTrainer : "",
                                        trainer_slot: result != null
                                            ? sessionSlotTrainer
                                            : "",
                                        trainerData:
                                        jsonEncode(result.toString()),
                                        if (widget.type == 'fairMont')
                                          durationOfStay:
                                          durationController.text,
                                        if (widget.type == 'fairMont')
                                          hotelNo: hotelController.text,
                                        tName: nameTrainer,
                                        tExp: yearsExpTrainer,
                                        tTrainess: traineesBookedTrainer,
                                        tReview: reviewTrainer,
                                        tPrice: priceTrainer,
                                        timage: imageTrainer,
                                        checkInKey: checkInDate.toString(),
                                        checkOutKey: checkOutDate.toString(),
                                      };
                                      // print("vikas 0=====>${parms.toString()}");
                                      print("check param $parms");
                                      if (widget.gymMemberType ==
                                          "gym_members" ||
                                          widget.gymMemberType ==
                                              "pool_and_beach_members")
                                        Navigator.pop(context, [parms, file]);
                                    } else {
                                      parms = {
                                        "trainerPrice":
                                        result != null && result.length > 2
                                            ? result[2].toString()
                                            : "0",
                                        "memberIndex":
                                        widget.memberIndex.toString(),
                                        FIRSTNAME +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        firstNameController.text
                                            .toString()
                                            .trim(),
                                        //first_name_1
                                        MIDDLENAME +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        middletNameController.text
                                            .toString()
                                            .trim(),
                                        LASTNAME +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        lastNameController.text
                                            .toString(),
                                        CHILD + '${widget.memberIndex == 0
                                            ? ""
                                            : "_${widget.memberIndex}"}':
                                        radioItem,
                                        MOBILE +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        mobileController.text
                                            .toString()
                                            .trim(),
                                        EMAIL + '${widget.memberIndex == 0
                                            ? ""
                                            : "_${widget.memberIndex}"}':
                                        emailController.text
                                            .toString()
                                            .trim(),
                                        trainerPriceNew +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        priceTrainer,
                                        PASSWORD +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        passwordController.text
                                            .toString()
                                            .trim(),
                                        BIRTH_DATE +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        sendDate,
                                        EMIRATES_ID +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        emiratesController.text
                                            .toString()
                                            .trim(),
                                        EMEREGENCY_NUMBER: emergencyController
                                            .text
                                            .toString()
                                            .trim(),
                                        DESIGNATION: designationController.text.toString().trim(),

                                        trainer_id + '${widget.memberIndex == 0 ? "" : "_${widget.memberIndex}"}': result != null ? idTrainer : "",
                                        trainer_slot +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        result != null
                                            ? sessionSlotTrainer
                                            : "",
                                        trainerData +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        result != null ? jsonEncode(result.toString()) : "", ADDRESS + '${widget.memberIndex == 0 ? "" : "_${widget.memberIndex}"}': addressController.text.toString().trim(),
                                        CITY+ '${widget.memberIndex == 0 ? "" : "_${widget.memberIndex}"}': selectedCity,
                                        DEVICE_TYPE: deviceType,
                                        GENDER + '${widget.memberIndex == 0 ? "" : "_${widget.memberIndex}"}': radioItem.toLowerCase(),
                                        DEVICE_TOKEN: deviceTok != null ? deviceTok : "deviceTok",
                                        if (widget.memberIndex == 0)
                                          nationality:
                                          nationalityController.text,
                                        if (widget.memberIndex == 0)
                                          workplace: workPlaceController.text,
                                        if (widget.memberIndex == 0)
                                          marital_status:
                                          radioItemMarital.toLowerCase(),
                                        if (widget.memberIndex == 0)
                                          about_us: aboutUsController.text,
                                        if (widget.type == 'fairMont')
                                          durationOfStay:
                                          durationController.text,
                                        if (widget.type == 'fairMont')
                                          hotelNo: hotelController.text,
                                        tName + '${widget.memberIndex == 0
                                            ? ""
                                            : "_${widget.memberIndex}"}':
                                        nameTrainer,
                                        tExp + '${widget.memberIndex == 0
                                            ? ""
                                            : "_${widget.memberIndex}"}':
                                        yearsExpTrainer,
                                        tTrainess +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        traineesBookedTrainer,
                                        tReview +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        reviewTrainer,
                                        tPrice +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        priceTrainer,
                                        timage +
                                            '${widget.memberIndex == 0
                                                ? ""
                                                : "_${widget.memberIndex}"}':
                                        imageTrainer,
                                        //  if ( widget.type)about_us: aboutUsController.text,
                                        //    if (widget.memberIndex == 0)about_us: aboutUsController.text,
                                      };
                                      Navigator.pop(context, [parms, file]);
                                      print(
                                          "vikas 00=====>${parms.toString()}");
                                    }
                                  }
                                  if (widget.isSingle) {

                                    // print("vikas 1=====>${file.path.toString()}");
                                    isConnectedToInternet().then((internet) {
                                      if (internet != null && internet) {

                                        widget.type == 'fairMont' || widget.type == 'guest' ? radioItem == "" ? showDialogBox( context, 'Gender', 'Please select gender') :
                                        signupWithouImage(parms)
                                            .then((response) {
                                          dismissDialog(context);
                                          if (response.status) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            setString(USER_AUTH, "Bearer " +
                                                response.data.token);
                                            setString(roleType,
                                                response.data.user.role.name);
                                            if (response.data != null && response.data.user != null)
                                              setString(userImage,
                                                  response.data.user.image);
                                            setString(USER_AUTH, "Bearer " + response.data.token);
                                        //   setString(UserFeeName,response.data.user.role.current_plan.fee_type.toString());//ideal
                                            setString(userCurrentRoleID,response.data.user.role.id.toString());
                                            setString(roleType, response.data.user.role.name);
                                       //     getRoleApi(context,response.data.user.role.nameFilter);
                                            setString(Id, response.data.user.id.toString());
                                            if (response.data != null && response.data.user != null)
                                              setString(userImage, response.data.user.image);

                                            if (response.data != null && response.data.user != null)
                                              setString(id, response.data.user.id.toString());
                                            print("roleIdCheck" + response.data.user.toJson().toString());

                                            if (response.data.user.my_sessions != null) {
                                              setString(mySessions, response.data.user.my_sessions.toString());
                                            }if (response.data.user.my_sessions != null) {
                                              setString(trainer_slot, response.data.user.trainer_slot.toString());
                                            }

                                            if (response.data != null &&
                                                response.data.user != null)
                                              setString(id,
                                                  response.data.user.id
                                                      .toString());
                                            print("roleIdCheck" + response.data.user.role.id.toString());
                                            setString(roleIdDash, response.data.user.role.id.toString());

                                            if (response.data.user.role !=
                                                null) {
                                              print("roleID " +
                                                  "${response.data.user.role
                                                      .toJson().toString()}");

                                              setString(userPlanImage,
                                                  response.data.user.role
                                                      .image);
                                              setString(roleName,
                                                  response.data.user.role.name);
                                              setString(Id,
                                                  response.data.user.id
                                                      .toString());

                                              setString(validTill,
                                                  response.data.user
                                                      .role_expired_on);
                                              setString(roleCategory,
                                                  response.data.user.role
                                                      .category);
                                              if (response.data.user.role
                                                  .current_plan != null) {
                                                setString(sessions,
                                                    response.data.user
                                                        .my_sessions
                                                        .toString());
                                              }
                                              if (response.data.user.role.current_plan != null) {
                                                setString(
                                                    rolePlan,
                                                    response.data.user.role
                                                        .current_plan
                                                        .role_plan);
                                                setString(UserFeeType,response.data.user.role.current_plan.fee.toString());

                                              }
                                            }
                                            setString(USER_NAME,
                                                response.data.user.full_name);

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              ScaleRoute(
                                                  page: widget.type == 'guest' || widget.type == 'fairMont'
                                                      ? Dashboard(role: response.data.user.role.name,
                                                  )
                                                      : SuccessScreen()),
                                                  (r) => false,
                                            );
                                          } else {
                                            var errorMessage = '';
                                            if (response.error != null) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              errorMessage = response
                                                  .error
                                                  .toString();
                                            } else if (response.errors !=
                                                null) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              errorMessage = response
                                                  .errors.email
                                                  .toString();
                                            }
                                            showDialogBox(context,
                                                "Error!", errorMessage);
                                          }
                                        })
                                            : signUpToServer(
                                            file: file,
                                            parms: parms,
                                            type: widget.type)
                                            .then((response) {
                                          dismissDialog(context);
                                          if (response.status) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              ScaleRoute(
                                                  page: SuccessScreen()),
                                                  (r) => false,
                                            );
                                          } else {
                                            var errorMessage = '';
                                            if (response.error != null) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              errorMessage = response
                                                  .error
                                                  .toString();
                                            } else if (response.errors !=

                                                null) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              errorMessage = response
                                                  .errors.email
                                                  .toString();
                                            }
                                            showDialogBox(context,
                                                "Error!", errorMessage);
                                          }
                                       });
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        showDialogBox(context, internetError,
                                            pleaseCheckInternet);
                                        dismissDialog(context);
                                      }
                                      dismissDialog(context);
                                    });
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print("Vikas  ${parms.toString()}");
                                  }
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print("Something went wrong");
                                }
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(button_radius)),
                              child: Text(
                                widget.isSingle ? signup : 'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget myText(String hint, bool isNumber) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(fontSize: textSize10)),
      ),
    );
  }

  Widget radiobutton(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItem,
        activeColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(fontSize: 10),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItem = val;
          });
        },
      ),
    );
  }

  Widget radioMerital(String title) {
    return Expanded(
      child: RadioListTile(
        groupValue: radioItemMarital,
        activeColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
        value: title,
        onChanged: (val) {
          setState(() {
            radioItemMarital = val;
            print("${radioItemMarital.toLowerCase()}");
          });
        },
      ),
    );
  }

  Widget checkbox(String title, String richTExt, bool boolValue) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                acceptTerms = value;
                if (value) {
                  // getTerms();
                }
              });
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new RichText(
                text: new TextSpan(
                  text: title,
                  style: TextStyle(fontSize: textSize10, color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: richTExt,
                        style: TextStyle(
                            fontSize: textSize10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ],
                ),
              ),
            ),
            onTap: () {
              getTerms();
            },
          ),
        ],
      ),
    );
  }

  void getTerms() async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        showProgress(context, "Please wait.....");

        getTermsApi().then((response) {
          dismissDialog(context);
          if (response.status) {
            if (response.data != null) {
              if (response.data.config != null &&
                  response.data.config.isNotEmpty)
                termsBottom('Terms & Conditions', response.data.config);
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

  void termsBottom(String title, String msg) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(50.0),
                              topRight: const Radius.circular(50.0))),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            child: Padding(
                              child: Align(
                                child: Icon(Icons.close),
                                alignment: Alignment.topRight,
                              ),
                              padding: EdgeInsets.all(15),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Html(data: msg),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 25, bottom: 0),
                          //       child: Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Image.asset(
                          //           baseImageAssetsUrl + 'logo.png',
                          //           height: 90,
                          //           color: Color(0xff8B8B8B),
                          //           width: 120,
                          //         ),
                          //       ),
                          //     ),
                          //     Spacer(),
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 25, bottom: 0),
                          //       child: Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: SvgPicture.asset(
                          //           baseImageAssetsUrl + 'vector_lady.svg',
                          //           height: 90,
                          //           width: 120,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 20,
                          //     )
                          //   ],
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 40, bottom: 10),
                          //   child: Align(
                          //       alignment: Alignment.centerLeft,
                          //       child: Text(
                          //         volt_rights,
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //             color: Color(0xff8B8B8B),
                          //             fontSize: 8,
                          //             fontStyle: FontStyle.italic,
                          //             fontFamily: open_italic),
                          //       )),
                          // ),
                          footer(),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      )),
                ));
          });
        });
  }

  List result;
  int planPrice ,trainerPrice ;
  String nameTrainer = "";
  String yearsExpTrainer = "";
  String traineesBookedTrainer = "";
  String reviewTrainer = "";
  String priceTrainer = "";
  String imageTrainer = "";
  String sessionSlotTrainer = "";
  String idTrainer = "";

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ChoosePersonalTrainer()),
    );

    if (result != null) {
      print("$result");
      nameTrainer = result[0]["full_name"];
      yearsExpTrainer = result[0]["expirence"];
      traineesBookedTrainer = result[0]["booking_cnt"].toString();
      reviewTrainer = result[0]["booking_reviewed_cnt"].toString();
      sessionSlotTrainer = result[1].toString();

      if (priceTrainer != null){
        priceTrainer = result[2].toString();
        planPrice = result[2] + int.tryParse(widget.planPrice) ;
      }
      imageTrainer = result[0]['image'];
      idTrainer = result[0]["id"].toString();
    }
    setState(() {});
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Select Options'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        imageLoader = true;
                        await picker
                            .getImage(source: ImageSource.camera)
                            .then((value) {
                          if (value != null) {
                            Navigator.of(context).pop();
                            imageLoader = false;
                            setState(() {
                              file = File(value.path);
                              //  Navigator.of(context).pop();
                            });
                            print("file Select " + file.toString());
                          }
                        });
                      },
                      child:
                      const Text('Camera', style: TextStyle(fontSize: 15)),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        imageLoader = true;
                        await picker
                            .getImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value != null) {
                            Navigator.of(context).pop();
                            imageLoader = false;
                            setState(() {
                              file = File(value.path);
                              //  Navigator.of(context).pop();
                            });
                            print("file Select " + file.toString());
                          }
                        });
                      },
                      child:
                      const Text('Gallery', style: TextStyle(fontSize: 15)),
                    ),
                    imageLoader
                        ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ))
                        : Container(),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}

//Positioned(
//  left: 50,
//  bottom: padding50 + padding30,
//  child:
//  Image.asset(baseImageUrl + 'user_sign.png'),
//),
