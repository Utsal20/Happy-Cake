import 'package:flutter/material.dart';
import 'data.dart';
import 'package:happy_cake/emailer.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Info',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DataStore.flavor,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    DataStore.feeds + ' people',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    DataStore.function,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    DataStore.date,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Please call us with any additional info.',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            RaisedButton(
                child: Icon(Icons.pregnant_woman),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                color: Colors.green[300],
                splashColor: Colors.blue[300],
                onPressed: sendEmail,
              ),
          ],
        )
      )
    );
  }
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
    Function: ${DataStore.function}<br/>
    Flavor combination: ${DataStore.flavor}<br/>
    Decoration notes: ${DataStore.decorationNotes}<br/>
    ''';
  Emailer.email(DataStore.name, emailText);
}
