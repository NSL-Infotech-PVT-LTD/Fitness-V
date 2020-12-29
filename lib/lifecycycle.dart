import 'package:flutter/material.dart';

class MyInheritedData extends InheritedWidget {
  final String myField;
  final ValueChanged<String> onMyFieldChange;

  MyInheritedData({
    Key key,
    this.myField,
    this.onMyFieldChange,
    Widget child,
  }) : super(key: key, child: child);

  static MyInheritedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedData>();
  }

  @override
  bool updateShouldNotify(MyInheritedData oldWidget) {
    return oldWidget.myField != myField ||
        oldWidget.onMyFieldChange != onMyFieldChange;
  }
}