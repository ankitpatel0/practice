import 'dart:async';
import 'package:edustore/domain/phone_auth/phone_auth_screen.dart';
import 'package:edustore/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ButtonNavigation/buttom_navigation.dart';
import '../../screens/user_exists.dart';

class OtpPage extends StatefulWidget {
  // final phoneNumber;

  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  //there show loading process after click on verify button
  bool isLoading = false;

  TextEditingController pinController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  //there implement resend otp countdown
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;

  //show user number code start
  int? number;

  @override
  void initState() {
    super.initState();
    //getData function there
    getData();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  Future getData() async {
    var sharepref = await SharedPreferences.getInstance();
    setState(() {
      number = sharepref.getInt('number')!;
    });
  }

  //Here store user uId
  storeUid(String uid) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  //show user number code start

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/otp img.png',
                  scale: 5,
                ),
              ),
              SizedBox(height: 10,),
              const Center(
                  child: Text(
                "Verification Code",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
              const SizedBox(
                height:10,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                   const Text(
                    "Please enter the verification code sent to",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "+91 $number",
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Pinput(
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  length: 6,
                  showCursor: true,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive an OTP ?",style: TextStyle(fontSize: 17),),
                  Text("After $secondsRemaining seconds"),
                  TextButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91${numberController.text}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              PhoneAuth.verify = verificationId;
                              Fluttertoast.showToast(msg: "Sent OTP");
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                          resendCode();
                        } catch (e) {}
                      },
                      child: const Text("Resend OTP ?",style: TextStyle(fontSize: 15,color: Colors.deepPurple),)),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: PhoneAuth.verify,
                                    smsCode: pinController.text);
                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                            var uId = FirebaseAuth.instance.currentUser?.uid;
                            bool userExists = await checkUserExists(uId!);
                            storeUid(uId.toString());
                            if (userExists) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavigation(),
                                  ));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            }

                            Fluttertoast.showToast(msg: "Login successful");
                          } catch (e) {
                            Fluttertoast.showToast(msg: "Enter Valid OTP");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Verify Otp")),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void resendCode() {
    //again resend count time code here
    setState(() {
      secondsRemaining = 60;
      enableResend = true;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
