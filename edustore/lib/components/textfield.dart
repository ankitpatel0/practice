import 'package:flutter/material.dart';

Widget textField(

    {String? hintName,
   required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    double paddingValue = 20,required Icon prefixIcon}) {
  return Padding(
    padding: EdgeInsets.all(paddingValue),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          cursorColor: Colors.white,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.blue),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.black)),
              hintText: hintName),
        ),
      ],
    ),
  );
}
