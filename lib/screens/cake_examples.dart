import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';

class CakeExamples extends StatefulWidget {
  @override
  _CakeExamplesState createState() => _CakeExamplesState();
}

class _CakeExamplesState extends State<CakeExamples>{

  @override
  Widget build(BuildContext context) {
    final title = "Cake Examples";

    return MaterialApp(
        title: title,
        home: Scaffold(appBar: AppBar(
          title: Text(title),
        ),
            body: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: ChoiceCard(choice: choices[index], item: choices[index]),
                  );
                }
                )
            )
        )
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
  const Choice(title: 'Here is a lot of cake information', icon: Icons.cake),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key, this.choice, this.onTap, @required this.item, this.selected: false}
      ) : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;



  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            new Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                child: Icon(choice.icon, size:80.0, color: textStyle.color,)),
            new Expanded(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child:
                  Text(choice.title, style: null, textAlign: TextAlign.left, maxLines: 5,),
                )
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
    );
  }
}
