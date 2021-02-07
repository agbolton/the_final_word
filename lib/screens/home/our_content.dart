import 'package:flutter/material.dart';
import '../../components/placeholder_widget.dart';
import '../../services/auth.dart';
import 'my_content.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'The Final Word';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [ 
                    OurContent(),
                    PlaceholderWidget(Colors.deepOrange),
                    PlaceholderWidget(Colors.green),
                    MyContent()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('Logout', style: TextStyle(color: Colors.black)),
          )
        ],
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