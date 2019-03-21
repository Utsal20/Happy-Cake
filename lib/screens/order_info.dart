import 'package:flutter/material.dart';
import 'dart:core';
import 'data.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();

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
          if (details.primaryVelocity.compareTo(0) == -1) {
            saveOrderInfo();
            Navigator.of(context).pushNamed('/b');
          }
        },
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
            child: Column(children: <Widget>[
              Flexible(
                  child: Form(
                      key: _orderKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: RaisedButton(
                                child: Icon(Icons.calendar_today),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.blue[300],
                                splashColor: Colors.blue[300],
                                onPressed: _selectDate,
                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                  initialValue: DataStore.feeds,
                                  decoration: InputDecoration(
                                    hintText: 'Ex: 200',
                                    labelText: 'How many people:',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onSaved: (String value) {
                                    DataStore.feeds = value;
                                  }),
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
                                  child: DropdownButton<String>(
                                    value: DataStore.function,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        DataStore.function = newValue;
                                      });
                                    },
                                    items: <String>[
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

                                    isExpanded: true, //Expands it across screen
                                    elevation: 12, //depth of drop down menu
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
                                  ),
                                  keyboardType: TextInputType.text,
                                  onSaved: (String value) {
                                    DataStore.flavor = value;
                                  }),
                            ),
                            Flexible(
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
                                    }))
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
                    saveOrderInfo();
                    Navigator.of(context).pushNamed('/b');
                  }
              ),),
            ]
            )
        )
      )
    );
  }

  _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      print('Date picked: ${picked.toString()}');
      setState(() { DataStore.date = picked.toString(); });
    }
  }

  void saveOrderInfo() {
    _orderKey.currentState.save();
  }
}
