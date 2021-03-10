import 'package:flutter/material.dart';
import 'package:the_final_word/screens/home/Our_Content/boys.dart';
import 'package:the_final_word/screens/home/Our_Content/movies.dart';
import '../home/Our_Content/girls.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurContent extends StatefulWidget {
  const OurContent({Key key}) : super(key: key);
  @override
  _OurContentState createState() => _OurContentState();
}

class _OurContentState extends State<OurContent> {
  final formKey = GlobalKey<FormState>();
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('profiles');
  String code;
  Profile profile = Profile();
  Profile friendProfile = Profile();

  void initState() {
    super.initState();
  }

  static const tabs = [
    Tab(icon: Icon(Icons.person, color: Colors.white), text: 'Boy Names', iconMargin: EdgeInsets.all(1)),
    Tab(icon: Icon(Icons.person, color: Colors.white), text: 'Girl Names', iconMargin: EdgeInsets.all(1)),
    Tab(icon: Icon(Icons.movie), text: 'Movies', iconMargin: EdgeInsets.all(1))
  ];

  final screens = [BoysOurContent(), GirlsOurContent(), MoviesOurContent()];

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
