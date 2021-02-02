import 'package:flutter/material.dart';
import '../components/placeholder_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [ 
                    OurContent(),
                    PlaceholderWidget(Colors.deepOrange),
                    PlaceholderWidget(Colors.green),
                    PlaceholderWidget(Colors.red)];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        selectedItemColor: Colors.amber[800],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
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
            icon: Icon(Icons.home),
            label: 'My Content'
          )
        ],
     )
    );
  }
}

class OurContent extends StatefulWidget {

  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text('Our Content Page', 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black)),
        
      ])
    );
  }
}