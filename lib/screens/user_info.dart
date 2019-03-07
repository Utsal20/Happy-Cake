import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final GlobalKey<FormState> _clientKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _phone;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
        child: Column(
          children: <Widget>[
            Text(
              'Client Info',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline,
            ),
            Flexible(
              child: Form(
                key: _clientKey,
                autovalidate: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          labelText: 'Name',
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (String value) {
                          _name = value;
                        }
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '1234567890',
                          labelText: 'Phone',
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (String value) {
                          _phone = value;
                        },
                        validator: _phoneValidation,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          _email = value;
                        },
                        validator: _emailValidation,
                      ),
                    ),
                  ]
                )
              )
            ),
            RaisedButton(
              child: Icon(Icons.pregnant_woman),
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
              color: Colors.green[300],
              splashColor: Colors.blue[300],
              onPressed: _sendEmail,
            ),
          ],
        )
      )
    );
  }
  void _sendEmail() {
    if (_ValidateInputs()) {

    }
  }
  bool _ValidateInputs() {
    if (_clientKey.currentState.validate()) {
      _clientKey.currentState.save();
      return true;
    } else {
      setState(() {
        _autoValidate = true;
      });
      return false;
    }
  }
  String _emailValidation (String value) {
    if (value.isEmpty) {
      return 'Please enter a valid email address';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
  }
  String _phoneValidation (String value) {
    if (value.length != 10) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }
}
