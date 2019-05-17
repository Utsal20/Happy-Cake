import 'package:flutter/material.dart';
import 'data.dart';
import 'package:happy_cake/emailer.dart';

class AllInfo extends StatefulWidget {
  @override
  _AllInfoState createState() => _AllInfoState();
}

class _AllInfoState extends State<AllInfo> {
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(
            title: TextStyle(
              ///fontFamily: 'Anton',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text('Your Request'), centerTitle: true,

        ),
        body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == 0)
            return;
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },
        child: Container(
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
                            'Request:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
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

                          Text(
                            '\nYour Contact Information:\n',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),
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
