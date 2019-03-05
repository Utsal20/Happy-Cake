import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _clientKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Client Info',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline,
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  labelText: 'Phone',
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}