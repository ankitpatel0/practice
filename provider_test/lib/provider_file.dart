import 'package:flutter/cupertino.dart';


class CountProvider with ChangeNotifier{
 int _count = 60;
 bool _increment = false;
 bool _decrement = false;
 int get count => _count;

 // void setCount() {
 //  _count++;
 //  notifyListeners();
 // }
 // void countDown(){
 //  _count--;
 //  notifyListeners();
 // }

 void startIncrement(){
_increment=true;
_incrementValue();
 }
 void startDecrement(){
  _decrement=true;
  _decrementValue();
 }
 void stopIncrement(){
  _increment=false;
  _decrement=false;
 }
 void resetValue(){
 _count =60;
 notifyListeners();
 }


 void _incrementValue(){
  if(_increment){
   _count++;
   notifyListeners();
   Future.delayed(Duration(seconds: 1), _incrementValue);
  }
 }
 void _decrementValue(){
  if(_decrement){
   _count--;
   notifyListeners();
   Future.delayed(Duration(seconds: 1), _decrementValue);
  }
 }
}

