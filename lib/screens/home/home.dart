import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'my_content.dart';
import 'our_content.dart';
import 'boy_names.dart';
import 'girl_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'The Final Word';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _view;
  int _currentIndex = 3;
  final List<Widget> _children = [
    OurContent(),
    BoyNames(),
    GirlNames(),
    MyContent(),
  ];

  void initState() {
    super.initState();
    initView();
  }

  void initView() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _view = prefs.getBool('view') ?? true;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onChange(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _view = value;
    });
    prefs.setBool('view', value);
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Content Option'),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              SwitchListTile(
                  title: Text('View Boys / Girl Names'),
                  value: _view,
                  onChanged: (bool value) {
                    onChange(value);
                  })
            ],
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Content')
          ],
        ));
  }
}
