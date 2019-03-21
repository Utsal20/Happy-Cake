import 'package:flutter/material.dart';
import 'data.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final GlobalKey<FormState> _clientKey = GlobalKey<FormState>();
  bool _autoValidate = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Info'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == 0)
            return;
          if (details.primaryVelocity.compareTo(0) == -1)
            _validateInputs();
          else
            Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Form(
                  key: _clientKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Flexible(
                        child: TextFormField(
                          initialValue: DataStore.name,
                          decoration: InputDecoration(
                            hintText: 'John Doe',
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (String value) {
                            DataStore.name = value;
                          }
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: DataStore.phone,
                          decoration: InputDecoration(
                            hintText: '1234567890',
                            labelText: 'Phone',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            DataStore.phone = value;
                          },
                          validator: _phoneValidation,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: DataStore.email,
                          decoration: InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String value) {
                            DataStore.email = value;
                          },
                          validator: _emailValidation,
                        ),
                      ),
                    ]
                  )
                )
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    RaisedButton(
                      child: Icon(Icons.arrow_forward),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                      color: Colors.green[300],
                      splashColor: Theme.of(context).accentColor,
                      onPressed: () {
                        _validateInputs();
                      }
                    ),
                ],)
              ),
            ],
          )
        )
      )
    );
  }
  
  bool _validateInputs() {
    if (_clientKey.currentState.validate()) {
      _clientKey.currentState.save();
      Navigator.of(context).pushNamed('/c');
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
