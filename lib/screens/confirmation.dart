import 'package:flutter/material.dart';
import 'data.dart';

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
            )
          ],
        )
      )
    );
  }
}