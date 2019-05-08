
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
decoration: InputDecoration(
labelText: 'Date Needed:',
),
controller: _textController,
validator: _dateValidator,
),
),),),
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
},
validator: _peopleValidator,
),
),
Row(
//Created a row to put text next to the drop down menu, text align is trash
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
Flexible(
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
))),
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