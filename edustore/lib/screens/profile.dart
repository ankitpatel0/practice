import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/usermodel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateNumberController = TextEditingController();

  String? url;

  //get user data
  UserModel? userModel;
  var auth = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    retrieveData().then((value) {
      userModel = value;
      updateNameController.text = userModel?.name ?? "";
      updateEmailController.text = userModel?.email ?? "";
      updateNumberController.text = userModel?.number ?? "";
      setState(() {
        // userModal?.toJson().values;
      });
    });
  }

  // Image pic for gallery and camera//
  File? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        uploadImageToFirebase();
      });
    }
  }

  // Upload image to Firebase FireStore //
  Future<void> uploadImageToFirebase() async {
    if (imageFile != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('UserProfile')
          .child('$auth.jpg');
      UploadTask uploadTask = ref.putFile(File(imageFile!.path));
      TaskSnapshot snapshot = await uploadTask;
      setState(() async {
        url = await snapshot.ref.getDownloadURL();
        print(url);
        userUpdateProfilePic();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: const Color(0xffea5d49),
          // leading: const Icon(
          //   Icons.arrow_back,
          //   color: Colors.white,
          // ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 120,
                    width: 120,
                    child: InkWell(
                      child: imageFile != null
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(imageFile!),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userModel?.imageUrl ?? ""),
                            ),
                      onTap: () {
                        showModalBottomSheet(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (ctx) => Container(
                                height: 120,
                                color: Colors.white54,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Camera"),
                                      leading: Icon(Icons.camera_alt),
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Gallery"),
                                      leading: Icon(Icons.image),
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )));
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Edit Details"),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close))
                                      ],
                                    ),
                                    content: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: updateNameController,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              hintText: "${userModel?.name}",
                                              // hintText: "${showUserData?.name}",
                                              icon: Icon(Icons.person),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: updateEmailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              hintText: "${userModel?.email}",
                                              // hintText: '${showUserData?.email}',
                                              icon: Icon(Icons.mail),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            enabled: true,
                                            maxLength: 10,
                                            controller: updateNumberController,
                                            decoration: InputDecoration(
                                              hintText: "${userModel?.number}",
                                              icon: Icon(Icons.phone),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          child: Text("Update & Save"),
                                          onPressed: () {
                                            userUpdateProfile();
                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.edit_square,
                            color: Colors.redAccent,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: Card(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("${userModel?.name}"),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.mail),
                          title: Text("${userModel?.email}"),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.call),
                          title: Text("${userModel?.number}"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Other Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: Card(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.batch_prediction),
                          title:
                              Text('Jagdishpur,Po-Lachchhi Kaituka,Ps-Maker'),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text('Saran, Bihar'),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.location_pin),
                          title: Text('Bihar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Card(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  void userUpdateProfilePic() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance.collection("users").doc(auth).update({
      "imageUrl": url,
    }).then((value) {});
  }

  void userUpdateProfile() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    await uploadImageToFirebase();
    FirebaseFirestore.instance.collection("users").doc(auth).update({
      "name": updateNameController.text,
      "number": updateNumberController.text,
      "email": updateEmailController.text,
    }).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    });
  }

  Future<UserModel?> retrieveData() async {
    var uuid = FirebaseAuth.instance.currentUser?.uid;
    var user =
        await FirebaseFirestore.instance.collection("users").doc(uuid).get();
    var userModel = UserModel.fromJson(user.data()!);
    return userModel;
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xffea5d49);
    Path path = Path()
      ..relativeLineTo(0, 120)
      ..quadraticBezierTo(size.width / 2, 210.0, size.width, 122)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
