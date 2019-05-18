///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019

///This page is what allows the user to start inputting the different details for their cakes, such as when it is needed by, the amount of people
///it will feed, the occasion, other details for the cake, and it will also allow you to attach an image.
///Most of these fields will require them to be filled before moving on to the next page.

import 'package:flutter/material.dart';
import 'dart:core';
import 'data.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();

  ///This controller is needed when calling the date selector to input the date in the text field
  TextEditingController _textController;
  ///Initial validator for each field is set to false so it does not show errors before user tries to move on
  bool _autoValidate = false;
  ///Initial value for 'other' is set to false, used when selecting the occasion
  bool _other = false;
  ///This is used when calling the image selector
  File galleryFile;

  @override
  void initState() {
    _textController = new TextEditingController();
    super.initState();
  }

  @override

  ///Cleans up the controller when the widget is removed
  void dispose(){
    _textController?.dispose();
    super.dispose();
  }

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
        title: Text('Order Request'), centerTitle: true, ///The title of the page, and is centered
      ),

      ///This gesture detector is for swiping the page left and right
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == 0)
            return;
          if (details.primaryVelocity.compareTo(0) == -1)
            if(_validateInputs())
              Navigator.of(context).pushNamed('/clientInfo');
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },

        child: Form(
          key: _orderKey,
          autovalidate: _autoValidate,

          ///The majority of the pages are in ListView because it avoided the issue of widgets overlaying each other. It allows the user to scoll up and down
          ///if the content of the pages does not fit the screen.
          child: ListView(

            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),

            ///This allows us to declare multiple children with in the ListView
            children: <Widget>[

              ///This container only holds the text field for the date
              Container(

                child: InkWell(
                  onTap: (){
                    _selectDate(); ///On tap opens up the calendar for the user to select the date, function towards the bottom

                  },
                  child: IgnorePointer(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

                      child: TextFormField(
                        decoration: InputDecoration(
                          ///Label above the text field
                          labelText: 'Date Needed:', labelStyle: TextStyle(fontSize: 18),
                        ),

                        ///TextController that was previously talked about which is used to display this date to user
                        controller: _textController,
                        validator: _dateValidator,
                      ),
                    ),
                  ),),
              ),

              Container( ///This container holds the second field which asks how many people need to be fed.
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

                child: TextFormField(
                  initialValue: DataStore.feeds,
                  decoration: InputDecoration(
                    hintText: 'Ex: 200', ///Hint text is what pops up when user taps the text field
                    labelText: 'How many people:',labelStyle: TextStyle(fontSize: 18),
                  ),

                  keyboardType: TextInputType.number, ///Pulls up a keyboard with numbers rather than text

                  onSaved: (String value) { ///How data is stored until app is closed or email is sent.
                    DataStore.feeds = value;
                  },
                  validator: _peopleValidator, ///Calls people validator which makes sure a number has been put into the field
                ),
              ),

              Container(///Container which holds the occasion field
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),

                child: Row( ///A row keeps the title and dropdown box next to each other
                  children: <Widget>[

                    ///The title of the drop down
                    Text(
                      'What\'s the occasion?   ',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, color: Colors.black54), ///Changed the style to fit the other themes
                    ),

                    Flexible(
                      child: DropdownButtonFormField<String>( ///This creates a dropdown menu for the user to select the occasion

                        ///This calls the value of occasion and then creates a new value when another is selected by the user.
                        ///It also checks if the user selected other
                        value: DataStore.occasion,
                        onChanged: (String newValue) {
                          setState(() {
                            DataStore.occasion = newValue;
                          });
                          if(DataStore.occasion == 'Other'){
                            _other = true;
                          } else {
                            _other = false;
                          }
                        },

                        ///These strings are the items within the drop down menu
                        items: <String>[
                          'Select',
                          'Birthday',
                          'Kids',
                          'Wedding',
                          'Graduation',
                          'Baby Shower',
                          'Other',


                        ].map<DropdownMenuItem<String>>( ///This finalizes the drop down menu and list the items as stated
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        validator: _dropdownValidator, ///This makes sure an occasion was chosen
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                ///This field is conditional, if the user selects other for occasion a text field is available for the user to input their own text... it is not required
              padding: (_other == true) ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.only(bottom: 0.0),

                child: Visibility( ///Visibility is what makes the child pop up when it is called
                    visible: _other,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Please enter the occasion',
                        labelText: 'Other Occasion', labelStyle: TextStyle(fontSize: 18)
                      ),
                      onSaved: (String value) {
                        DataStore.otherOccasion = value;
                      },
                    )),
              ),

          Container(

            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

            child: TextFormField( ///This is where the user can input as many details as they want to give the cake decorators a better idea
                initialValue: DataStore.decorationNotes,
                decoration: InputDecoration(
                hintText:
                'Ex: I want the cake to be yellow flowers',
                labelText: 'Decoration Notes:', labelStyle: TextStyle(fontSize: 18),
                ),
                keyboardType: TextInputType.text,
                maxLines: null,
                onSaved: (String value) {
                DataStore.decorationNotes = value;
              },
             validator: _descriptionValidator, ///This validator just requires something to be in the field
              ),
          ),


            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),


              child: Row( ///This places the button to select images and the icon to confirm image selection next to each other
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Choose Sample Cakes'),
                      onPressed: imageSelectorGallery,
                    ),
                    Icon(
                      Icons.check_circle, ///The icon changes color once an image has been selected
                      color: (galleryFile!= null) ? Colors.green[300] : Colors.grey,
                    ),
                  ],
                ),
            ),

              Container(///Another button which allows you to move onto the next page
                padding:EdgeInsets.only(bottom:40),
                child: RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                  color: Colors.green[300],
                  splashColor: Theme.of(context).accentColor,
                  onPressed: () {
                    if(_validateInputs())
                      Navigator.of(context).pushNamed('/clientInfo');
                  },

                ),),
            ],

          )

        )



      )
    );
  }

  bool _validateInputs() { ///This validates that the required fields were given legitimate information
    if (_orderKey.currentState.validate()) {
      _orderKey.currentState.save();
      return true;
    } else {
      setState((){
        _autoValidate = true;
      });
      return false;
    }
  }

