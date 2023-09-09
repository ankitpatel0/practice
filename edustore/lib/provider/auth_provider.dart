import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/usermodel.dart';

// class AuthProvider extends ChangeNotifier {
//   bool _isLoggedIn = false;
//
//   bool get isLoggedIn => _isLoggedIn;
//
//   void setLoggedIn(bool value) {
//     _isLoggedIn = value;
//     notifyListeners();
//   }
// }




class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> fetchUserData() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    var user =
    await FirebaseFirestore.instance.collection("users").doc(auth).get();
    if (user.exists) {
      _userModel = UserModel.fromJson(user.data()!);
      notifyListeners();
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _userModel = null;
    notifyListeners();
  }
}
