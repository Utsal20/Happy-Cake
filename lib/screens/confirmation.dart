import 'package:flutter/material.dart';
import 'user_info.dart';

class ConfirmationData {
  String name;
  static String email = 'asdsad';
  String phone;
  set _email(String e) => email = e;
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
                    'Flavor Combination Goes Here',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    ConfirmationData.email,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Occasion For the Cake Goes Here',
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
                    'Your Order will be ready on goes here',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Please call us with any additional info',
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