///When an image is being selected it is then renamed as a .jpg file
  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
    if (galleryFile != null){
      String newPath = galleryFile.path+'.jpg';
      File(galleryFile.path).renameSync(newPath);
      setState(() {
       DataStore.attachment = newPath; 
      });
    }
  }

  DateTime selectedDate = DateTime.now().add(Duration(days: 7)); ///This helps put the current date out 7 days because

  _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(Duration(days: 6)),///forces the user to select at least a week out
      lastDate: DateTime.now().add(Duration(days: 365)),///the user can't go any farther than a year
    );
    if (picked != null && picked != selectedDate) {
      print('Date picked: ${picked.toString()}');
      selectedDate = picked;
      _textController.text = selectedDate.toString().substring(0,11); ///this is the text controller being displayed to show the date in the text field
      setState(() {DataStore.date = picked.toString(); }); ///the date is then stored
    }
  }


  ///The rest of these are the validator strings that are displayed to the user if the fields are filled correctly. This includes the date, the amount, the description and a function
  ///The other function is optional to fill out
  String _dateValidator (String value) {
    if(value.isEmpty) {
      return 'Please enter the date needed';
    }
    return null;
  }

  String _peopleValidator (String value) {
    if(value.isEmpty) {
      return 'How many people will this cake feed';
    }
    return null;
  }

  String _descriptionValidator (String value) {
    if(value.isEmpty) {
      return 'Please enter a description of the cake';
    }
    return null;
  }

  String _dropdownValidator (String value) {
    if(value == 'Select') {
      return 'Please enter a function';
    }
    return null;
  }
}
