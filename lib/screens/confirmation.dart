import 'package:flutter/material.dart';
import 'data.dart';
import 'package:happy_cake/emailer.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Confirmation'),
        ),
        body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == 0)
            return;
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Order:                                    \n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    DataStore.flavor,
                  ),
                  Text(
                    DataStore.feeds + ' people',
                  ),
                  Text(
                    DataStore.function,
                  ),
                  Text(
                    DataStore.date,
                  ),
              ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Thank you for choosing Happy Cake Company, we will review your request and follow-up shortly.'),
                  Text(
                    'Contact us at:\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                  ),
                  Text(
                    '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455',
                  ),
                  Text(
                    'Please call us with any additional info.',
                  ),
              ],),
              submitted
                  ? Text(
                      'Your order has been sent!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    )
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
                      color: Colors.blue[300],
                      splashColor: Theme.of(context).accentColor,
                      onPressed: sendEmail,
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Icon(Icons.arrow_back),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    color: Colors.green[300],
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                  ),
                ],)
              ],
            ),
          )
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
    Function: ${DataStore.function}<br/>
    Flavor combination: ${DataStore.flavor}<br/>
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
