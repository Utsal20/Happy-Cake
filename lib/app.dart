import 'package:flutter/material.dart';
import 'package:happy_cake/screens/inquiry.dart';
import 'package:happy_cake/screens/order_info.dart';
import 'package:happy_cake/screens/user_info.dart';
<<<<<<< HEAD
import 'package:happy_cake/screens/all_info.dart';
=======
import 'package:happy_cake/screens/allInfo.dart';
>>>>>>> 8f9e5fb1e92ae703b63e594d230f81f88e7efb78
import 'package:happy_cake/screens/confirmation.dart';

class HappyCakeApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Cake',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFfd689a),
        accentColor: Color(0xFF66d9c1),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
          title: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
          body1: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
      home: InquiryPage(),
      routes: <String, WidgetBuilder> {
        '/inquiryPage': (BuildContext context) => InquiryPage(),
        '/orderInfo': (BuildContext context) => OrderInfo(),
        '/clientInfo': (BuildContext context) => UserInfo(),
        '/allInfo': (BuildContext context) => AllInfo(),
        '/confirmation': (BuildContext context) => Confirmation(),

      }
    );
  }
}