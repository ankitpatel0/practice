import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edustore/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    getDataFromFirestore(); // Call the method to fetch data when the page loads.
  }

  void getDataFromFirestore() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    var docRef = FirebaseFirestore.instance.collection("users").doc(auth);

    try {
      var snapshot = await docRef.get();

      if (snapshot.exists) {
        var data = snapshot.data();
        setState(() {
          _nameController.text = data?['name'] ?? '';
          _emailController.text = data?['email'] ?? '';
          _ageController.text = data?['age'] ?? '';
          dropdownValue = data?['gender'] ?? '';
        });
      } else {
        print('Document does not exist on FireStore.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  // late final _genderController = TextEditingController();

  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: const Color(0xFFD8515B),
        ),
        body: Card(
          elevation: 3,
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/236x/de/f1/25/def1255ef41e60b984d2b92869a43223.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: "Enter Your Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 3,
                            ))),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: "Enter Your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 3,
                            ))),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.ac_unit),
                        labelText: "Enter Your Age",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 3,
                            ))),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      filled: false,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      "Male",
                      "Female",
                      "Other",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 17),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60, right: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD8515B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          userUpdateProfile();
                        },
                        child: const Text("Update")),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void userUpdateProfile() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(auth).update({
      "name": _nameController.text,
      "age": _ageController.text,
      "email": _emailController.text,
      "gender": dropdownValue,
    }).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    });
  }
}
