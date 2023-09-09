import 'package:flutter/cupertino.dart';

class Increment extends ChangeNotifier{
  var number=1;
  void ankit(){
    number++;
    notifyListeners();
  }
  void abhi(){
    number--;
    notifyListeners();
  }
}