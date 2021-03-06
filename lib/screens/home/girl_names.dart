import 'package:flutter/material.dart';
import '../../services/sql_db.dart';
import '../../models/baby_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GirlNames extends StatefulWidget {
  @override
  _GirlNamesState createState() => _GirlNamesState();
}

class _GirlNamesState extends State<GirlNames> {

  int girlId;

  BabyName newName = BabyName();

  void initState() {
    super.initState();
    //addSomeNames();
    initId();
  }

  // void addSomeNames() async {
  //   final database = DatabaseInstance.getInstance();
  //   BabyName name1 = BabyName(girlId: '1', name: 'Rachael', gender: 'female');
  //   BabyName name2 = BabyName(girlId: '2', name: 'Ann', gender: 'female');
  //   BabyName name3 = BabyName(girlId: '3', name: 'Gina', gender: 'female');
  //   BabyName name4 = BabyName(girlId: '4', name: 'Ashley', gender: 'female');
  //   BabyName name5 = BabyName(girlId: '5', name: 'Jill', gender: 'female');
  //   BabyName name6 = BabyName(girlId: '6', name: 'Emily', gender: 'female');
  //   database.saveGirlName(name: name1);
  //   database.saveGirlName(name: name2);
  //   database.saveGirlName(name: name3);
  //   database.saveGirlName(name: name4);
  //   database.saveGirlName(name: name5);
  //   database.saveGirlName(name: name6);
  // }

  void initId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState( () {
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
    setState( () {
      newName = pullName;
    });    
  }
  
  @override
  Widget build(BuildContext context) {

    if (newName == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Center(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 220.0), 
          child: Text('${newName.name}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.pink[600])
          )),
      Padding(
          padding: EdgeInsets.only(top: 100.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              icon: Icon(Icons.stop_circle_outlined),
              color: Colors.red,
              iconSize: 80,
              onPressed: updateId
            ),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {}
            ),
            IconButton(
              icon: Icon(Icons.check_box),
              color: Colors.green,
              iconSize: 80,
              onPressed: updateId
            )
          ]))
    ]));
  }
}
