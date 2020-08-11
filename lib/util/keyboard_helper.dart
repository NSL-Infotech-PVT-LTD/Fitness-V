import 'package:flutter/material.dart';

abstract class KeyboardHelper {
  static void hideKeyboard(BuildContext context) {

    FocusScope.of(context).requestFocus(FocusNode());


    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
