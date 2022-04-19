// ignore_for_file: file_names, prefer_const_constructors, unnecessary_string_interpolations, unused_import
import 'package:flutter/material.dart';

Widget myButton (BuildContext context, double width, double height, String text, String route){
  // ignore: prefer_typing_uninitialized_variables
  return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      child: Text("$text",
      style: TextStyle(fontSize: 18),
      ),
      ),
    );
}
