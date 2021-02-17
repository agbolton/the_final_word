import 'package:cloud_firestore/cloud_firestore.dart';
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
    CollectionReference boy =
        FirebaseFirestore.instance.collection('baby names');

    return FutureBuilder<DocumentSnapshot>(
      future: boy.doc('male').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          var names = BabyNames(
              gender: 'male', names: snapshot.data.data().keys.toList());
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Click Below to Test'),
              Padding(
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      names.shuffle();
                    });
                  },
                  child: Text('${names.currentName}'),
                ),
              )
            ],
          );
        }

        return Text("loading");
      },
    );

    /*
    return StreamBuilder<BabyName>(
        stream: BabyNameService(gender: "male").name,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot);
            //print(babyname.name);
            return Container(
                color: Colors.blue[600],
                alignment: Alignment.center,
                child: Text('In Boys Name'));
          } else {
            return Loading();
          }
        });
      */
  }
}
