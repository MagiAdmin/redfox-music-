import 'package:flutter/material.dart';
import 'page/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'play it wild',
    theme: ThemeData(
      primaryColor: Colors.grey.shade900,
      primaryColorBrightness: Brightness.dark,
    ),
    home: Home(),
  ));
}
