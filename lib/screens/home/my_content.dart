import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import 'package:the_final_word/screens/home/My_Content/movies.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../components/profile_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'My_Content/boys.dart';
import 'My_Content/girls.dart';
import '../home/home.dart';

class MyContent extends StatefulWidget {
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  static const tabs = [
    Tab(icon: Icon(Icons.account_box_outlined)),
    Tab(icon: Icon(Icons.article_outlined)),
    Tab(icon: Icon(Icons.movie))
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
              flexibleSpace: TabBar(tabs: tabs),
            ),
            body: TabBarView(
              children: screens,
            )));
  }
}
