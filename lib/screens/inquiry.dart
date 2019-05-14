import 'package:flutter/material.dart';
import 'dart:core';

class InquiryPage extends StatefulWidget {
  @override
  _InquiryPageState createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity == 0) return;
              if (details.primaryVelocity.compareTo(0) == -1)
                Navigator.of(context).pushNamed('/orderInfo');
            },
            child: Container(
              padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Text(
                  'Welcome to the Happy Cake Company App.\n\nHere, you will be able to submit an order inquiry once you have given us information about the cake you would like and information about how we can contact you.\n\nOnce the form is completed you should receive an email confirming that inquiry request was submitted and we will get back to you as fast as we can for further discussion.',
                ),
                Container(
                    padding: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      child: Icon(Icons.arrow_forward),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      color: Colors.green[300],
                      splashColor: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/orderInfo');
                      },
                    ))
              ],
            ))));
  }
}
