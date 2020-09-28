import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {

      var nonZeroIndex = i + 1;
      if (i == 0) {
        buffer.write('+'); // Add double spaces.
      }
      buffer.write(text[i]);

    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
