import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Cake',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Happy Cake'),
        ),
        body: Center(
          child: Text('Thanks for visiting!'),
        ),
      ),
    );
  }
}
