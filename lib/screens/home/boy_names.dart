import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../services/sql_db.dart';
import '../../models/baby_name.dart';
import '../../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import 'package:the_final_word/components/loading.dart';
import 'package:flutter/services.dart';
import '../../models/baby_db.dart';

const DB_CREATE_PATH = 'assets/boy_names_2018.json';

class BoyNames extends StatefulWidget {
  @override
  _BoyNamesState createState() => _BoyNamesState();
}

class _BoyNamesState extends State<BoyNames> {
  int boyId;
  Names names = Names();

  BabyName newName = BabyName();

  void initState() {
    super.initState();
    initId();
  }

  void initId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      boyId = prefs.getInt('boyId') ?? 1;
    });
    getName(boyId);
  }

  void updateId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    boyId = boyId + 1;
    prefs.setInt('boyId', boyId);
    getName(boyId);
  }

  void getName(int boyId) async {
    final database = DatabaseInstance.getInstance();
    BabyName pullName = await database.getNewBoyName(boyId);
    setState(() {
      newName = pullName;
    });
  }

  void addNametoDatabase(String uid, List<String> names) async {
    final CollectionReference userProfile =
        FirebaseFirestore.instance.collection('profiles');

    return userProfile
        .doc(uid)
        .update({'boys_names': FieldValue.arrayUnion(names)}).catchError(
            (onError) => print('Failed to add'));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);
    if (newName.name == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<Profile>(
        stream: DatabaseService(uid: user.uid).profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;
            return Center(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 175.0),
                  child: Text('${newName.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 75,
                          color: Colors.blue[900]))),
              Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.red)),
                          child: IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.red,
                            iconSize: 80,
                            onPressed: updateId,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.green)),
                          child: IconButton(
                              icon: Icon(Icons.check),
                              color: Colors.green,
                              iconSize: 80,
                              onPressed: () async {
                                setState(() {
                                  profile.boys_names.add(newName.name);
                                  addNametoDatabase(
                                      profile.uid, profile.boys_names);
                                });
                                updateId();
                              }),
                        ),
                      )
                    ],
                  ))
            ]));
          } else {
            return Loading();
          }
        });
  }
}
