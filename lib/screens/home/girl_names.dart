import 'package:flutter/material.dart';
import '../../services/sql_db.dart';
import '../../models/baby_name.dart';
import '../../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import 'package:the_final_word/components/loading.dart';
import '../../models/baby_db.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class GirlNames extends StatefulWidget {
  @override
  _GirlNamesState createState() => _GirlNamesState();
}

class _GirlNamesState extends State<GirlNames> {
  int girlId;
  Names names = Names();

  BabyName newName = BabyName();

  void initState() {
    super.initState();
    initId();
  }

  void initId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      girlId = prefs.getInt('girlId') ?? 1;
    });
    getName(girlId);
  }

  void updateId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    girlId = girlId + 1;
    prefs.setInt('girlId', girlId);
    getName(girlId);
  }

  void getName(int girlId) async {
    final database = DatabaseInstance.getInstance();
    BabyName pullName = await database.getNewGirlName(girlId);
    setState(() {
      newName = pullName;
    });
  }

  void addNametoDatabase(String uid, List<String> names) async {
    final CollectionReference userProfile =
        FirebaseFirestore.instance.collection('profiles');

    return userProfile
        .doc(uid)
        .update({'girls_names': FieldValue.arrayUnion(names)}).catchError(
            (onError) => print('Failed to add'));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);

    if (newName == null) {
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
                  padding: EdgeInsets.only(top: 175),
                  child: Text('${newName.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 75,
                          color: Colors.pink[800]))),
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
                              profile.girls_names.add(newName.name);
                              addNametoDatabase(
                                  profile.uid, profile.girls_names);
                            });
                            updateId();
                          })
                        ))],
                  ))
            ]));
          } else {
            return Loading();
          }
        });
  }
}
