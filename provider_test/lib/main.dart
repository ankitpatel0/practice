import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/home_page.dart';
import 'package:provider_test/provider_file.dart';

import 'api/provider/todo_provider.dart';
import 'count_example.dart';
import 'example_one_provider.dart';
import 'example_one_screen.dart';
import 'home_screen.dart';
import 'increment_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // i am using the single provider //

    // return ChangeNotifierProvider(
    //   create: (context) => CountProvider(),
    //   child: MaterialApp(
    //       debugShowCheckedModeBanner: false, home: ExampleOneScreen()),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
        ChangeNotifierProvider(create: (context) => ExampleOneProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => Increment())
      ],
      child: MaterialApp(home: ExampleOneScreen()),
    );
  }
}
