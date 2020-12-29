import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var mediaHeight;
var mediaWidth;

class ViewTrainer extends StatefulWidget {
  @override
  _ViewTrainerState createState() => _ViewTrainerState();
}

class _ViewTrainerState extends State<ViewTrainer> {
  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    String fontFam = "fonts/regular.ttf";
    bool isDescription;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // titleSpacing: -5,
          leading: Icon(Icons.arrow_back_ios_sharp),
          title: Text("Personal Trainer"),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(top:15.0,right:15.0),
          //     child: Text("SKIP",style: TextStyle(fontSize: 18),),
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:mediaHeight * 0.03,left:mediaHeight * 0.03,bottom: mediaHeight * 0.03),
              child: Row(
                children: [
                  Container(
                     // color: Colors.red,
                      height: mediaHeight * 0.18,
                      child: Image.asset(
                        "assets/images/vectorS.png",
                        fit: BoxFit.fitWidth,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Farley Willth",style: TextStyle(fontSize: 17),),
                        Text("7 Years Experineced",style: TextStyle(fontSize: 13),),
                        Text("1022 Trainees (789 Reviews)",style: TextStyle(fontSize: 13),),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: mediaWidth * 0.60
                          ),
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            itemSize: mediaWidth * 0.05,

                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        Container(
                          width: mediaWidth * 0.40,
                          child: RaisedButton(
                            color: Color(0xff171515),
                            onPressed: (){},
                            child: Text("Book Now",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xffE9E9E9),
              width: mediaWidth,
              height: mediaHeight * 0.07,
              child: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Row(
                  children: [
                    InkWell(child: Text("Description",style: TextStyle(color: Colors.black),),onTap: (){
                      setState(() {
                        isDescription = true;
                      });
                    },), SizedBox(width: mediaWidth * 0.03,), InkWell(child: Text("Reviews",style: TextStyle( color: Colors.grey),),onTap: (){
                      setState(() {
                        isDescription = false;
                      });
                    },)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
