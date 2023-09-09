import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'increment_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Increment>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<Increment>(
            builder: (context, value, child) {
              return Center(child: Text("${value.number}",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),));
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            onPressed: () {
              data.ankit();
            },
          ),
          Gap(20),
          FloatingActionButton(
            child: Icon(Icons.remove),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            onPressed: () {
              data.abhi();
            },
          ),
        ],
      ),
    );
  }
}
