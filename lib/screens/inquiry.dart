///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019

///This file is the opening screen for the app where the user will be given information on what the app is meant to do for them
///It highlights the important parts of the process and thanks them for choosing Happy Cake Company

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

          ///The beginning of all the screens will have this text theme for the titles it just makes the font bigger and bolded
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),


          ),
          title: Text('About Our App') , centerTitle: true, ///Title of the app and it is centered

        ),

        ///This gesture detector is for swiping the page left and right
        ///On this page specifically it only goes to the right
        body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity == 0) return;
              if (details.primaryVelocity.compareTo(0) == -1)
                Navigator.of(context).pushNamed('/orderInfo');
            },

            ///The majority of the pages are in ListView because it avoided the issue of widgets overlaying each other. It allows the user to scoll up and down
            ///if the content of the pages does not fit the screen.
            child: ListView(

              ///this is the padding around the ListView container
              padding: EdgeInsets.fromLTRB(30, 10, 30, 30),

                ///This allows us to declare multiple children with in the ListView
                children: <Widget>[

                ///Everything on this page was put into a column as it kept everything organized
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, ///Allows it to fit the page
                children: <Widget>[ ///Allows children within the column

                Image.asset(///displays the given image with a set size
                    'lib/icon_alpha.png', height: 90, width: 90
                ),

                ///Multiple different texts being displayed explaining what the app will do with varying font sizes, weights, and styles

                Text('\nWelcome!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('\nThank you for choosing Happy Cake Company.\n\nThis app will conveniently:\n', style: TextStyle(fontSize:18)),
                Text('- Get quotes for cakes/cupcakes\n- Reserve dates for upcoming orders\n- Send pictures of cake concepts\n- Communicate with cake designers\n', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
                Text('Upon submitting the inquiry form, you will recieve an email confirmation. Through the email provided, a member of our team will follow-up and review your cake ideas and options for your order.\n', style: TextStyle( fontSize: 18)),
                Text('Thank you!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),


                Container(///This container may not be necessary, but it is holding the button
                    padding: EdgeInsets.only(top: 20),
                    child: RaisedButton( ///Next page button
                      child: Icon(Icons.arrow_forward),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      color: Colors.green[300],
                      splashColor: Theme.of(context).accentColor, ///When button is pressed it changes colors
                      onPressed: () {
                        Navigator.of(context).pushNamed('/orderInfo'); ///When pressed it goes to the next page
                      },
                    ))

                ])],
            )));

  }
}
