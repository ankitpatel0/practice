import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ButtonNavigation/buttom_navigation.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // if the user is already Login to Send ButtonNavigation Page//
      _isUserLogin().then((value) {
        if (value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigation()));
        }
        // if the NewUser Login to Send Login Page//
        else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      });
    });
  }

  // Create Function _isUserLogin  and check user is logged in and  logged  in or Not Login //
  Future<bool> _isUserLogin() async {
    var loginStatus = FirebaseAuth.instance.currentUser?.uid;
    if (loginStatus != null) {
      return true;
    } else {
      return false;
    }
  }

  // end Function //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe12a12),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/splash_book_mybus.png"),
          const SizedBox(height: 20),
          const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.cyan,
            color: Colors.yellow,
          )),
        ],
      ),
    );
  }
}
