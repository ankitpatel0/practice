import 'package:flutter/material.dart';

Widget button({
  required void Function()? onPressed,
  required String buttonText,
  double paddingValue = 25,
  double insidePadding = 10,
}) {
  return Padding(
    padding: EdgeInsets.all(paddingValue),
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const StadiumBorder(),
            padding: EdgeInsets.all(insidePadding)),
        child: Text(buttonText)),
  );
}
