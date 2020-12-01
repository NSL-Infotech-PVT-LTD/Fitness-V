import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
   static const platform = const MethodChannel('flutter.native/helper');
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: nativeMethod,
        child: Text("Payment"),
        ),
      ),
    );
  }


 void nativeMethod() async {
   String res =""; 
   try {
   String result= await platform.invokeMethod('nativeMethod');
   
   res =result;  
   print(result);
   } on PlatformException catch (e) {
     res = "Failed to Invoke: '${e.message}'.";
   } 
 
 }
 


}