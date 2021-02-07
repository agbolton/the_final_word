import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<QuerySnapshot>(context);
    //print(users.docs);
    for (var doc in users.docs) {
      print(doc.data());
    }

    return Container(
      
    );
  }
}