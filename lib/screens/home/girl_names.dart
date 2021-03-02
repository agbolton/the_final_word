import 'package:flutter/material.dart';
import '../../services/get_name.dart';
import '../../services/sql_db.dart';
import '../../models/baby_name.dart';

class MyGirl extends StatefulWidget {
  @override
  _MyGirlState createState() => _MyGirlState();
}

class _MyGirlState extends State<MyGirl> {

  BabyName newName;

  void initState() {
    super.initState();
    // addSomeNames();
    getName(2);
  }

  // void addSomeNames() async {
  //   final database = DatabaseInstance.getInstance();
  //   BabyName name1 = BabyName(id: '1', name: 'Ron', gender: 'male');
  //   BabyName name2 = BabyName(id: '2', name: 'Adam', gender: 'male');
  //   BabyName name3 = BabyName(id: '3', name: 'John', gender: 'male');
  //   BabyName name4 = BabyName(id: '4', name: 'Ashley', gender: 'female');
  //   BabyName name5 = BabyName(id: '5', name: 'Jill', gender: 'female');
  //   BabyName name6 = BabyName(id: '6', name: 'Emily', gender: 'female');
  //   database.saveBabyName(name: name1);
  //   database.saveBabyName(name: name2);
  //   database.saveBabyName(name: name3);
  //   database.saveBabyName(name: name4);
  //   database.saveBabyName(name: name5);
  //   database.saveBabyName(name: name6);
  // }

  void getName(int id) async {
    final database = DatabaseInstance.getInstance();
    BabyName pullName = await database.getNewName(id);
    setState( () {
      newName = pullName;
    });    
  }
  
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.check_box),
              color: Colors.green,
              iconSize: 80,
              onPressed: () {},
            )
          ]))
    ]));
  }
}
