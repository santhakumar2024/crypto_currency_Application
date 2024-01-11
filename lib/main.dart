// ignore_for_file: prefer_const_constructors

import 'package:crypto_app/apptheme.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.getThemeValue();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRYPTOAPP',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: Homescreen(),
    );
  }
}

