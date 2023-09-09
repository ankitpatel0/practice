import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/home_screen.dart';

import 'api/home.dart';
import 'example_one_provider.dart';
import 'favourite/favourite_screen.dart';
import 'home_page.dart';

class ExampleOneScreen extends StatefulWidget {
  const ExampleOneScreen({super.key});

  @override
  State<ExampleOneScreen> createState() => _ExampleOneScreenState();
}

class _ExampleOneScreenState extends State<ExampleOneScreen> {
  double value = 1.0;

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Multi Provider Screen")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ExampleOneProvider>(builder: (context, value, child) {
            return Slider(
                min: 0,
                max: 1,
                value: value.value,
                onChanged: (val) {
                  value.setValue(val);
                });
          }),
          Consumer<ExampleOneProvider>(builder: (context, value, child) {
            print("container 1");
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(value.value),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text("Container 1"),
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(value.value),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text("Container 2"),
                    ),
                  ),
                ),
              ],
            );
          }),
          Gap(20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
              child: Text("Home")),
          Gap(20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text("Increment Page")),
          Gap(20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text("CountDown Reset Stop")),
          Gap(20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ));
              },
              child: Text("FavouriteScreen"))
        ],
      ),
    );
  }
}
