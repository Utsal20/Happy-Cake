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
            child: ListView(
            shrinkWrap: true,
            children: <Widget>[ Container(
              padding: EdgeInsets.fromLTRB(20,0,20,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Image.asset('lib/icon_alpha.png'),
                Text(
                  'Welcome!\nThank you for choosing Happy Cake Company.\n\nThis app will allow you to conveniently:\n\n► Get quotes for cakes/cupcakes\n► Reserve date for upcoming orders\n► Send pictures of cake concepts\n► Communicate with cake designers\n\nUpon submitting the inquiry form, you will receive an email confirmation. Through the email provided, a member of our team will follow-up and review your cake ideas and options for your order.\n\nThank you!',
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
            ))],)));
  }
}
