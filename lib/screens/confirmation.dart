import 'package:flutter/material.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: TextTheme(
          title: TextStyle(
            ///fontFamily: 'Anton',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text('Request Confirmation'), centerTitle: true,
      ),
      body: GestureDetector(

        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity.compareTo(0) != -1)
            Navigator.of(context).pop();
        },
        child: Column(
          
          children: <Widget>[
            Container(padding: const EdgeInsets.fromLTRB(30,30,30,30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Thank you for choosing Happy Cake Company!\n', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                          Text( 'We will review your request and follow-up shortly.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ],),
                    ),
                    Container(padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Contact us at:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                          ),
                          Text(
                            '1312 N Mullan Rd.\nSpokane Valley, WA 99206\nTues-Sat 9-5pm\n509-924-8455', style: TextStyle(fontSize:16, fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Please call us with any additional info.',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold)
                          ),
                      ],),
                    ),
          ],
        )
      ),
    );
  }
}