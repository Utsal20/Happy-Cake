///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019
///
/// This page is a way for the user to tell Happy Cake Company what their contact information is so they can be reached after their order
/// has been reviewed. It asks for their name, number, and email.


import 'package:flutter/material.dart';
import 'data.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final GlobalKey<FormState> _clientKey = GlobalKey<FormState>();

  ///to validate the fields the user has to fill in, set to false so messages don't show before the user tries to submit
  bool _autoValidate = false;
  ///this is used when checking if the user chose other in the referral drop down
  bool _other = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          ///The beginning of all the screens will have this text theme for the titles it just makes the font bigger and bolded

        textTheme: TextTheme(
            title: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text('Contact Information'), centerTitle: true,
        ),

        ///This gesture detector is for swiping the page left and right
        body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity == 0) return;
              if (details.primaryVelocity.compareTo(0) == -1)
                if(_validateInputs())
                Navigator.of(context).pushNamed('/allInfo');
              if (details.primaryVelocity.compareTo(0) != -1)
                Navigator.of(context).pop();
            },

          child: Form(
            key: _clientKey,
            autovalidate: _autoValidate,


            ///The majority of the pages are in ListView because it avoided the issue of widgets overlaying each other. It allows the user to scoll up and down
            ///if the content of the pages does not fit the screen.
              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),

                ///This allows us to declare multiple children with in the ListView
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),

                      ///This textform field allows the user to input their name and then validates that they have input something
                      child: TextFormField(
                          initialValue: DataStore.name,
                          decoration: InputDecoration(
                            hintText: 'John Doe',
                            labelText: 'Name', labelStyle: TextStyle(fontSize: 18)
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (String value) {
                            DataStore.name = value; ///name is stored
                          },
                          validator: _nameValidation,
                          ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),

                      ///This textformfield allows the user to input a phone number and then checks the number is valid
                      child: TextFormField(
                        initialValue: DataStore.phone,
                        decoration: InputDecoration(
                          hintText: '1234567890',
                          labelText: 'Phone', labelStyle: TextStyle(fontSize: 18),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          DataStore.phone = value; ///phone number is stored
                        },
                        validator: _phoneValidation,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),


                      ///This text form field allows the user to input an email and then validates that email
                      child: TextFormField(
                        initialValue: DataStore.email,
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'Email', labelStyle: TextStyle(fontSize: 18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          DataStore.email = value; ///email is stored
                        },
                        validator: _emailValidation,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Row( ///displays the text and drop down menu right next to each other
                        children: <Widget>[
                          Text( ///This displays the title of the dropdown and then is modified to fit the theme
                            'How did you hear about us?  ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          Flexible(
                            child: DropdownButtonFormField<String>( ///this creates a drop down with multiple string options
                              value: DataStore.referral,
                              onChanged: (String newValue) {
                                setState(() {
                                  DataStore.referral = newValue; ///referral data is stored
                                });
                                if (DataStore.referral == 'Other') {///this checks to see if the user chooses other
                                  _other = true;
                                } else {
                                  _other = false;
                                }
                              },
                              items: <String>[ ///this list of options in the drop down menu
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

                child: Visibility( ///this functions creates another text field if the user chooses other and allows them to explain how they heard
                                    ///about Happy Cake Company
                    visible: _other,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText:
                        'Enter how you heard about us',
                        labelText: 'Other Referral',labelStyle: TextStyle(fontSize: 18),
                      ),
                      onSaved: (String value) {
                        DataStore.otherReferral = value; ///Referral is saved and displayed
                      },
                    )),
              ),

                    Container(
                            child: RaisedButton( ///Button that moves on to the next page
                                child: Icon(Icons.arrow_forward),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                color: Colors.green[300],
                                splashColor: Theme.of(context).accentColor,
                                onPressed: () {
                                  if(_validateInputs())
                                    Navigator.of(context).pushNamed('/allInfo');
                                }),
                        )

                  ],
                  ),
          )
            ));
  }


  ///This is the generic check of the validation for all of the validators.
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


  ///Validator to make sure something is typed in the name text field
  String _nameValidation (String value) {
    if(value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  ///This validator makes sure it is a valid email that follows the normal criteria of an email
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


  ///This makes sure the phone number is the right length
  String _phoneValidation(String value) {
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }
}
