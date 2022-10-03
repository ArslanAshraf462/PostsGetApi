import 'package:flutter/material.dart';
import 'package:get_api/photos_screen.dart';
import 'package:get_api/sign_up.dart';
import 'package:get_api/user_2_screen.dart';
import 'package:get_api/user_screen.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserSecondScreen(),
    );
  }
}