import 'package:edustore/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/button.dart';
import 'otp_screen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  //there is a store number in share preferences //
  storeNumber() async {
    final prefs = await SharedPreferences.getInstance();
    int numberValue = int.tryParse(phoneController.text) ?? 0;
    prefs.setInt('number', numberValue);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/auth_screen_top.png',
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            textField(
              controller:phoneController,
              hintName: "Enter your phone number",
              prefixIcon: Icon(Icons.phone_android),
            ),
            button(
                onPressed: () {
                otpSend();
            }, buttonText: "Login", insidePadding: 15),
          ],
        ),
      ),
    );
  }

  otpSend()async{
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        verificationCompleted:
            (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          PhoneAuth.verify = verificationId;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const OtpPage()));
          storeNumber();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
    Fluttertoast.showToast(msg: "Otp Sent Failed");
    }
  }
}
