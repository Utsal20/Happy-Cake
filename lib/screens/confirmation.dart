///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019

///This page thanks the user for choosing Happy Cake Company and gives them contact information to reach the company if there are any issues.
///This was implemented so the app felt like it had an end to it rather than just submitting the email and leaving the user clueless.


import 'package:flutter/material.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        ///The beginning of all the screens will have this text theme for the titles it just makes the font bigger and bolded
      textTheme: TextTheme(
          title: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text('Request Confirmation'), centerTitle: true, ///The title of the page and it's centered
      ),
      body: GestureDetector(  ///This gesture detector is for swiping the page left and right

        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },
        child: Column( ///A column is a simple way to organize and display the text below
          
          children: <Widget>[
            Container(padding: const EdgeInsets.fromLTRB(30,30,30,30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Thank you for choosing Happy Cake Company!\n', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                          Text( 'We will review your request and follow-up shortly.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ],),
                    ),



                    Container(padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column( ///Another column and container displaying the contact information for the store
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Contact us at:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                          ),
                          Text(
                            '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455', style: TextStyle(fontSize:16, fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Please call us with any additional info.',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold)
                          ),
                      ],),
                    ),
          ],
        )
      ),
    );
  }
}