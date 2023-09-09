import 'package:flutter/material.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .27,
            width: size.width * 100,
            color: Color(0xFFD8515B),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back, color: Colors.white,)),
                    Image.asset("assets/images/refer&earn.png", scale: 4),
                    IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ));
                        },
                        icon: Icon(Icons.help, color: Colors.white,)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
