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
  TextEditingController _textController;
  bool _autoValidate = false;
  bool _other = false;
  File galleryFile;

  @override
  void initState() {
    _textController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cake Order Request'),
      ),
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

          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),

            children: <Widget>[

              Container(

                child: InkWell(
                  onTap: (){
                    _selectDate();

                  },
                  child: IgnorePointer(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date Needed:',
                        ),
                        controller: _textController,
                        validator: _dateValidator,
                      ),
                    ),
                  ),),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

                child: TextFormField(
                  initialValue: DataStore.feeds,
                  decoration: InputDecoration(
                    hintText: 'Ex: 200',
                    labelText: 'How many people:',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (String value) {
                    DataStore.feeds = value;
                  },
                  validator: _peopleValidator,
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),

                child: Row(
                  children: <Widget>[
                    Text(
                      'What\'s the occasion?   ',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Flexible(
                      child: DropdownButtonFormField<String>(
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
                        items: <String>[
                          'Select',
                          'Birthday',
                          'Kids',
                          'Wedding',
                          'Graduation',
                          'Baby Shower',
                          'Other',
                        ].map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        validator: _dropdownValidator,
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
                        hintText: 'Please enter the occasion',
                        labelText: 'Other Occasion',
                      ),
                      onSaved: (String value) {
                        DataStore.otherOccasion = value;
                      },
                      validator: _otherValidator,
                    )),
              ),

          Container(

            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

            child: TextFormField(
                initialValue: DataStore.decorationNotes,
                decoration: InputDecoration(
                hintText:
                'Ex: I want the cake to be yellow flowers',
                labelText: 'Decoration Notes:',
                ),
                keyboardType: TextInputType.text,
                maxLines: null,
                onSaved: (String value) {
                DataStore.decorationNotes = value;
              },
             validator: _descriptionValidator,
              ),
          ),


            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),


              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Choose Sample Cakes'),
                      onPressed: imageSelectorGallery,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: (galleryFile!= null) ? Colors.green[300] : Colors.grey,
                    ),
                  ],
                ),
            ),

              Container(
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

  bool _validateInputs() {
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

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
    if (galleryFile != null){
      var systemTempDir = Directory("/data/user/0/com.example.happycake/cache/");
        systemTempDir.list(followLinks: false)
        .listen((FileSystemEntity entity) {
          if (entity.path.contains(".jpg"))
            setState(() {
              DataStore.attachment = entity.path;
              return;
            });
      });
    }
  }

  DateTime selectedDate = DateTime.now().add(Duration(days: 8));

  _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(Duration(days: 7)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      print('Date picked: ${picked.toString()}');
      selectedDate = picked;
      _textController.text = selectedDate.toString().substring(0,11); 
      setState(() {DataStore.date = picked.toString(); });
    }
  }

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
  String _otherValidator (String value) {
    if(value.isEmpty && DataStore.occasion == 'Other'){
      return 'Please specify the occasion';
    }
    return null;
  }
}
