import 'package:flutter/material.dart';

class WalletFaqs extends StatefulWidget {
  const WalletFaqs({super.key});

  @override
  State<WalletFaqs> createState() => _WalletFaqsState();
}

class _WalletFaqsState extends State<WalletFaqs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet FAQs"),
        backgroundColor: const Color(0xFFD8515B),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Wallet FAQ's",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 70),
                    child: Text(
                      "• What is the BusBooker wallet?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                        "BusBooker wallet contains promotional\nmoney given to loyal BusBooker users so that\nthey can book tickets at reduced price."),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      "• When does the money in my wallet expire?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text(
                        "The money in wallet may expire depending\non how you have received it. You can\ncheck in the recent activity section to know\nwhen the money you have received will\nexpire."),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      "• Where can I use the wallet money?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                        "The wallet money can be used on all\nbookings with RedBus, with certain\nrestrictions.You can use wallet core money\n(your money) completely. But wallet money\ncredited as cash backs can be used up to\n10% of total booking amount."),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "• My wallet money has expired, what can I\n  do?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                        "You can always earn more wallet money by\nreferring your friends to the BusBooker app\n(upto a maximum of Rs. 1000) . This will\nalso give your friends wallet money to\nbook bus tickets online!"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
