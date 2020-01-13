import 'package:firebase_ejemplo/pages/add_page.dart';
import 'package:firebase_ejemplo/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/add' : (BuildContext context) => AddPage(),
      },
    );
  }
}