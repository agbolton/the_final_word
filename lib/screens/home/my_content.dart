import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../components/profile_data.dart';
import '../../models/profile.dart';

class MyContent extends StatefulWidget {

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Profile>>.value(
      value: DatabaseService().profiles,
      child: ProfileData()
    );
  }
}