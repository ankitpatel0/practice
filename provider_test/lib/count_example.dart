import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/provider_file.dart';

class CountExample extends StatefulWidget {
  const CountExample({super.key});

  @override
  State<CountExample> createState() => _CountExampleState();
}

class _CountExampleState extends State<CountExample> {
  // @override
  // void initState() {
  //   super.initState();
  //   final countProvider = Provider.of<CountProvider>(context, listen: false);
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     countProvider.setCount();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    // agr listen false nahi karte hai to ye pure widgets to rebuild krta hai
    print("rebuild method called");
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Provider Example"))),
      body: Column(
        children: [
          Center(child: Consumer<CountProvider>(
            builder: (context, value, child) {
              print("Only count Text widgets build");
              return Text(
                value.count.toString(),
                style: TextStyle(fontSize: 50, color: Colors.purple),
              );
            },
          )),
          ElevatedButton(onPressed: () {
            // countProvider.setCount();
          }, child: Text("Start Counter"))
        ],
      ),
    );
  }
}
