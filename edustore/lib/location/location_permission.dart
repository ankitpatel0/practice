import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:edustore/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

var auth = FirebaseAuth.instance.currentUser?.uid;

class _LocationScreenState extends State<LocationScreen> {

  userLocationDataStore() {
    try {
      FirebaseFirestore.instance.collection("users").doc(auth).update({
        "country": country,
        "state": state,
        "district": district,
        "village": village,
        "pinCode": pinCode,
      });
      Fluttertoast.showToast(msg: "store location data");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ,));
    } catch (e) {
      Fluttertoast.showToast(msg: "store location data fail");
    }
  }

  String state = "";
  String district = "";
  String pinCode = "";
  String village = "";
  String country = "";
  String formattedAddress = "";
  String _locationMessage = "";

  Future<void> _requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    if (permissionStatus == LocationPermission.denied) {
      setState(() {
        Fluttertoast.showToast(
          msg: "please give permission to the location",
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } else if (permissionStatus == LocationPermission.always ||
        permissionStatus == LocationPermission.whileInUse) {
      setState(() {
        _getLocation();
      });
    }
  }

  late LatLng _currentPosition;

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
        if (placeMarks.first.locality != null) {
          setState(() {
            village = placeMarks.first.locality!;
            pinCode = placeMarks.first.postalCode ?? '';
            country = placeMarks.first.country ?? '';
            state = placeMarks.first.administrativeArea ?? '';
            district = placeMarks.first.subAdministrativeArea ?? '';

            userLocationDataStore();
          });
        }

      setState(() {
        _locationMessage =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        Fluttertoast.showToast(
          msg: position.latitude.toString(),
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
        Fluttertoast.showToast(
          msg: _locationMessage,
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
          color: const Color(0xFFD8515B),
          child: Column(
            children: [
              const SizedBox(height: 27),
              const Padding(
                padding: EdgeInsets.only(right: 95),
                child: Text(
                  "Location\nPermissions",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                    "       Providing location permission enables us to \n       give you a hassle free boarding experience",
                    style: TextStyle(fontSize: 15)),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/location_permission_img.jpg',
                  ),
                  SizedBox(
                    height: 45,
                    width: 360,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD8515B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          _requestLocationPermission().then((value) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPage())));
                        },
                        child: const Text("Share Location")),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                ],
              )
            ],
          )),
    );
  }
}
