///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019
///
/// This dart file is what displays the information that the user provided back to the user. It list out the order info then the client information
/// before displaying a button that allows you to send the email to Happy Cake Company


import 'package:flutter/material.dart';
import 'data.dart';
import 'package:happy_cake/emailer.dart';

class AllInfo extends StatefulWidget {
  @override
  _AllInfoState createState() => _AllInfoState();
}

class _AllInfoState extends State<AllInfo> {
  ///Checks if the email actually sent, set to false
  bool submitted = false;

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
          title: Text('Your Request'), centerTitle: true, ///The title of the page, and is centered

        ),

        ///This gesture detector is for swiping the page left and right
        body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == 0)
            return;
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },
        child: Container(

          ///The majority of the pages are in ListView because it avoided the issue of widgets overlaying each other. It allows the user to scoll up and down
          ///if the content of the pages does not fit the screen.
            child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  
              children: <Widget>[ ///This allows us to declare multiple children with in the ListView

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          Text( ///Header before the cake request is displayed back to user
                            'Request:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          /// The next four texts below recall the information that the user entered before and then displays it back to the user.
                          /// This includes the date, feeds, occasion with a conditional which deals with other, and notes
                          Text(
                            (DataStore.date == '') ? '' : 'Date: ' + DataStore.date.substring(0,10),style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Serves:' + DataStore.feeds, style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            (DataStore.occasion == 'Other') ? 'Occasion: ' + DataStore.otherOccasion : 'Occasion: ' + DataStore.occasion, style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Notes: ' + DataStore.decorationNotes, style: TextStyle(fontSize: 18),
                          ),

                          Text( ///Header before the client information is displayed again
                            '\nYour Contact Information:\n',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),

                      /// The next four texts below recall the information that the user entered before and then displays it back to the user.
                      /// This includes the name, phone, email, and referral that does have a conditional for other

                      Text(
                        'Name: ' + DataStore.name, style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Phone: ' + DataStore.phone, style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Email: ' + DataStore.email, style: TextStyle(fontSize: 18)

                      ),
                      Text(
                        (DataStore.referral == 'Other') ? 'Referral: ' + DataStore.otherReferral : 'Referral: ' + DataStore.referral, style: TextStyle(fontSize: 18),
                      ),

                      ],),
                    ),

                    ///This is called when the submit button has been pressed
                    ///STILL NEEDS A CONDITIONAL FOR WHEN IT IS NOT SENT
                    submitted
                        ? Text(
                            'Your order has been sent!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          )

                    ///Submit button which sends the email and moves to the next page
                        : ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100.0)),
                            color: Colors.green[300],
                            splashColor: Theme.of(context).accentColor,
                            onPressed: () {
                              sendEmail();
                              Navigator.of(context).pushNamed('/confirmation');
                            }
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  void sendEmail() async {
    String emailText = '''
    <b>Customer Info</b><br/>
    Name: ${DataStore.name}<br/>
    Email: ${DataStore.email}<br/>
    Phone: ${DataStore.phone}<br/>
    <br/>
    <b>Order Info</b><br/>
    Date needed: ${DataStore.date}<br/>
    Size: ${DataStore.feeds} people<br/>
    Function: ${DataStore.occasion}<br/>
    Decoration notes: ${DataStore.decorationNotes}<br/>
    ''';
    Emailer.email(DataStore.name, DataStore.email, emailText, DataStore.attachment).then((dynamic) {
      setState(() {
        submitted = true;
      });
    }, onError: (e) {
      print(e);
    });
  }
}
