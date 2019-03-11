import 'package:flutter/material.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  String _date;
  String _feeds; //Total people it feeds
  String _function = 'Birthday'; //What occasion
  String _flavor;
  String _decorationNotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, .1),
        child: Column(
          children: <Widget>[
            Text(
              'Order a Cake',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline,
            ),

            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'EX: January 12th, 2019',
                  labelText: 'Date need:',
                ),
                keyboardType: TextInputType.text,
                onSaved: (String value){
                  _date = value;
                }
              ),
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: 200',
                  labelText: 'How many people:',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String value){
                  _feeds = value;
                }
              ),
            ),
            Row( //Created a row to put text next to the drop down menu, text align is trash
              children: <Widget>[
                Text(
                  'Function:   ',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.subhead,
                      ),
                Flexible(
                  child: DropdownButton<String>(
                    value: _function,
                    onChanged: (String newValue){
                      setState(() {
                             _function = newValue;
                      });
                    },
                    items: <String>['Birthday', 'Kids', 'Wedding']
                        .map<DropdownMenuItem<String>>((String value) {
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
                decoration: InputDecoration(
                  hintText: 'Ex: Chocolate/Rasberry',
                  labelText: 'Flavor Combination:',
                ),
                keyboardType: TextInputType.text,
                onSaved: (String value){
                  _flavor = value;
                }
              ),
            ),

            Flexible(
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Ex: I want the cake to be yellow flowers',
                    labelText: 'Decoration Notes:',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSaved: (String value){
                    _decorationNotes = value;
                  }
              )
            )
          ]
        )
      )
    );
  }
}