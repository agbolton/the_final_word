import 'package:flutter/material.dart';
import '../../services/sql_db.dart';
import '../../models/baby_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoyNames extends StatefulWidget {
  @override
  _BoyNamesState createState() => _BoyNamesState();
}

class _BoyNamesState extends State<BoyNames> {
  int boyId;

  BabyName newName = BabyName();

  void initState() {
    super.initState();
    addSomeNames();
    initId();
  }

  void addSomeNames() async {
    final database = DatabaseInstance.getInstance();
    BabyName name1 = BabyName(id: '1', name: 'Ron', gender: 'male');
    BabyName name2 = BabyName(id: '2', name: 'Adam', gender: 'male');
    BabyName name3 = BabyName(id: '3', name: 'George', gender: 'male');
    BabyName name4 = BabyName(id: '4', name: 'Eric', gender: 'male');
    BabyName name5 = BabyName(id: '5', name: 'Jack', gender: 'male');
    BabyName name6 = BabyName(id: '6', name: 'Marcus', gender: 'male');
    database.saveBoyName(name: name1);
    database.saveBoyName(name: name2);
    database.saveBoyName(name: name3);
    database.saveBoyName(name: name4);
    database.saveBoyName(name: name5);
    database.saveBoyName(name: name6);
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

  @override
  Widget build(BuildContext context) {
    if (newName.name == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Center(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 220.0),
          child: Text('${newName.name}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: Colors.pink[600]))),
      Padding(
          padding: EdgeInsets.only(top: 100.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                icon: Icon(Icons.stop_circle_outlined),
                color: Colors.red,
                iconSize: 80,
                onPressed: updateId),
            IconButton(icon: Icon(Icons.help), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.check_box),
                color: Colors.green,
                iconSize: 80,
                onPressed: updateId)
          ]))
    ]));
  }
}
