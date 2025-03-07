import 'package:flutter/material.dart';
import 'package:my_bank/HomePage.dart';
import 'package:my_bank/Profile.dart';
import 'package:my_bank/SplashScreen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
