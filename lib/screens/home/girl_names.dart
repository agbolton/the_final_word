import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/babyName.dart';
import '../../services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyGirl extends StatefulWidget {
  @override
  _MyGirlState createState() => _MyGirlState();
}

class _MyGirlState extends State<MyGirl> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('baby names')
        .where('gender', isEqualTo: 'female')
        .limit(2)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.docs);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.all(50),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  var gender = data.data()['gender'].toString();

  if (gender != "female") {
    print("here");
  }

  var name = data.data()['name'].toString();

  return Padding(
    key: ValueKey(data.data()['name']),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 200.0),
    child: Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: GestureDetector(
        child: Text(name)
      ),
    ),
  );
}