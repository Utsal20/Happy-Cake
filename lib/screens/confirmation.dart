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
          title: Text('Order Request Confirmation'),
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
            child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Your Order:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            (DataStore.date == '') ? '' : DataStore.date.substring(0,10),
                          ),
                          Text(
                            DataStore.feeds + ' people',
                          ),
                          Text(
                            (DataStore.occasion == 'Other') ? DataStore.otherOccasion : DataStore.occasion,
                          ),
                          Text(
                            DataStore.decorationNotes,
                          ),
                      ],),
                    ),
                    Container(padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Thank you for choosing Happy Cake Co!\nWe will review your request and follow-up shortly.'),
                      ],),
                    ),
                    Container(padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
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
                            '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455',
                          ),
                          Text(
                            'Please call us with any additional info.',
                          ),
                      ],),
                    ),
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
                            color: Colors.green[300],
                            splashColor: Theme.of(context).accentColor,
                            onPressed: sendEmail,
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
