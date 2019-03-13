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
        body: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Order Info',
                        style: Theme.of(context).textTheme.headline,
                        textAlign: TextAlign.center,
                      ),
                    ]),
                Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'You Ordered:\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Contact us at:\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455',
                              ),
                              Text(
                                'Please call us with any additional info.',
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                submitted
                    ? Text(
                        'Your order has been sent!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                      )
                    : RaisedButton(
                        child: Text('Submit'),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        color: Colors.green[300],
                        splashColor: Colors.blue[300],
                        onPressed: sendEmail,
                      ),
              ],
            )));
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
    Emailer.email(DataStore.name, emailText).then((dynamic) {
      setState(() {
        submitted = true;
      });
    }, onError: (e) { print(e);});
  }
}
