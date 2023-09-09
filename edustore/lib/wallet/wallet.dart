import 'package:edustore/wallet/wallet_faqs.dart';
import 'package:flutter/material.dart';

import '../ButtonNavigation/account_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        // The containers in the background
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .15,
              color: Color(0xFFD8515B),
              child: SafeArea(
                  child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen(),));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Text(
                        "Wallet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 191, top: 15),
                      child: Text(
                        "FAQ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletFaqs()));
                          },
                          icon: Icon(
                            Icons.help,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          padding:
              EdgeInsets.only(top: size.height * 0.1, right: 20.0, left: 20.0),
          child: SizedBox(
            height: 186.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image.asset(
                        "assets/images/wallet.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("TOTAL WALLET BALANCE"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120, top: 4),
                          child: Text(
                            "₹ 0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(
                    width: size.width / 1.2,
                    height: size.height / 12,
                    child: Card(
                      color: Color(0xE1DFDFD5),
                      child: Row(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your Cash",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "₹ 0.00",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Text(" |",
                            style: TextStyle(fontSize: 48, color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your Cash",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "₹ 0.00",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75),
                          child: IconButton(onPressed: () {  }, icon: Icon(Icons.info_outline_rounded)),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          right: 16,
          left: 16,
          child: Container(
            alignment: Alignment.topCenter,
            padding:
                EdgeInsets.only(top: size.height * 0.1,),
            child: SizedBox(
              height: 116.0,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                child: Column(
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Image.asset(
                          "assets/images/wallet.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12,right: 140),
                            child: Text("Refer Friends",style: TextStyle(fontWeight:FontWeight.bold)),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            "Refer friends, earn wallet money!",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 145),
                            child: TextButton(onPressed: () {  }, child: Text("REFER NOW",style: TextStyle(color: Colors.deepPurple),),

                            ),
                          ),

                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
