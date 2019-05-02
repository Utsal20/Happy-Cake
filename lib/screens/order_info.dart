import 'package:flutter/material.dart';
import 'dart:core';
import 'data.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  File galleryFile;

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
            _validateInputs();
          else
            Navigator.of(context).pop();
        },
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
            child: Column(children: <Widget>[
              Flexible(
                  child: Form(
                      key: _orderKey,
                      autovalidate: _autoValidate,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: InkWell(
                                onTap: (){
                                  _selectDate();
                                },
                                child: IgnorePointer(
                              child: TextFormField(
                                initialValue: 'Click Here to Select Date',
                                decoration: InputDecoration(
                                  labelText: 'Order Date:',
                                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                ),
                                ),
                            ),),),
                            Flexible(
                              child: TextFormField(
                                  initialValue: DataStore.feeds,
                                  decoration: InputDecoration(
                                    hintText: 'Ex: 200',
                                    labelText: 'How many people:',
                                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (String value) {
                                    DataStore.feeds = value;
                                  },
                                  validator: _peopleValidator,
                                  ),
                            ),
                            Row(
                              //Created a row to put text next to the drop down menu, text align is trash
                              children: <Widget>[
                                Text(
                                  'Function:   ',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Flexible(
                                  child: DropdownButtonFormField<String>(
                                    value: DataStore.function,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        DataStore.function = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Select',
                                      'Birthday',
                                      'Kids',
                                      'Wedding'
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
                            Flexible(
                              child: TextFormField(
                                  initialValue: DataStore.flavor,
                                  decoration: InputDecoration(
                                    hintText: 'Ex: Chocolate/Rasberry',
                                    labelText: 'Flavor Combination:',
                                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  ),
                                  keyboardType: TextInputType.text,
                                  onSaved: (String value) {
                                    DataStore.flavor = value;
                                  },
                                  validator: _flavorValidator,
                                  ),
                            ),
                            Flexible(
                                child: TextFormField(
                                    initialValue: DataStore.decorationNotes,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Ex: I want the cake to be yellow flowers',
                                      labelText: 'Decoration Notes:',
                                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    ),
                                    keyboardType: TextInputType.text,
                                    maxLines: null,
                                    onSaved: (String value) {
                                      DataStore.decorationNotes = value;
                                    },
                                    validator: _descriptionValidator,
                                    )),
                            Flexible(
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
                          ]))),

              Container( 
                padding:EdgeInsets.only(bottom: 40),
                child: RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                  color: Colors.green[300],
                  splashColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _validateInputs();
                  },

              ),),
            ]
            )
        )
      )
    );
  }

  bool _validateInputs() {
    if (_orderKey.currentState.validate()) {
      _orderKey.currentState.save();
      Navigator.of(context).pushNamed('/b');
      return true;
    } else {
      setState((){
        _autoValidate = true;
      });
      return false;
    }
  }

  DateTime selectedDate = DateTime.now().add(Duration(days: 7));

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

  _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      print('Date picked: ${picked.toString()}');
      selectedDate = picked;
      setState(() {DataStore.date = picked.toString(); });
    }
  }

  String _peopleValidator (String value) {
    if(value.isEmpty) {
      return 'How many people will this cake feed';
    }
    return null;
  }

  String _flavorValidator (String value) {
    if(value.isEmpty) {
      return 'Please enter a flavor';
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
