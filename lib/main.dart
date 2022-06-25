import 'package:buzzride/Home/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = "BuzzRide";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            subtitle2: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            bodyText1: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            bodyText2: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
          )),
      home: const MyHomePage(title: title),
    );
  }
}
