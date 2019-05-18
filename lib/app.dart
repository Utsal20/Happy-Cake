///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019

///This dart file is meant to declare the theme of the different font styles we use throughout the app.
///All of the different screens that will be used are imported into this file so that they can be called throughout the app

import 'package:flutter/material.dart';
import 'package:happy_cake/screens/inquiry.dart';
import 'package:happy_cake/screens/order_info.dart';
import 'package:happy_cake/screens/user_info.dart';
import 'package:happy_cake/screens/all_info.dart';
import 'package:happy_cake/screens/confirmation.dart';

///Creates a class for the app to be constructed... In Flutter nearly everything is a widget including the app itself
class HappyCakeApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(

      ///Title of the App/Page which never really comes up
      title: 'Happy Cake',
        debugShowCheckedModeBanner: false, ///Removes the debug banner from the corner
      theme: new ThemeData( ///Creating a new theme which is used throughout the app
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

      ///Sets the opening page of the app to the inquiry page (which explains what the app is doing)
      home: InquiryPage(),

      ///This is where we declare the route of the pages which will be accessed throughout the app
      routes: <String, WidgetBuilder> {
        '/inquiryPage': (BuildContext context) => InquiryPage(), ///Also known as welcome page
        '/orderInfo': (BuildContext context) => OrderInfo(),
        '/clientInfo': (BuildContext context) => UserInfo(),
        '/allInfo': (BuildContext context) => AllInfo(), ///This page that displays all of the information the user provided to confirm before submitting the inquiry
        '/confirmation': (BuildContext context) => Confirmation(),
      }
    );
  }
}