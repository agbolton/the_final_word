import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/user_data.dart';

class MyContent extends StatefulWidget {

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: UserData()
    );
  }
}