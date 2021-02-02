import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  const BottomBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        selectedItemColor: Colors.amber[800],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Our Content',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Boy Names',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.pink),
            label: 'Girl Names',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Content'
          )
        ],
     );
  }
}