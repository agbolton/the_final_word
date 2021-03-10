import 'package:flutter/material.dart';
import 'package:the_final_word/screens/home/My_Content/movies.dart';
import 'My_Content/boys.dart';
import 'My_Content/girls.dart';


class MyContent extends StatefulWidget {
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  static const tabs = [
    Tab(icon: Icon(Icons.person, color: Colors.white), text: 'Boy Names', iconMargin: EdgeInsets.all(1)),
    Tab(icon: Icon(Icons.person, color: Colors.white), text: 'Girl Names', iconMargin: EdgeInsets.all(1)),
    Tab(icon: Icon(Icons.movie), text: 'Movies', iconMargin: EdgeInsets.all(1))
  ];

  final screens = [BoysMyContent(), GirlsMyContent(), MoviesMyContent()];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(child: TabBar(tabs: tabs), color: Colors.indigo[300]),
            ),
            body: TabBarView(
              children: screens,
            )));
  }
}
