import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edustore/screens/login.dart';
import 'package:edustore/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/usermodel.dart';
import '../provider/auth_provider.dart';
import '../refer_earn/refer_earn.dart';
import '../wallet/wallet.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
    _userProvider.fetchUserData();
  }

  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    retrieveData().then((value) {
      userModel = value;
      setState(() {
        // userModal?.toJson().values;
      });
    });
  }

  Future<UserModel?> retrieveData() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    var user =
        await FirebaseFirestore.instance.collection("users").doc(auth).get();
    if (user.exists) {
      var userModel = UserModel.fromJson(user.data()!);
      return userModel;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Account',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
              },
              child: SizedBox(
                height: size.height / 7,
                child: Stack(
                  children: [
                    Card(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.orangeAccent,
                                        backgroundImage: NetworkImage(
                                            userModel?.imageUrl ?? "",
                                            scale: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel?.name ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(userModel?.number ?? ""),
                              Text(
                                userModel?.email ?? "",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Card(
              elevation: 3,
              child: ListTile(
                  leading: Image(
                    image: AssetImage("assets/images/booking.png"),
                    height: 30,
                  ),
                  title: Text("My Booking"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WalletScreen(),
                  ),
                );
              },
              child: const Card(
                elevation: 1,
                child: ListTile(
                  leading: Icon(Icons.wallet),
                  title: Text("Wallet"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            const Card(
              elevation: 1,
              child: ListTile(
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text("Card"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            const Card(
              elevation: 1,
              child: ListTile(
                  leading: Icon(Icons.discount),
                  title: Text("Offers"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            GestureDetector(
              onTap: () {
                launch("tel:7257016877");
              },
              child: const Card(
                elevation: 1,
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text("Call Support"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReferEarnScreen(),));
              },
              child: const Card(
                elevation: 1,
                child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text("Refer & Earn"),
                    trailing: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),
            const Card(
              elevation: 1,
              child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            const Card(
              elevation: 1,
              child: ListTile(
                  leading: Image(
                    image: AssetImage("assets/images/about.png"),
                    height: 28,
                  ),
                  title: Text("About Us"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            const Card(
              elevation: 1,
              child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Feedback"),
                  trailing: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            const SizedBox(
              height: 25,
            ),
            Card(
              elevation: 1,
              child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("LogOut"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Row(
                                children: [
                                  Icon(Icons.logout),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("LogOut"),
                                  ),
                                ],
                              ),
                              content:
                                  const Text("Are you sure you want to logout"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ));
                                      });
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ));
                  }),
            ),
          ],
        ));
  }
}
