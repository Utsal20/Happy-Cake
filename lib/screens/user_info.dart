import 'package:flutter/material.dart';
import 'data.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final GlobalKey<FormState> _clientKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _other = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Client Info'),
        ),
        body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity == 0) return;
              if (details.primaryVelocity.compareTo(0) == -1)
                if(_validateInputs())
                Navigator.of(context).pushNamed('/confirmation');
              if (details.primaryVelocity.compareTo(0) != -1)
                Navigator.of(context).pop();
            },

          child: Form(
            key: _clientKey,
            autovalidate: _autoValidate,

              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),



                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),

                      child: TextFormField(
                          initialValue: DataStore.name,
                          decoration: InputDecoration(
                            hintText: 'John Doe',
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (String value) {
                            DataStore.name = value;
                          }),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),

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

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),

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

                    Container(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'How did you hear about us?  ',
                            textAlign: TextAlign.left,
                            style:
                            Theme.of(context).textTheme.subhead,
                          ),
                          Flexible(
                            child: DropdownButtonFormField<String>(
                              value: DataStore.referral,
                              onChanged: (String newValue) {
                                setState(() {
                                  DataStore.referral = newValue;
                                });
                                if (DataStore.referral == 'Other') {
                                  _other = true;
                                } else {
                                  _other = false;
                                }
                              },
                              items: <String>[
                                'Select',
                                'Referral',
                                'Google',
                                'Yelp',
                                'Other',
                              ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: (_other == true) ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.only(bottom: 0.0),

                child: Visibility(
                    visible: _other,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText:
                        'Enter how you heard about us',
                        labelText: 'Other Referral',
                      ),
                      onSaved: (String value) {
                        DataStore.otherReferral = value;
                      },
                    )),
              ),

                    Container(
                        padding: EdgeInsets.fromLTRB(50,0,50,40),

                            child: RaisedButton(
                                child: Icon(Icons.arrow_forward),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                color: Colors.green[300],
                                splashColor: Theme.of(context).accentColor,
                                onPressed: () {
                                  if(_validateInputs())
                                    Navigator.of(context).pushNamed('/confirmation');
                                }),
                        )

                  ],
                  ),
          )
            ));
  }

  bool _validateInputs() {
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

  String _nameValidation (String value) {
    if(value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String _emailValidation(String value) {
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

  String _phoneValidation(String value) {
    if (value.length != 10) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }
}
