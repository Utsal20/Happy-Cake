import 'package:flutter/material.dart';
import 'package:happy_cake/screens/order_info.dart';
import 'package:happy_cake/screens/user_info.dart';
import 'package:happy_cake/screens/confirmation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
 class _HomeState extends State<Home> {
   int _currentIndex = 0;
   final List<Widget> _children = [OrderInfo(), UserInfo(), Confirmation()];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Happy Cake Co.'),
       ),
       body: _children[_currentIndex],
       bottomNavigationBar: BottomNavigationBar(
         onTap: onTapped,
         currentIndex: _currentIndex,
         items: [
           BottomNavigationBarItem(
             title: Text('Order Info'),
             icon: Icon(Icons.cake),
           ),
           BottomNavigationBarItem(
             title: Text('Client Info'),
             icon: Icon(Icons.account_box),
           ),
           BottomNavigationBarItem(
             title: Text('Order Confirmation'),
             icon: Icon(Icons.check_circle_outline),
           ),
         ]
       ),
    );
  }
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
  }
}