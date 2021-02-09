import 'package:flutter/material.dart';
import 'package:the_final_word/components/loading.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import '../../models/babynames.dart';
import '../../services/database.dart';

class MyBoy extends StatefulWidget {
  @override
  _MyBoyState createState() => _MyBoyState();
}

class _MyBoyState extends State<MyBoy> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BabyName>(
        stream: BabyNameService(gender: "male").name,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BabyName babyname = snapshot.data;
            //print(babyname.name);
            return Container(
                color: Colors.blue[600],
                alignment: Alignment.center,
                child: Text('${babyname.name}'));
          } else {
            return Loading();
          }
        });
  }
}
