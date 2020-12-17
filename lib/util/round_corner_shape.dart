import 'package:flutter/material.dart';

class RoundCornerShape extends StatelessWidget {
  Widget child;
  Color bgColor;
  double radius;

  RoundCornerShape(
      {@required this.child, @required this.bgColor, @required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius))),
      color: bgColor,
      child: child,
    ));
  }
}
